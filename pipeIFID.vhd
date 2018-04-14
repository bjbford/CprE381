-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- pipeIFID.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the pipeline registers between the 
-- instruction fetch and instruction decode stage.
--
-- NOTES:
-- 3/28/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeIFID is
  port(clk			: in std_logic;
       RST			: in std_logic;
       Flush			: in std_logic;
       Stall			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       imemDataIn		: in std_logic_vector(31 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       imemDataOut		: out std_logic_vector(31 downto 0));
end pipeIFID;

architecture structure of pipeIFID is
component dffNbit
  generic(N : integer := 32);
  port(clk        : in std_logic;       -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

signal sWE			: std_logic;
signal simemDataIn,sadd4DataIn 	: std_logic_vector(31 downto 0);

begin
  process(Flush,add4DataIn,imemDataIn)
  begin
  if(Flush = '1') then
    sadd4DataIn <= x"00000000";
    simemDataIn <= x"00000000";
  else
    sadd4DataIn <= add4DataIn;
    simemDataIn <= imemDataIn;
  end if;
  end process;
  -- always write_enable unless stall is high
  sWE <= NOT Stall;
  add4_reg: dffNbit port map(clk,RST,sWE,sadd4DataIn,add4DataOut);
  imem_reg: dffNbit port map(clk,RST,sWE,simemDataIn,imemDataOut);
end structure;

