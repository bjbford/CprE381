-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- mips_extender.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 16 to 32 bit
-- zero and sign extender.
--
--
-- NOTES:
-- 1/23/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity mips_extender is
  port(input            : in std_logic_vector(15 downto 0) := (others => '0');
       output          	: out std_logic_vector(31 downto 0):= (others => '0'));
end mips_extender;

architecture dataflow of mips_extender is

begin
  output <= (31 downto 16 => input(15)) & input;
end dataflow;