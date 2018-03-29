-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- memoryStage.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation for the memory
-- stage of a multi-cycled, pipelined MIPS processor.
--
-- NOTES:
-- 3/28/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoryStage is
  port(clk		: in std_logic;
       Rt_Data      	: in std_logic_vector(31 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       controlIn	: in std_logic_vector(4 downto 0);
       ALUResult	: in std_logic_vector(31 downto 0);
       instruct20_16In	: in std_logic_vector(4 downto 0);
       instruct15_11In	: in std_logic_vector(4 downto 0);
       ReadData    	: out std_logic_vector(31 downto 0);
       Add4Out    	: out std_logic_vector(31 downto 0);
       ALUResultOut    	: out std_logic_vector(31 downto 0);
       instruct20_16Out	: out std_logic_vector(4 downto 0);
       instruct15_11Out	: out std_logic_vector(4 downto 0);
       controlOut	: out std_logic_vector(4 downto 0));
end memoryStage;

architecture structure of memoryStage is

component mem
  generic(DATA_WIDTH   : natural := 32;
   	  ADDR_WIDTH   : natural := 10);
  port(clk	: in std_logic;
       addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
       data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
       we	: in std_logic;
       q	: out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

signal sAdd4,sALUResult	: std_logic_vector(31 downto 0);
signal sControl,sinstruct20_16,sinstruct15_11 : std_logic_vector(4 downto 0);
signal truncate : std_logic_vector(9 downto 0);
signal dmemAddr : natural range 0 to 1023;

begin 
  truncate <= ALUResult(11 downto 2);
  dmemAddr <= to_integer(unsigned(truncate));
  sALUResult <= ALUResult;
  ALUResultOut <= sALUResult;
  sAdd4 <= Add4In;
  Add4Out <= sAdd4;
  sControl <= controlIn;
  controlOut <= sControl;
  sinstruct20_16 <= instruct20_16In;
  instruct20_16Out <= sinstruct20_16;
  sinstruct15_11 <= instruct15_11In;
  instruct15_11Out <= sinstruct15_11;
  mips_mem: mem port map(clk,dmemAddr,Rt_Data,controlIn(1),ReadData);
end structure;