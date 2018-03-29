
-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- decodeStage.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation for the fetch stage
-- of a multi-cycled, pipelined MIPS processor.
--
-- NOTES:
-- 3/28/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity decodeStage is
  port(clk	    	: in std_logic;
       RST	    	: in std_logic;
       RegWrite     	: in std_logic;
       RegDst     	: in std_logic;
       Link		: in std_logic;
       WriteData    	: in std_logic_vector(31 downto 0);
       instruction    	: in std_logic_vector(31 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       Rs_Data      	: out std_logic_vector(31 downto 0);
       Rt_Data      	: out std_logic_vector(31 downto 0);
       ALUOp		: out std_logic_vector(5 downto 0);
       Immed  		: out std_logic_vector(31 downto 0);
       shamt  		: out std_logic_vector(4 downto 0);
       DatatoPC		: out std_logic_vector(31 downto 0);
       Special		: out std_logic;
       Add4Out    	: out std_logic_vector(31 downto 0);
       instruct5_0    	: out std_logic_vector(5 downto 0);
       controlOut	: out std_logic_vector(4 downto 0));
end decodeStage;

architecture structure of decodeStage is

component controlLogic
  port(instruct31_26    : in std_logic_vector(5 downto 0);
       instruct5_0	: in std_logic_vector(5 downto 0);
       ALUOP	    	: out std_logic_vector(5 downto 0);
       RegWrite     	: out std_logic; --controlOut(2)
       MemtoReg	    	: out std_logic; --controlOut(0)
       MemWrite       	: out std_logic; --controlOut(1)
       RegDst       	: out std_logic; --controlOut(4)
       Branch       	: out std_logic;
       Bne		: out std_logic;
       Jump       	: out std_logic;     
       JumpRet       	: out std_logic; 
       Link       	: out std_logic); --controlOut(3)
end component;

component fulladderNbit
  generic(N : integer := 32);
  port(i_Cin        : in std_logic;
       i_A	    : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       o_Sum	    : out std_logic_vector(N-1 downto 0);
       overflow     : out std_logic;
       zero 	    : out std_logic;
       o_Cout	    : out std_logic);
end component;

component mips_extender is
  port(input            : in std_logic_vector(15 downto 0) := (others => '0');
       output          	: out std_logic_vector(31 downto 0):= (others => '0'));
end component;

component mipsRegister
  generic(N : integer := 32);
  port(DataIn             	: in std_logic_vector(N-1 downto 0);
       Rt_sel,Rs_sel,Wr_sel     : in std_logic_vector(4 downto 0);
       clk, RST, WE  		: in std_logic;
       Rs_data,Rt_data          : out std_logic_vector(N-1 downto 0));
end component;

component mux2to1Nbit is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

component mux2to15bit
  generic(N : integer := 5);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

component mux2to1
  port(i_A          : in std_logic;
       i_B	    : in std_logic;
       i_X	    : in std_logic;
       o_Y          : out std_logic);
end component;

signal sAdd4,sRt,sRs,sImmed,sBranchAdd,sBranchMux,sBranchShift,sJump,sJumpMux : std_logic_vector(31 downto 0);
signal instruct15_0 : std_logic_vector(15 downto 0);
signal instruct31_26,sALUOP,sinstruct5_0 : std_logic_vector(5 downto 0);
signal instruct25_21,instruct20_16,instruct15_11,sWrite,sWriteReg,reg31 : std_logic_vector(4 downto 0);
signal JumpControl,JumpRetControl,sBranch,sCarryIn,sNotZero,Zero,sZeroMux,BranchControl,BneControl,sBranchOR : std_logic;

begin 
  instruct31_26 <= instruction(31 downto 26);
  instruct25_21 <= instruction(25 downto 21);
  instruct20_16 <= instruction(20 downto 16);
  instruct15_11 <= instruction(15 downto 11);
  instruct15_0 <= instruction(15 downto 0);
  shamt <= instruction(10 downto 6);
  sinstruct5_0 <= instruction(5 downto 0);
  reg31 <= "11111";
  sAdd4 <= Add4In;
  Add4Out <= sAdd4;
  sBranchOR <= BranchControl OR BneControl;
  sBranch <= sBranchOR AND sZeroMux;
  sBranchShift <= sImmed(29 downto 0) & "00";
  sJump <= sAdd4(31 downto 28) & instruction(25 downto 0) & "00";
  sNotZero <= NOT Zero;
  sCarryIn <= '0';

  --Branch operation check
  checkZero : process(sRs,sRt)
  begin
    if(sRs = sRt) then
      Zero <= '1';
    else
      Zero <= '0';
    end if;
  end process;

  controlUnit: controlLogic port map(instruct31_26,sinstruct5_0,ALUOp,controlOut(2),controlOut(0),controlOut(1),controlOut(4),BranchControl,BneControl,JumpControl,JumpRetControl,controlOut(3));

  branch_mux: mux2to1Nbit port map(sAdd4,sBranchAdd,sBranch,sBranchMux);
  jump_mux: mux2to1Nbit port map(sBranchMux,sJump,JumpControl,sJumpMux);
  jr_mux: mux2to1Nbit port map(sJumpMux,sRs,JumpRetControl,DatatoPC);
  adder_branch: fulladderNbit port map(sCarryIn,sAdd4,sBranchShift,sBranchAdd,open,open,open);
  zero_mux: mux2to1 port map(Zero,sNotZero,BneControl,sZeroMux);

  WrReg_mux: mux2to15bit port map(instruct20_16,instruct15_11,RegDst,sWrite);
  link_writeReg: mux2to15bit port map(sWrite,reg31,Link,sWriteReg);
  regs: mipsRegister port map(WriteData,instruct20_16,instruct25_21,sWriteReg,clk,RST,RegWrite,sRs,sRt);

  mips_signextend: mips_extender port map(instruct15_0,sImmed);
  instruct5_0 <= sinstruct5_0;
  Immed <= sImmed;
  Rs_Data <= sRs;
  Rt_Data <= sRt;
  Special <= JumpControl OR JumpRetControl OR sBranch;
end structure;