-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- ones_comp_d.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a dataflow implementation of a 
-- 1's complementer.
--
-- NOTES:
-- 1/17/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ones_comp_d is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));

end ones_comp_d;

architecture dataflow of ones_comp_d is
begin

  o_F <= not i_A;
  
end dataflow;