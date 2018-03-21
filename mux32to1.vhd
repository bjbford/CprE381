-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- mux32to1.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a dataflow/structural implementation 
-- of a N-bit 32-1 Mux.
--
--
-- NOTES:
-- 1/23/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mux32to1 is
  generic(N : integer := 32);
  port(w0,w1,w2,w3,w4,w5,w6,w7              : in std_logic_vector(N-1 downto 0);
       w8,w9,w10,w11,w12,w13,w14,w15        : in std_logic_vector(N-1 downto 0);
       w16,w17,w18,w19,w20,w21,w22,w23      : in std_logic_vector(N-1 downto 0);
       w24,w25,w26,w27,w28,w29,w30,w31      : in std_logic_vector(N-1 downto 0);
       s0,s1,s2,s3,s4	    		    : in std_logic;
       o_Y          			    : out std_logic_vector(N-1 downto 0));
end mux32to1;

architecture structure of mux32to1 is

component mux4to1
  generic(N : integer := 32);
  port(i_w0         : in std_logic_vector(N-1 downto 0);
       i_w1	    : in std_logic_vector(N-1 downto 0);
       i_w2         : in std_logic_vector(N-1 downto 0);
       i_w3	    : in std_logic_vector(N-1 downto 0);
       i_s0	    : in std_logic;
       i_s1	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

component mux2to1NbitDataflow
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

signal sY1,sY2,sY3,sY4,sY5,sY6,sY7,sY8,sY9,sY10    : std_logic_vector(N-1 downto 0); 

begin
  mux1: mux4to1 port map(w0,w1,w2,w3,s0,s1,sY1);
  mux2: mux4to1 port map(w4,w5,w6,w7,s0,s1,sY2);
  mux3: mux4to1 port map(w8,w9,w10,w11,s0,s1,sY3);
  mux4: mux4to1 port map(w12,w13,w14,w15,s0,s1,sY4);
  mux5: mux4to1 port map(sY1,sY2,sY3,sY4,s2,s3,sY5);

  mux6: mux4to1 port map(w16,w17,w18,w19,s0,s1,sY6);
  mux7: mux4to1 port map(w20,w21,w22,w23,s0,s1,sY7);
  mux8: mux4to1 port map(w24,w25,w26,w27,s0,s1,sY8);
  mux9: mux4to1 port map(w28,w29,w30,w31,s0,s1,sY9);
  mux10: mux4to1 port map(sY6,sY7,sY8,sY9,s2,s3,sY10);

  mux2_1: mux2to1NbitDataflow port map(sY5,sY10,s4,o_Y);
end structure;