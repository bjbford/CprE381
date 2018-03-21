-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- ALUcontrol.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the ALU control logic module for our 
-- MIPS processor.
--
-- NOTES:
-- 2/27/18 by BJB: Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity ALUcontrol is
  port(instruct5_0      : in std_logic_vector(5 downto 0);
       ALUOP		: in std_logic_vector(5 downto 0);
       ALUSrc		: out std_logic_vector(2 downto 0);
       control       	: out std_logic_vector(3 downto 0));
end ALUcontrol;

architecture sel_when of ALUcontrol is
begin
  process (ALUOP,instruct5_0)
  begin
    if(ALUOP = "000000") then
      if(instruct5_0 = "100000") then
        control <= "0001"; --add
        ALUSrc <= "000";
      elsif(instruct5_0 = "100001") then
        control <= "0001"; --addu
        ALUSrc <= "000";
      elsif(instruct5_0 = "100010") then
        control <= "1001"; --sub
        ALUSrc <= "000";
      elsif(instruct5_0 = "100011") then
        control <= "1001"; --subu
        ALUSrc <= "000";
      elsif(instruct5_0 = "100100") then
        control <= "0010"; --and
        ALUSrc <= "000";
      elsif(instruct5_0 = "100101") then
        control <= "0011"; --or
        ALUSrc <= "000";
      elsif(instruct5_0 = "100110") then
        control <= "0100"; --xor
        ALUSrc <= "000";
      elsif(instruct5_0 = "100111") then
        control <= "0101"; --nor
        ALUSrc <= "000";
      elsif(instruct5_0 = "000000") then
        control <= "0110"; --sll
        ALUSrc <= "001";
      elsif(instruct5_0 = "000010") then
        control <= "0111"; --srl
        ALUSrc <= "001";
      elsif(instruct5_0 = "000011") then
        control <= "1111"; --sra
        ALUSrc <= "001";
      elsif(instruct5_0 = "101010") then
        control <= "1000"; --slt
        ALUSrc <= "000";
      elsif(instruct5_0 = "101011") then
        control <= "1000"; --sltu
        ALUSrc <= "000";
      elsif(instruct5_0 = "000100") then
	control <= "0110"; --sllv
        ALUSrc <= "000";
      elsif(instruct5_0 = "000110") then
	control <= "0111"; --srlv
        ALUSrc <= "000";
      elsif(instruct5_0 = "000111") then
	control <= "1111"; --srav
        ALUSrc <= "000";
      else
        control <= "0000"; --others
        ALUSrc <= "000";
      end if;
    else
      if(ALUOP = "001000") then
        control <= "0001"; --addi opcode
        ALUSrc <= "100";
      elsif(ALUOP = "001001") then
        control <= "0001"; --addiu opcode
        ALUSrc <= "100";
      elsif(ALUOP = "001100") then
        control <= "0010"; --andi opcode
        ALUSrc <= "100";
      elsif(ALUOP = "001101") then
        control <= "0011"; --ori opcode
        ALUSrc <= "100";
      elsif(ALUOP = "001110") then
        control <= "0100"; --xori opcode
        ALUSrc <= "100";
      elsif(ALUOP = "001010") then
        control <= "1000"; --slti opcode
        ALUSrc <= "100";
      elsif(ALUOP = "001011") then
        control <= "1000"; --sltiu opcode
        ALUSrc <= "100";
      elsif(ALUOP = "001111") then
        control <= "0110"; --lui opcode	
	ALUSrc <= "110";
      elsif(ALUOP = "101011") then
        control <= "0001"; --sw opcode	
	ALUSrc <= "100";
      elsif(ALUOP = "100011") then
        control <= "0001"; --lw opcode	
	ALUSrc <= "100";
      elsif(ALUOP = "000100") then
        control <= "1001"; --beq opcode	
	ALUSrc <= "000";
      elsif(ALUOP = "000101") then
        control <= "1001"; --bne opcode	
	ALUSrc <= "000";
      else
        control <= "0000"; --others
        ALUSrc <= "000";
      end if;
    end if;
  end process;
end sel_when;