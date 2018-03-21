-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- my_or8.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a behavioral 8 input OR gate.
--
--
-- NOTES:
-- 1/24/18 by BJB: Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity my_or8 is
  port(i0, i1, i2, i3, i4, i5, i6, i7 : in std_logic;
       output : out std_logic);
end my_or8;

architecture behavior of my_or8 is
begin
  process
  begin
    output <= i0 OR i1 OR i2 OR i3 OR i4 OR i5 OR i6 OR i7;
    wait for 100 ns;
  end process;
end behavior;