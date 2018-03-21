-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- simpleMips.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a
-- simple MIPS processor.
--
-- NOTES:
-- 1/31/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity simpleMips is
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
end simpleMips;

architecture structure of simpleMips is

component mips_extender is
  port(input            : in std_logic_vector(15 downto 0) := (others => '0');
       output          	: out std_logic_vector(31 downto 0):= (others => '0'));
end component;

component datapath is
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
end component;

component mem
  generic(DATA_WIDTH   : natural := 32;
   	  ADDR_WIDTH   : natural := 10);
  port(clk	: in std_logic;
       addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
       data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
       we	: in std_logic;
       q	: out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

component mux2to1Nbit is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

signal signExtended,datapathOut,rDataMem,sRt,sRs : std_logic_vector(31 downto 0);
signal truncate : std_logic_vector(9 downto 0);
signal dmemAddr : natural range 0 to 1023;

begin 
   truncate <= datapathOut(11 downto 2);
   dmemAddr <= to_integer(unsigned(truncate));

   mips_signextend: mips_extender
	port map(imm, signExtended);
   mips_datapath: datapath
	port map(signExtended,DataWrite,Rt_sel,Rs_sel,Wr_sel,shamt,ALUOP,ALUSrc,RegWrite,clk,RST,Carry,Zero,Overflow,datapathOut,sRt,sRs);
   mips_mem: mem
	port map(clk,dmemAddr,sRt,WE_mem,rDataMem);
   mips_memToReg: mux2to1Nbit
	port map(rDataMem,datapathOut,Load_sel,DataOut);
   SignExtOut <= signExtended;
   Rs_Data <= sRs;
end structure;