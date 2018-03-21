-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- nor32.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a 
-- 32-bitwise NOR.
--
--
-- NOTES:
-- 2/19/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity nor32 is
  generic(N : integer := 32);
  port(i_A	    : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end nor32;

architecture structure of nor32 is

component my_or2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

signal orOut : std_logic_vector(N-1 downto 0);

begin
G1: for i in 0 to N-1 generate
  or_i: my_or2 port map(i_A(i),i_B(i),orOut(i));
  o_F(i) <= NOT orOut(i); 
end generate;
end structure;