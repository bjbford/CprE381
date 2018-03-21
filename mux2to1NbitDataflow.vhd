-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- mux2to1NbitDataflow.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a dataflow implementation of a N-bit
-- 2-1 mux.
--
--
-- NOTES:
-- 1/17/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux2to1NbitDataflow is
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));

end mux2to1NbitDataflow;

architecture dataflow of mux2to1NbitDataflow is

begin
G1: for i in 0 to N-1 generate
  o_Y(i) <= ((i_A(i) AND (NOT i_X)) OR (i_B(i) AND i_X));
end generate;

end dataflow;