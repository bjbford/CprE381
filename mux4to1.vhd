-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- mux4to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a dataflow/structural implementation 
-- of a N-bit 4-1 Mux.
--
--
-- NOTES:
-- 1/23/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux4to1 is
  generic(N : integer := 32);
  port(i_w0         : in std_logic_vector(N-1 downto 0);
       i_w1	    : in std_logic_vector(N-1 downto 0);
       i_w2         : in std_logic_vector(N-1 downto 0);
       i_w3	    : in std_logic_vector(N-1 downto 0);
       i_s0	    : in std_logic;
       i_s1	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end mux4to1;

architecture structure of mux4to1 is

component mux2to1NbitDataflow
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

signal sY1, sY2     : std_logic_vector(N-1 downto 0); 

begin
  mux1: mux2to1NbitDataflow port map(i_w0,i_w1,i_s0,sY1);
  mux2: mux2to1NbitDataflow port map(i_w2,i_w3,i_s0,sY2);
  mux3: mux2to1NbitDataflow port map(sY1,sY2,i_s1,o_Y);
end structure;