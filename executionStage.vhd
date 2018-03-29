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
       instruct20_16In	: in std_logic_vector(4 downto 0);
       instruct15_11In	: in std_logic_vector(4 downto 0);
       instruct5_0	: in std_logic_vector(5 downto 0);
       controlIn	: in std_logic_vector(4 downto 0);
       ALUResult	: out std_logic_vector(31 downto 0);
       Rt_DataOut    	: out std_logic_vector(31 downto 0);
       Add4Out    	: out std_logic_vector(31 downto 0);
       instruct20_16Out	: out std_logic_vector(4 downto 0);
       instruct15_11Out	: out std_logic_vector(4 downto 0);
       controlOut	: out std_logic_vector(4 downto 0);
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

signal AmuxOut,BmuxOut,hardcoded16,sAdd4,sRt_Data	: std_logic_vector(31 downto 0);
signal sShamt : std_logic_vector(31 downto 0) := (others => '0');
signal sALUSrc		: std_logic_vector(2 downto 0);
signal sControl : std_logic_vector(3 downto 0);
signal sControlVector,sinstruct20_16,sinstruct15_11 : std_logic_vector(4 downto 0);

begin 
  hardcoded16 <= x"00000010";
  sShamt <= (31 downto 5 => '0') & shamt;
  sAdd4 <= Add4In;
  Add4Out <= sAdd4;
  sRt_Data <= Rt_Data;
  Rt_DataOut <= sRt_Data;
  sControlVector <= controlIn;
  controlOut <= sControlVector;
  sinstruct20_16 <= instruct20_16In;
  instruct20_16Out <= sinstruct20_16;
  sinstruct15_11 <= instruct15_11In;
  instruct15_11Out <= sinstruct15_11;
  A_source: mux4to1 port map(Rs_Data,sShamt,hardcoded16,hardcoded16,sALUSrc(0),sALUSrc(1),AmuxOut);
  B_source: mux2to1Nbit port map(Rt_data,Immed,sALUSrc(2),BmuxOut);
  full_alu: ALU port map(AmuxOut,BmuxOut,sControl,open,open,Overflow,ALUResult);
  controlALU: ALUcontrol port map(instruct5_0,ALUOp,sALUSrc,sControl);
end structure;