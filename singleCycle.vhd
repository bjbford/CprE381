-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- singleCycle.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a MIPS straight-line single-cycle
-- processor.
--
-- NOTES:
-- 3/2/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity singleCycle is
  port(clk		: in std_logic;
       RST		: in std_logic;
       Carry		: out std_logic;
       Overflow		: out std_logic;
       Zero		: out std_logic);
end singleCycle;

architecture structure of singleCycle is

component simpleMips
  generic(N : integer := 32);
  port(DataWrite    : in std_logic_vector(31 downto 0);
       imm          : in std_logic_vector(15 downto 0);
       Rt_sel,Rs_sel,Wr_sel       : in std_logic_vector(4 downto 0);
       shamt	    : in std_logic_vector(4 downto 0);
       ALUOP	    : in std_logic_vector(3 downto 0);
       ALUSrc	    : in std_logic_vector(2 downto 0);
       RegWrite     : in std_logic;
       RST	    : in std_logic;
       Load_sel	    : in std_logic;
       WE_mem       : in std_logic;
       clk	    : in std_logic;
       Carry	    : out std_logic;
       Zero	    : out std_logic;
       Overflow	    : out std_logic;
       SignExtOut   : out std_logic_vector(31 downto 0);
       Rs_Data      : out std_logic_vector(31 downto 0);
       DataOut      : out std_logic_vector(31 downto 0));
end component;

component ifetchlogic
  port(clk		: in std_logic;
       RST		: in std_logic;
       Jump		: in std_logic;
       JumpRet		: in std_logic;
       Link		: in std_logic;
       Branch		: in std_logic;
       Bne		: in std_logic;
       Zero		: in std_logic;
       Immed		: in std_logic_vector(31 downto 0);
       Rs_data		: in std_logic_vector(31 downto 0);
       Carry		: out std_logic;
       Overflow		: out std_logic;
       ZeroOut		: out std_logic;
       Add8Out		: out std_logic_vector(31 downto 0);
       instruct		: out std_logic_vector(31 downto 0));
end component;

component controlLogic
  port(instruct31_26    : in std_logic_vector(5 downto 0);
       instruct5_0	: in std_logic_vector(5 downto 0);
       ALUOP	    	: out std_logic_vector(5 downto 0);
       RegWrite     	: out std_logic;
       MemtoReg	    	: out std_logic;
       MemWrite       	: out std_logic;
       RegDst       	: out std_logic;
       Branch       	: out std_logic;
       Bne		: out std_logic;
       Jump       	: out std_logic;       
       JumpRet       	: out std_logic;
       Link       	: out std_logic);
end component;

component ALUcontrol
  port(instruct5_0      : in std_logic_vector(5 downto 0);
       ALUOP		: in std_logic_vector(5 downto 0);
       ALUSrc		: out std_logic_vector(2 downto 0);
       control       	: out std_logic_vector(3 downto 0));
end component;

component mux2to15bit
  generic(N : integer := 5);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

component mux2to1Nbit
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;


signal instruction,sDataOut,sDataWrite,sAdd8Out,sImmed,sRs_data : std_logic_vector(31 downto 0);
signal instruct31_26,instruct5_0,sALUOP : std_logic_vector(5 downto 0);
signal instruct25_21,instruct20_16,instruct15_11,sWrite,instruct10_6,sWriteReg : std_logic_vector(4 downto 0);
signal instruct15_0 : std_logic_vector(15 downto 0);
signal sRegWrite,sMemtoReg,sMemWrite,sRegDst,sLink,sJump,sBranch,sBne,sJumpRet : std_logic;
signal sControl : std_logic_vector(3 downto 0);
signal sALUSrc : std_logic_vector(2 downto 0);
signal sCarry,sZero,sCarryFetch,sOverflowFetch,sOverflow : std_logic;
signal reg31 : std_logic_vector(4 downto 0) := "11111";

begin
  instruct31_26 <= instruction(31 downto 26);
  instruct25_21 <= instruction(25 downto 21);
  instruct20_16 <= instruction(20 downto 16);
  instruct15_11 <= instruction(15 downto 11);
  instruct15_0 <= instruction(15 downto 0);
  instruct10_6 <= instruction(10 downto 6);
  instruct5_0 <= instruction(5 downto 0);
  reg31 <= "11111";
  Carry <= sCarry OR sCarryFetch;
  Overflow <= sOverflow OR sOverflowFetch;

  dtpath: simpleMips port map(sDataWrite,instruct15_0,instruct20_16,instruct25_21,sWriteReg,instruct10_6,sControl,sALUSrc,sRegWrite,RST,sMemtoReg,sMemWrite,clk,sCarry,sZero,sOverflow,sImmed,sRs_data,sDataOut);
  instruct_fetch: ifetchlogic port map(clk,RST,sJump,sJumpRet,sLink,sBranch,sBne,sZero,sImmed,sRs_data,sCarryFetch,sOverflowFetch,Zero,sAdd8Out,instruction);
  WrReg_mux: mux2to15bit port map(instruct20_16,instruct15_11,sRegDst,sWrite);
  control: controlLogic port map(instruct31_26,instruct5_0,sALUOP,sRegWrite,sMemtoReg,sMemWrite,sRegDst,sBranch,sBne,sJump,sJumpRet,sLink);
  controlALU: ALUcontrol port map(instruct5_0,sALUOP,sALUSrc,sControl);

  link_writeReg: mux2to15bit port map(sWrite,reg31,sLink,sWriteReg);
  link_writeData: mux2to1Nbit port map(sDataOut,sAdd8Out,sLink,sDataWrite);
end structure;