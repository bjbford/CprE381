-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- executionStage.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation for the execution
-- stage of a multi-cycled, pipelined MIPS processor.
--
-- NOTES:
-- 3/28/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity executionStage is
  port(Rs_Data      	: in std_logic_vector(31 downto 0);
       Rt_Data      	: in std_logic_vector(31 downto 0);
       ALUOp		: in std_logic_vector(5 downto 0);
       Immed  		: in std_logic_vector(31 downto 0);
       shamt  		: in std_logic_vector(4 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       WriteRegIn	: in std_logic_vector(4 downto 0);
       IFID_RegisterRs	: in std_logic_vector(4 downto 0);
       IFID_RegisterRt	: in std_logic_vector(4 downto 0);
       instruct25_21In	: in std_logic_vector(4 downto 0);
       instruct20_16In	: in std_logic_vector(4 downto 0);
       instruct5_0	: in std_logic_vector(5 downto 0);
       controlIn	: in std_logic_vector(3 downto 0);
       EXMEM_RegisterRt : in std_logic_vector(4 downto 0);
       EXMEM_WriteReg	: in std_logic_vector(4 downto 0);
       MEMWB_WriteReg	: in std_logic_vector(4 downto 0);
       EXMEM_RegWrite   : in std_logic;
       MEMWB_RegWrite   : in std_logic;
       Branch		: in std_logic;
       EXMEM_ALUResult  : in std_logic_vector(31 downto 0);
       WB_WriteData	: in std_logic_vector(31 downto 0);
       ALUResult	: out std_logic_vector(31 downto 0);
       Rt_DataOut    	: out std_logic_vector(31 downto 0);
       Add4Out    	: out std_logic_vector(31 downto 0);
       WriteRegOut	: out std_logic_vector(4 downto 0);
       instruct20_16Out	: out std_logic_vector(4 downto 0);
       controlOut	: out std_logic_vector(3 downto 0);
       ForwardStore	: out std_logic; --Forward Store mux selector
       ForwardRs	: out std_logic; --Forward Rs mux selector
       ForwardRt	: out std_logic; --Forward Rt mux selector
       Overflow		: out std_logic);
end executionStage;

architecture structure of executionStage is

component ALUcontrol
  port(instruct5_0      : in std_logic_vector(5 downto 0);
       ALUOP		: in std_logic_vector(5 downto 0);
       ALUSrc		: out std_logic_vector(2 downto 0);
       control       	: out std_logic_vector(3 downto 0));
end component;

component ALU is
  generic(N : integer := 32);
  port(A	    : in std_logic_vector(N-1 downto 0);
       B	    : in std_logic_vector(N-1 downto 0);
       ALUOP	    : in std_logic_vector(3 downto 0);
       Carry	    : out std_logic;
       Zero	    : out std_logic;
       Overflow	    : out std_logic;
       Result	    : out std_logic_vector(N-1 downto 0));
end component;

component mux4to1 is
  generic(N : integer := 32);
  port(i_w0         : in std_logic_vector(N-1 downto 0);
       i_w1	    : in std_logic_vector(N-1 downto 0);
       i_w2         : in std_logic_vector(N-1 downto 0);
       i_w3	    : in std_logic_vector(N-1 downto 0);
       i_s0	    : in std_logic;
       i_s1	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

component mux2to1Nbit
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

component forwardingUnit
  port(EXMEM_RegWrite   	: in std_logic;
       MEMWB_RegWrite   	: in std_logic;
       Branch			: in std_logic;
       IFID_RegisterRs		: in std_logic_vector(4 downto 0);
       IFID_RegisterRt		: in std_logic_vector(4 downto 0);
       IDEX_RegisterRs		: in std_logic_vector(4 downto 0);
       IDEX_RegisterRt		: in std_logic_vector(4 downto 0);
       EXMEM_RegisterRt		: in std_logic_vector(4 downto 0);
       EXMEM_WriteReg		: in std_logic_vector(4 downto 0);
       MEMWB_WriteReg		: in std_logic_vector(4 downto 0);
       ForwardA			: out std_logic; -- Use forward mux data
       ForwardB       		: out std_logic; -- Use forward mux data
       ForwardASel		: out std_logic; --Forward A mux selector
       ForwardBSel		: out std_logic; --Forward B mux selector
       ForwardStore		: out std_logic; --Forward Store mux selector
       ForwardRs		: out std_logic; --Forward Rs mux selector
       ForwardRt		: out std_logic); --Forward Rt mux selector
end component;

signal AmuxOut,BmuxOut,hardcoded16,sAdd4,sRt_Data,sForwardASource,sForwardBSource,Bnormal : std_logic_vector(31 downto 0);
signal sShamt : std_logic_vector(31 downto 0) := (others => '0');
signal sALUSrc		: std_logic_vector(2 downto 0);
signal sControl,sControlVector : std_logic_vector(3 downto 0);
signal sWriteReg,sinstruct20_16 : std_logic_vector(4 downto 0);
signal sForwardA,sForwardB,sForwardASel,sForwardBSel : std_logic;
signal inputALUSrc,ALUSelectA,input3 : std_logic_vector(1 downto 0);

begin 
  hardcoded16 <= x"00000010";
  sShamt <= (31 downto 5 => '0') & shamt;
  sAdd4 <= Add4In;
  Add4Out <= sAdd4;
  sRt_Data <= Rt_Data;
  Rt_DataOut <= sRt_Data;
  sControlVector <= controlIn;
  controlOut <= sControlVector;
  sWriteReg <= WriteRegIn;
  WriteRegOut <= sWriteReg;
  sinstruct20_16 <= instruct20_16In;
  instruct20_16Out <= sinstruct20_16;
  inputALUSrc <= sALUSrc(1 downto 0);
  input3 <= "11";

  forwardUnit: forwardingUnit port map(EXMEM_RegWrite,MEMWB_RegWrite,Branch,IFID_RegisterRs,IFID_RegisterRt,instruct25_21In,sinstruct20_16,EXMEM_RegisterRt,EXMEM_WriteReg,MEMWB_WriteReg,sForwardA,sForwardB,sForwardASel,sForwardBSel,ForwardStore,ForwardRs,ForwardRt);
  
  ForwardA_source: mux2to1Nbit port map(WB_WriteData,EXMEM_ALUResult,sForwardASel,sForwardASource);
  ForwardB_source: mux2to1Nbit port map(WB_WriteData,EXMEM_ALUResult,sForwardBSel,sForwardBSource);

  A_source: mux4to1 port map(Rs_Data,sShamt,hardcoded16,sForwardASource,ALUSelectA(0),ALUSelectA(1),AmuxOut);
  A_controlmux: mux2to1Nbit generic map(N => 2) port map(inputALUSrc,input3,sForwardA,ALUSelectA);
  B_source: mux2to1Nbit port map(Rt_data,Immed,sALUSrc(2),Bnormal);
  B_mux: mux2to1Nbit port map(Bnormal,sForwardBSource,sForwardB,BmuxOut);
  full_alu: ALU port map(AmuxOut,BmuxOut,sControl,open,open,Overflow,ALUResult);
  controlALU: ALUcontrol port map(instruct5_0,ALUOp,sALUSrc,sControl);
end structure;