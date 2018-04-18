-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- hazardDetection.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the hazard detection unit for the
-- hardware-scheduled pipelined processor.
--
-- NOTES:
-- 4/10/18 by BJB: Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity hazardDetection is
  port(IFID_RegisterRs	    	: in std_logic_vector(4 downto 0);
       IFID_RegisterRt	    	: in std_logic_vector(4 downto 0);
       IDEX_RegisterRt	    	: in std_logic_vector(4 downto 0);
       IDEX_WriteReg		: in std_logic_vector(4 downto 0);
       EXMEM_WriteReg		: in std_logic_vector(4 downto 0);
       IDEX_MEMRead		: in std_logic;
       Branch			: in std_logic;
       BranchTaken		: in std_logic;
       Jump			: in std_logic;
       JAL			: in std_logic;
       JR			: in std_logic;
       Stall_PC			: out std_logic;
       Stall_IFID     		: out std_logic;
       Stall_IDEX     		: out std_logic;
       IFID_Flush    		: out std_logic;
       IDEX_Flush    		: out std_logic);
end hazardDetection;

architecture sel_when of hazardDetection is
begin
  process (IFID_RegisterRs,IFID_RegisterRt,IDEX_RegisterRt,IDEX_WriteReg,EXMEM_WriteReg,IDEX_MEMRead,Branch,BranchTaken,Jump,JAL,JR)
  begin
    -- Load-use hazard
    if(IDEX_MEMRead = '1' and ((IDEX_RegisterRt = IFID_RegisterRs) or (IDEX_RegisterRt = IFID_RegisterRt))) then
      Stall_PC <= '1';
      Stall_IFID <= '1';
      IDEX_Flush <= '1';
    -- Jump or jal detected
    elsif((Jump = '1') or (JAL = '1')) then
      IFID_Flush <= '1';
    -- Jr detected and data hazard
    elsif(JR = '1' and (IFID_RegisterRs = IDEX_WriteReg)) then
      Stall_PC <= '1';
      Stall_IFID <= '1';
      IDEX_Flush <= '1';
    -- branch bubble insertion
    elsif(Branch = '1' and ((IDEX_WriteReg = IFID_RegisterRs) or (IDEX_WriteReg = IFID_RegisterRt)) and (IDEX_WriteReg /= "00000")) then
      Stall_PC <= '1';
      Stall_IFID <= '1';
      --IFID_Flush <= '1';
      IDEX_Flush <= '1';
    -- Branch detected
    elsif(BranchTaken = '1') then
      IFID_Flush <= '1';
    else
      Stall_PC <= '0';
      Stall_IFID <= '0';
      Stall_IDEX <= '0';
      IFID_Flush <= '0';
      IDEX_Flush <= '0';
    end if;
  end process;
end sel_when;