-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- datapath.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a
-- MIPS-like datapath.
--
-- NOTES:
-- 1/29/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity datapath is
  generic(N : integer := 32);
  port(immed        : in std_logic_vector(N-1 downto 0);
       DataIn       : in std_logic_vector(N-1 downto 0);
       Rt_sel,Rs_sel,Wr_sel       : in std_logic_vector(4 downto 0);
       shamt	    : in std_logic_vector(4 downto 0);
       ALUOP	    : in std_logic_vector(3 downto 0);
       ALUSrc	    : in std_logic_vector(2 downto 0);
       RegWrite     : in std_logic;
       clk	    : in std_logic;
       RST	    : in std_logic;
       Carry	    : out std_logic;
       Zero	    : out std_logic;
       Overflow	    : out std_logic;
       Rd,Rt,Rs	    : out std_logic_vector(N-1 downto 0));
end datapath;

architecture structure of datapath is

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

component mipsRegister
  generic(N : integer := 32);
  port(DataIn             	: in std_logic_vector(N-1 downto 0);
       Rt_sel,Rs_sel,Wr_sel     : in std_logic_vector(4 downto 0);
       clk, RST, WE  		: in std_logic;
       Rs_data,Rt_data          : out std_logic_vector(N-1 downto 0));
end component;

--signals here
signal ALUResult,AmuxOut,BmuxOut,sRs_data,sRt_data,hardcoded16	: std_logic_vector(31 downto 0);
signal sShamt : std_logic_vector(31 downto 0) := (others => '0');

begin 
  hardcoded16 <= x"00000010";
  sShamt <= (31 downto 5 => '0') & shamt;
  A_source: mux4to1 
	port map(sRs_data,sShamt,hardcoded16,hardcoded16,ALUSrc(0),ALUSrc(1),AmuxOut);
  B_source: mux2to1Nbit
	port map(sRt_data,immed,ALUSrc(2),BmuxOut);
  full_alu: ALU
        port map(AmuxOut,BmuxOut,ALUOP,Carry,Zero,Overflow,ALUResult);
  regs: mipsRegister
	port map(DataIn,Rt_sel,Rs_sel,Wr_sel,clk,RST,RegWrite,sRs_data,sRt_data);
  Rd <= ALUResult;
  Rt <= sRt_data; 
  Rs <= sRs_data;
end structure;