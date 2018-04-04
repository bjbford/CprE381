-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- mipsRegister.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32 register,
-- 32bit MIPS register file, using Dflip-flops, 32 bit muxes, and 5to32
-- decoders.
--
--
-- NOTES:
-- 1/23/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity mipsRegister is
  generic(N : integer := 32);
  port(DataIn             	: in std_logic_vector(N-1 downto 0);
       Rt_sel,Rs_sel,Wr_sel     : in std_logic_vector(4 downto 0);
       clk, RST, WE  		: in std_logic;
       Rs_data,Rt_data          : out std_logic_vector(N-1 downto 0));
end mipsRegister;

architecture structure of mipsRegister is

component mux32to1
  generic(N : integer := 32);
  port(w0,w1,w2,w3,w4,w5,w6,w7              : in std_logic_vector(N-1 downto 0);
       w8,w9,w10,w11,w12,w13,w14,w15        : in std_logic_vector(N-1 downto 0);
       w16,w17,w18,w19,w20,w21,w22,w23      : in std_logic_vector(N-1 downto 0);
       w24,w25,w26,w27,w28,w29,w30,w31      : in std_logic_vector(N-1 downto 0);
       s0,s1,s2,s3,s4	    		    : in std_logic;
       o_Y          			    : out std_logic_vector(N-1 downto 0));
end component;

component decoder5to32
  port(X_in         : in std_logic_vector(4 downto 0);
       o_Data       : out std_logic_vector(31 downto 0));
end component;

component dffNbit
  generic(N : integer := 32);
  port(clk        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

signal sDecode,sDff0_out   : std_logic_vector(N-1 downto 0);
signal sWr_sel		   : std_logic_vector(4 downto 0) := "00000";
signal dff0 : std_logic_vector(N-1 downto 0) := x"00000000";

--2D array of 32 signals of size 32 bits
type blah is array (31 downto 0) of std_logic_vector(31 downto 0);
signal sQ : blah;
--signal v0 : std_logic_vector(31 downto 0);

begin
  write_enable: process(WE,Wr_sel)
  begin
  if(WE = '0') then 
     sWr_sel <= "00000";
  else
     sWr_sel <= Wr_sel;
  end if;
  end process write_enable;
  decode5to32: decoder5to32 port map(sWr_sel,sDecode);
  dff0 <= x"00000000";
  -- hardcode $0 since it's a special case
  dff_0: dffNbit port map(clk,RST,sDecode(0),dff0,sDff0_out);
G1: for i in 1 to N-1 generate
  dff_i : dffNbit port map(clk,RST,sDecode(i),DataIn,sQ(i));
end generate;
--v0 <= sQ(2);
-- Rs_Data mux
  mux32to1_Rs: mux32to1 port map(sDff0_out,sQ(1),sQ(2),sQ(3),sQ(4),sQ(5),sQ(6),sQ(7),
				sQ(8),sQ(9),sQ(10),sQ(11),sQ(12),sQ(13),sQ(14),sQ(15),
				sQ(16),sQ(17),sQ(18),sQ(19),sQ(20),sQ(21),sQ(22),sQ(23),
				sQ(24),sQ(25),sQ(26),sQ(27),sQ(28),sQ(29),sQ(30),sQ(31),
				Rs_sel(0),Rs_sel(1),Rs_sel(2),Rs_sel(3),Rs_sel(4),
				Rs_data);
-- Rt_Data mux
  mux32to1_Rt: mux32to1 port map(sDff0_out,sQ(1),sQ(2),sQ(3),sQ(4),sQ(5),sQ(6),sQ(7),
				sQ(8),sQ(9),sQ(10),sQ(11),sQ(12),sQ(13),sQ(14),sQ(15),
				sQ(16),sQ(17),sQ(18),sQ(19),sQ(20),sQ(21),sQ(22),sQ(23),
				sQ(24),sQ(25),sQ(26),sQ(27),sQ(28),sQ(29),sQ(30),sQ(31),
				Rt_sel(0),Rt_sel(1),Rt_sel(2),Rt_sel(3),Rt_sel(4),
				Rt_data);
end structure;