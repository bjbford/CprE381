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

signal sRST,sWE		: std_logic;

begin
--implement branch condition logic here!!
  sRST <= RST OR Flush;
  -- always write_enable unless stall is high
  sWE <= NOT Stall;
  add4_reg: dffNbit port map(clk,sRST,sWE,add4DataIn,add4DataOut);
  imem_reg: dffNbit port map(clk,sRST,sWE,imemDataIn,imemDataOut);

end structure;

