-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------


-- dflipflop.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a D flip flop defined in Free Range 
-- VHDL textbook chapter 7 excercise 2.
--
--
-- NOTES:
-- 1/24/18 by BJB: Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity dflipflop is
  port(D,S,R,CLK : in std_logic;
       Q,nQ      : out std_logic);
end dflipflop;

architecture behavior of dflipflop is

begin
  my_dff: process(CLK)
  begin
    if(rising_edge(CLK)) then
       if(S='0') then
	 Q <= '1';
	 nQ <= '0';
       elsif(R='0') then
         Q <= '0';
         nQ <= '1';
       else
         Q <= D;
         nQ <= not D;
       end if;
    end if;
  end process my_dff;
end behavior;