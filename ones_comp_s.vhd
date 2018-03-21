-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- ones_comp_s.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a 
-- 1's complementer.
--
--
-- NOTES:
-- 1/17/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ones_comp_s is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end ones_comp_s;

architecture structure of ones_comp_s is
component inv
   port(i_A          : in std_logic;
        o_F          : out std_logic);
end component;

begin

-- We loop through and instantiate and connect N and2 modules
G1: for i in 0 to N-1 generate
  inv_i: inv 
    port map(i_A  => i_A(i),
  	          o_F  => o_F(i));
end generate;
  
end structure;