-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- add_sub.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a structural implementation of a N-bit
-- ALU that supports add/sub,and,or,nor,xor,sll,srl,and sra.
--
-- NOTES:
-- 2/19/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
  generic(N : integer := 32);
  port(A	    : in std_logic_vector(N-1 downto 0);
       B	    : in std_logic_vector(N-1 downto 0);
       ALUOP	    : in std_logic_vector(3 downto 0);
       Carry	    : out std_logic;
       Zero	    : out std_logic;
       Overflow	    : out std_logic;
       Result	    : out std_logic_vector(N-1 downto 0));
end ALU;

architecture structure of ALU is

component add_sub is
  generic(N : integer := 32);
  port(A	    : in std_logic_vector(N-1 downto 0);
       B	    : in std_logic_vector(N-1 downto 0);
       nAdd_Sub	    : in std_logic;
       Overflow     : out std_logic;
       Zero	    : out std_logic;
       Carry	    : out std_logic;
       Result	    : out std_logic_vector(N-1 downto 0));
end component;

component my_xor2
  port(i_A          : in std_logic;
       i_B          : in std_logic;
       o_F          : out std_logic);
end component;

component and32
  generic(N : integer := 32);
  port(i_A	    : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component or32
  generic(N : integer := 32);
  port(i_A	    : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component xor32
  generic(N : integer := 32);
  port(i_A	    : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component nor32
  generic(N : integer := 32);
  port(i_A	    : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       o_F          : out std_logic_vector(N-1 downto 0));
end component;

component shift32
  generic(N : integer := 32);
  port(dataIn              : in std_logic_vector(N-1 downto 0);
       AorL                : in std_logic; --0 = Logical, 1 = Arithmetic
       dir		   : in std_logic; --0 = left, 1 = right
       sel	           : in std_logic_vector(4 downto 0);
       output          	   : out std_logic_vector(N-1 downto 0));
end component;

component mux8to1
  generic(N : integer := 32);
  port(i_w0,i_w1,i_w2,i_w3      : in std_logic_vector(N-1 downto 0);
       i_w4,i_w5,i_w6,i_w7      : in std_logic_vector(N-1 downto 0);
       i_s0	    		: in std_logic;
       i_s1	    		: in std_logic;
       i_s2	    		: in std_logic;
       o_Y          		: out std_logic_vector(N-1 downto 0));
end component;

signal sAND, sOR, sXOR, sNOR, sShift,sAddSub  : std_logic_vector(N-1 downto 0);
signal sOverflow,smy_xmy_or2  	: std_logic;
signal sPAD 		 	: std_logic_vector(N-1 downto 0) := x"00000000";

begin 
  addsub: add_sub port map(A,B,ALUOP(3),sOverflow,Zero,Carry,sAddSub);
  xor_1: my_xor2 port map (sOverflow,sAddSub(31),sPAD(0));
  and_32: and32 port map(A,B,sAND);
  or_32: or32 port map(A,B,sOR);
  xor_32: xor32 port map(A,B,sXOR);
  nor_32: nor32 port map(A,B,sNOR);
  shift: shift32 port map(B,ALUOP(3),ALUOP(0),A(4 downto 0),sShift);
  mux: mux8to1 port map(sPAD,sAddSub,sAND,sOR,sXOR,sNOR,sShift,sShift,ALUOP(0),ALUOP(1),ALUOP(2),Result);
  Overflow <=sOverflow;
end structure;