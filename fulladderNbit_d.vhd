-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- fulladderNbit_d.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a dataflow implementation of a N-bit
-- full adder.
--
--
-- NOTES:
-- 1/17/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fulladderNbit_d is
  generic(N : integer := 32);
  port(i_Cin        : in std_logic;
       i_A	    : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       o_Sum	    : out std_logic_vector(N-1 downto 0);
       o_Cout       : out std_logic);
end fulladderNbit_d;

architecture dataflow of fulladderNbit_d is

signal sC : std_logic_vector(N downto 0);

begin
  -- carry in for first case (LSb of sC)
  sC(0) <= i_Cin;
-- generate 32 full adder instances and connect previous carry out to next carry in
G1: for i in 0 to N-1 generate
  o_Sum(i) <= i_A(i) XOR i_B(i) XOR sC(i);
  sC(i+1) <= (i_A(i) AND i_B(i)) OR (sC(i) AND (i_A(i) XOR i_B(i)));
end generate;
-- handles carry out (MSb of sC)
  o_Cout <= sC(N);
end dataflow;