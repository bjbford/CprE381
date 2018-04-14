-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- muxedDff.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a muxed D flip-flop to be used for 
-- our mips register.
--
-- NOTES:
-- 4/11/18 by BJB: Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity muxedDff is
  generic(N : integer := 32);
  port(clk        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end muxedDff;

architecture structure of muxedDff is
  
component my_dff is
  port(clk        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

component mux2to1
  port(i_A          : in std_logic;
       i_B	    : in std_logic;
       i_X	    : in std_logic;
       o_Y          : out std_logic);
end component;

signal sOut : std_logic_vector(31 downto 0);

begin
Gdff: for i in 0 to N-1 generate
  muxedDff_i: my_dff port map(clk,i_RST,i_WE,i_D(i),sOut(i));
  mux_i: mux2to1 port map(sOut(i),i_D(i),i_WE,o_Q(i));
end generate;

end structure;