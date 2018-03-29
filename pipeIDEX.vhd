-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- pipeIDEX.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the pipeline registers between the 
-- instruction decode and execution stage.
--
-- NOTES:
-- 3/28/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeIDEX is
  port(clk			: in std_logic;
       RST			: in std_logic;
       Stall			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       RsDataIn			: in std_logic_vector(31 downto 0);
       RtDataIn			: in std_logic_vector(31 downto 0);
       ImmedIn			: in std_logic_vector(31 downto 0);
       ALUOpIn			: in std_logic_vector(5 downto 0);
       shamtIn			: in std_logic_vector(4 downto 0);
       instruct20_16In		: in std_logic_vector(4 downto 0);
       instruct15_11In		: in std_logic_vector(4 downto 0);
       instruct5_0In		: in std_logic_vector(5 downto 0);
       controlIn		: in std_logic_vector(4 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       RsDataOut		: out std_logic_vector(31 downto 0);
       RtDataOut		: out std_logic_vector(31 downto 0);
       ImmedOut			: out std_logic_vector(31 downto 0);
       ALUOpOut			: out std_logic_vector(5 downto 0);
       shamtOut			: out std_logic_vector(4 downto 0);
       instruct20_16Out		: out std_logic_vector(4 downto 0);
       instruct15_11Out		: out std_logic_vector(4 downto 0);
       instruct5_0Out		: out std_logic_vector(5 downto 0);
       controlOut		: out std_logic_vector(4 downto 0));
end pipeIDEX;

architecture structure of pipeIDEX is
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
  RsData_reg: dffNbit port map(clk,RST,sWE,RsDataIn,RsDataOut);
  RtData_reg: dffNbit port map(clk,RST,sWE,RtDataIn,RtDataOut);
  Immed_reg: dffNbit port map(clk,RST,sWE,ImmedIn,ImmedOut);
  ALUOp_reg: dffNbit generic map(N => 6) port map(clk,RST,sWE,ALUOpIn,ALUOpOut);
  shamt_reg: dffNbit generic map(N=> 5) port map(clk,RST,sWE,shamtIn,shamtOut);
  instruct20_16_reg: dffNbit generic map(N => 5) port map(clk,RST,sWE,instruct20_16In,instruct20_16Out);
  instruct15_11_reg: dffNbit generic map(N => 5) port map(clk,RST,sWE,instruct15_11In,instruct15_11Out);
  instruct5_0_reg: dffNbit generic map(N=> 6) port map(clk,RST,sWE,instruct5_0In,instruct5_0Out);
  control_reg: dffNbit generic map(N => 5) port map(clk,RST,sWE,controlIn,controlOut);
end structure;
