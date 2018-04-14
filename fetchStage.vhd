-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- fetchStage.vhd
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

entity fetchStage is
  port(clk		: in std_logic;
       RST		: in std_logic;
       JumpJrBranch	: in std_logic;
       Stall		: in std_logic;
       Special		: in std_logic_vector(31 downto 0);
       Add4Out		: out std_logic_vector(31 downto 0);
       instruct		: out std_logic_vector(31 downto 0));
end fetchStage;

architecture structure of fetchStage is

component mem
  generic(DATA_WIDTH   : natural := 32;
   	  ADDR_WIDTH   : natural := 10);
  port(clk	: in std_logic;
       addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
       data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
       we	: in std_logic;
       q	: out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

component dffNbit
  generic(N : integer := 32);
  port(clk        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
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

component mux2to1Nbit
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

signal WriteReg,s_we,sCarryIn   : std_logic;
signal so_Q,sPC,sAdd4,sData   	: std_logic_vector(31 downto 0);
signal s_addr       		: natural range 0 to 2**10-1;
signal add4	    		: std_logic_vector(31 downto 0) := x"00000004";
signal truncate 		: std_logic_vector(9 downto 0);
signal imemAddr 		: natural range 0 to 1023;

begin
  s_we <= '0';
  sData <= x"00000000";
  WriteReg <= NOT Stall;
  truncate <= so_Q(11 downto 2);
  imemAddr <= to_integer(unsigned(truncate));
  sCarryIn <= '0';
  add4 <= x"00000004";
  Add4Out <= sAdd4;

  PCSrc_mux: mux2to1Nbit port map(sAdd4,Special,JumpJrBranch,sPC);
  adder_4: fulladderNbit port map(sCarryIn,so_Q,add4,sAdd4,open,open,open);
  reg: dffNbit port map(clk,RST,WriteReg,sPC,so_Q);
  imem: mem port map(clk,imemAddr,sData,s_we,instruct);
end structure;