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
       Flush			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       RsDataIn			: in std_logic_vector(31 downto 0);
       RtDataIn			: in std_logic_vector(31 downto 0);
       ImmedIn			: in std_logic_vector(31 downto 0);
       ALUOpIn			: in std_logic_vector(5 downto 0);
       shamtIn			: in std_logic_vector(4 downto 0);
       WriteRegIn		: in std_logic_vector(4 downto 0);
       instruct25_21In		: in std_logic_vector(4 downto 0);
       instruct20_16In		: in std_logic_vector(4 downto 0);
       instruct5_0In		: in std_logic_vector(5 downto 0);
       controlIn		: in std_logic_vector(3 downto 0);
       MemReadIn		: in std_logic;
       add4DataOut		: out std_logic_vector(31 downto 0);
       RsDataOut		: out std_logic_vector(31 downto 0);
       RtDataOut		: out std_logic_vector(31 downto 0);
       ImmedOut			: out std_logic_vector(31 downto 0);
       ALUOpOut			: out std_logic_vector(5 downto 0);
       shamtOut			: out std_logic_vector(4 downto 0);
       WriteRegOut		: out std_logic_vector(4 downto 0);
       instruct25_21Out		: out std_logic_vector(4 downto 0);
       instruct20_16Out		: out std_logic_vector(4 downto 0);
       instruct5_0Out		: out std_logic_vector(5 downto 0);
       controlOut		: out std_logic_vector(3 downto 0);
       MemReadOut		: out std_logic);
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

component my_dff
  port(clk        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output
end component;

signal sWE,sMemReadIn	: std_logic;
signal sadd4DataIn,sRsDataIn,sRtDataIn,sImmedIn : std_logic_vector(31 downto 0);
signal sALUOpIn,sinstruct5_0In : std_logic_vector(5 downto 0);
signal sshamtIn,sWriteReg,sinstruct20_16In,sinstruct25_21In : std_logic_vector(4 downto 0);
signal scontrolIn : std_logic_vector(3 downto 0);

begin 
  process(Flush,add4DataIn,RsDataIn,RtDataIn,ImmedIn,controlIn,ALUOpIn,instruct5_0In,shamtIn,WriteRegIn,instruct25_21In,instruct20_16In,MemReadIn)
  begin
  if(Flush = '1') then
    sadd4DataIn <= x"00000000";
    sRsDataIn <= x"00000000";
    sRtDataIn <= x"00000000";
    sImmedIn <= x"00000000";
    scontrolIn <= "0000";
    sALUOpIn <= "000000";
    sinstruct5_0In <= "100000";
    sshamtIn <= "00000";
    sWriteReg <= "00000";
    sinstruct25_21In <= "00000";
    sinstruct20_16In <= "00000";
    sMemReadIn <= '0';
    sWE <= '1';
  else
    sadd4DataIn <= add4DataIn;
    sRsDataIn <= RsDataIn;
    sRtDataIn <= RtDataIn;
    sImmedIn <= ImmedIn;
    scontrolIn <= controlIn;
    sALUOpIn <= ALUOpIn;
    sinstruct5_0In <= instruct5_0In;
    sshamtIn <= shamtIn;
    sWriteReg <= WriteRegIn;
    sinstruct25_21In <= instruct25_21In;
    sinstruct20_16In <= instruct20_16In;
    sMemReadIn <= MemReadIn;
    sWE <= NOT Stall;
  end if;
  end process;
  -- always write unless stall is high
  --sWE <= NOT Stall;
  add4_reg: dffNbit port map(clk,RST,sWE,sadd4DataIn,add4DataOut);
  RsData_reg: dffNbit port map(clk,RST,sWE,sRsDataIn,RsDataOut);
  RtData_reg: dffNbit port map(clk,RST,sWE,sRtDataIn,RtDataOut);
  Immed_reg: dffNbit port map(clk,RST,sWE,sImmedIn,ImmedOut);
  ALUOp_reg: dffNbit generic map(N => 6) port map(clk,RST,sWE,sALUOpIn,ALUOpOut);
  shamt_reg: dffNbit generic map(N=> 5) port map(clk,RST,sWE,sshamtIn,shamtOut);
  WriteReg_reg: dffNbit generic map(N => 5) port map(clk,RST,sWE,sWriteReg,WriteRegOut);
  instruct25_21_reg: dffNbit generic map(N => 5) port map(clk,RST,sWE,sinstruct25_21In,instruct25_21Out);
  instruct20_16_reg: dffNbit generic map(N => 5) port map(clk,RST,sWE,sinstruct20_16In,instruct20_16Out);
  instruct5_0_reg: dffNbit generic map(N=> 6) port map(clk,RST,sWE,sinstruct5_0In,instruct5_0Out);
  control_reg: dffNbit generic map(N => 4) port map(clk,RST,sWE,scontrolIn,controlOut);
  MemRead_reg: my_dff port map(clk,RST,sWE,sMemReadIn,MemReadOut);
end structure;
