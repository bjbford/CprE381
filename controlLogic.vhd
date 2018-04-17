-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- controlLogic.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the control logic module for our 
-- MIPS processor.
--
-- NOTES:
-- 2/27/18 by BJB: Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity controlLogic is
  port(instruct31_26    : in std_logic_vector(5 downto 0);
       instruct5_0	: in std_logic_vector(5 downto 0);
       ALUOP	    	: out std_logic_vector(5 downto 0);
       RegWrite     	: out std_logic;
       MemtoReg	    	: out std_logic;
       MemWrite       	: out std_logic;
       MemRead		: out std_logic;
       RegDst       	: out std_logic;
       Branch       	: out std_logic;
       Bne		: out std_logic;
       Jump       	: out std_logic;       
       JumpRet       	: out std_logic;
       Link       	: out std_logic);
end controlLogic;

architecture sel_when of controlLogic is
begin
op : process(instruct31_26,instruct5_0)
begin
   case (instruct31_26) is
     when "000000" => --R-type instructions
       case (instruct5_0) is
         when "001000" => --jr specific case only
           ALUOP <= "001000";
           RegWrite <= '0';
           MemtoReg <= '0';
           MemWrite <= '0';
           MemRead <= '0';
           RegDst <= '0';
           Branch <= '0';
           Bne <= '0';
           Jump <= '0'; -- was 1
           JumpRet <= '1';
           Link <= '0';
	 when others => --arithmetic R-type instructions
           ALUOP <= "000000";
           RegWrite <= '1';
           MemtoReg <= '1';
           MemWrite <= '0';
           MemRead <= '0';
           RegDst <= '1';
           Branch <= '0';
           Bne <= '0';
           Jump <= '0';
           JumpRet <= '0';
           Link <= '0';
       end case;
     when "001000" => --addi
       ALUOP <= "001000";
       RegWrite <= '1';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "001001" => --addiu
       ALUOP <= "001001";
       RegWrite <= '1';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "001100" => --andi
       ALUOP <= "001100";
       RegWrite <= '1';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "001110" => --xori
       ALUOP <= "001110";
       RegWrite <= '1';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "001101" => --ori
       ALUOP <= "001101";
       RegWrite <= '1';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "001010" => --slti
       ALUOP <= "001010";
       RegWrite <= '1';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "001011" => --sltiu
       ALUOP <= "001011";
       RegWrite <= '1';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "001111" => --lui
       ALUOP <= "001111";
       RegWrite <= '1';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "100011" => --lw
       ALUOP <= "100011";
       RegWrite <= '1';
       MemtoReg <= '0';
       MemWrite <= '0';
       MemRead <= '1';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "101011" => --sw
       ALUOP <= "101011";
       RegWrite <= '0';
       MemtoReg <= '0'; --was X
       MemWrite <= '1';
       MemRead <= '0';
       RegDst <= '0'; --was X
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "000100" => --beq
       ALUOP <= "000100";
       RegWrite <= '0';
       MemtoReg <= '0';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '1';
       Bne <= '0';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "000101" => --bne
       ALUOP <= "000101";
       RegWrite <= '0';
       MemtoReg <= '0';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '1';
       Jump <= '0';
       JumpRet <= '0';
       Link <= '0';
     when "000010" => --j
       ALUOP <= "000010";
       RegWrite <= '0';
       MemtoReg <= '0';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '1';
       JumpRet <= '0';
       Link <= '0';
     when "000011" => --jal
       ALUOP <= "000011";
       RegWrite <= '1';
       MemtoReg <= '0';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '1';
       Branch <= '0';
       Bne <= '0';
       Jump <= '1';
       JumpRet <= '0';
       Link <= '1';
     when others =>
       ALUOP <= "000000";
       RegWrite <= '0';
       MemtoReg <= '1';
       MemWrite <= '0';
       MemRead <= '0';
       RegDst <= '0';
       Branch <= '0';
       Bne <= '0';
       Jump <= '0';       
       JumpRet <= '0';
       Link <= '0';
  end case;
end process;
end sel_when;