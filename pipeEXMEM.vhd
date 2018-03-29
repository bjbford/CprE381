-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- pipeEXMEM.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the pipeline registers between the 
-- execution and memory stage.
--
-- NOTES:
-- 3/28/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeEXMEM is
  port(clk			: in std_logic;
       RST			: in std_logic;
       Stall			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       ALUResultIn		: in std_logic_vector(31 downto 0);
       RtDataIn			: in std_logic_vector(31 downto 0);
       controlIn		: in std_logic_vector(4 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       ALUResultOut		: out std_logic_vector(31 downto 0);
       RtDataOut		: out std_logic_vector(31 downto 0);
       controlOut		: out std_logic_vector(4 downto 0));
end pipeEXMEM;

architecture structure of pipeEXMEM is
component dffNbit
  generic(N : integer := 32);
  port(clk          : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

signal sWE		: std_logic;

begin 
  -- always write unless stall is high
  sWE <= NOT Stall;
  add4_reg: dffNbit port map(clk,RST,sWE,add4DataIn,add4DataOut);
  ALUResult_reg: dffNbit port map(clk,RST,sWE,ALUResultIn,ALUResultOut);
  RtData_reg: dffNbit port map(clk,RST,sWE,RtDataIn,RtDataOut);
  control_reg: dffNbit generic map(N => 5) port map(clk,RST,sWE,controlIn,controlOut);
end structure;