-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- ifetchlogic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation for instruction mem 
-- testing.
--
-- NOTES:
-- 3/1/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ifetchlogic is
  port(clk		: in std_logic;
       RST		: in std_logic;
       Jump		: in std_logic;
       JumpRet		: in std_logic;
       Link		: in std_logic;
       Branch		: in std_logic;
       Bne		: in std_logic;
       Zero		: in std_logic;
       Immed		: in std_logic_vector(31 downto 0);
       Rs_data		: in std_logic_vector(31 downto 0);
       Carry		: out std_logic;
       Overflow		: out std_logic;
       ZeroOut		: out std_logic;
       Add8Out		: out std_logic_vector(31 downto 0);
       instruct		: out std_logic_vector(31 downto 0));
end ifetchlogic;

architecture structure of ifetchlogic is

--component instructMem
--generic 
--	(
--		DATA_WIDTH : natural := 32;
--		ADDR_WIDTH : natural := 10
--	);
	
--	port 
--	(
--		addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
--		q		: out std_logic_vector((DATA_WIDTH -1) downto 0)
--	);
--end component;

component mem
  generic(DATA_WIDTH   : natural := 32;
   	  ADDR_WIDTH   : natural := 10);
  port(clk	: in std_logic;
       addr	: in natural range 0 to 2**ADDR_WIDTH - 1;
       data	: in std_logic_vector((DATA_WIDTH-1) downto 0);
       we	: in std_logic;
       q	: out std_logic_vector((DATA_WIDTH -1) downto 0));
end component;

component dffNbit
  generic(N : integer := 32);
  port(clk        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
end component;

component fulladderNbit
  generic(N : integer := 32);
  port(i_Cin        : in std_logic;
       i_A	    : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       o_Sum	    : out std_logic_vector(N-1 downto 0);
       overflow     : out std_logic;
       zero 	    : out std_logic;
       o_Cout	    : out std_logic);
end component;

component mux2to1Nbit
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

component mux2to1
  port(i_A          : in std_logic;
       i_B	    : in std_logic;
       i_X	    : in std_logic;
       o_Y          : out std_logic);
end component;

signal WriteReg   : std_logic;
signal so_Q,sPC,sinstruct,sBranchMux,sJumpMux,pcAdd,pcAddMux,sBranchAdd   : std_logic_vector(31 downto 0);
signal s_addr       : natural range 0 to 2**10-1;
signal add4	    : std_logic_vector(31 downto 0) := x"00000004";
signal add8	    : std_logic_vector(31 downto 0) := x"00000008";
signal soverflow,soverflow2,sBranch,sZeroMux,sNotZero,sBranchOR,sZero,sZero2    :  std_logic;
signal truncate : std_logic_vector(9 downto 0);
signal imemAddr : natural range 0 to 1023;
signal sBranchShift,sJump : std_logic_vector(31 downto 0) := x"00000000";
signal sCarry,sCarry2,sCarryIn : std_logic := '0';
signal s_we : std_logic;
signal sData : std_logic_vector(31 downto 0);

begin
  s_we <= '0';
  sData <= x"00000000";
  WriteReg <= '1';
  sBranchOR <= Branch OR Bne;
  sBranch <= sBranchOR AND sZeroMux;
  truncate <= so_Q(11 downto 2);
  imemAddr <= to_integer(unsigned(truncate));
  sBranchShift(31 downto 2) <= Immed(29 downto 0);
  sJump(27 downto 2) <= sinstruct(25 downto 0);
  sJump(31 downto 28) <= pcAdd(31 downto 28);
  sNotZero <= NOT Zero;
  add4 <= x"00000004";
  add8 <= x"00000008";
  sCarryIn <= '0';

  branch_mux: mux2to1Nbit port map(pcAdd,sBranchAdd,sBranch,sBranchMux);
  jump_mux: mux2to1Nbit port map(sBranchMux,sJump,Jump,sJumpMux);
  jr_mux: mux2to1Nbit port map(sJumpMux,Rs_data,JumpRet,sPC);
  zero_mux: mux2to1 port map(Zero,sNotZero,Bne,sZeroMux);

  pc_add_mux: mux2to1Nbit port map(add4,add8,Link,pcAddMux);
  adder_4: fulladderNbit port map(sCarryIn,so_Q,pcAddMux,pcAdd,soverflow,sZero,sCarry);
  adder_branch: fulladderNbit port map(sCarryIn,pcAdd,sBranchShift,sBranchAdd,soverflow2,sZero2,sCarry2);

  reg: dffNbit port map(clk,RST,WriteReg,sPC,so_Q);
  --imem: instructMem port map(imemAddr,sinstruct);
  imem: mem port map(clk,imemAddr,sData,s_we,sinstruct);
  instruct <= sinstruct;
  Add8Out <= pcAdd;
  Carry <= sCarry OR sCarry2;
  Overflow <= soverflow OR soverflow2;
  ZeroOut <= sZero OR sZero2;
end structure;