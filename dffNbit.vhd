-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- dffNbit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a N-bit D flip flop. Using structural
-- and a generate.
--
-- NOTES:
-- 1/24/18 by BJB: Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity dffNbit is
  generic(N : integer := 32);
  port(clk        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end dffNbit;

architecture structure of dffNbit is
  
component my_dff is
  port(clk        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

begin
Gdff: for i in 0 to N-1 generate
  dff_i: my_dff port map(clk,i_RST,i_WE,i_D(i),o_Q(i));
end generate;

end structure;