-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- forwardingUnit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains the forwarding unit for the hardware-
-- scheduled pipelined processor.
--
-- NOTES:
-- 4/10/18 by BJB: Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity forwardingUnit is
  port(EXMEM_RegWrite   	: in std_logic;
       MEMWB_RegWrite   	: in std_logic;
       Branch			: in std_logic;
       IFID_RegisterRs		: in std_logic_vector(4 downto 0);
       IFID_RegisterRt		: in std_logic_vector(4 downto 0);
       IDEX_RegisterRs		: in std_logic_vector(4 downto 0);
       IDEX_RegisterRt		: in std_logic_vector(4 downto 0);
       EXMEM_RegisterRt		: in std_logic_vector(4 downto 0);
       EXMEM_WriteReg		: in std_logic_vector(4 downto 0);
       MEMWB_WriteReg		: in std_logic_vector(4 downto 0);
       ForwardA			: out std_logic; -- Use forward mux data
       ForwardB       		: out std_logic; -- Use forward mux data
       ForwardASel		: out std_logic; --Forward A mux selector
       ForwardBSel		: out std_logic; --Forward B mux selector
       ForwardStore		: out std_logic; --Forward Store mux selector
       ForwardRs		: out std_logic; --Forward Rs mux selector
       ForwardRt		: out std_logic); --Forward Rt mux selector
end forwardingUnit;

architecture sel_when of forwardingUnit is

signal sForwardASel,sForwardBSel,sForwardA,sForwardB,sForwardStore,sForwardRs,sForwardRt : std_logic := '0';

begin
  process (EXMEM_RegWrite,MEMWB_RegWrite,Branch,IFID_RegisterRs,IFID_RegisterRt,IDEX_RegisterRs,IDEX_RegisterRt,EXMEM_RegisterRt,EXMEM_WriteReg,MEMWB_WriteReg)
  begin
    -- EX hazard, forward EX/MEM to ALU input A
    if(EXMEM_RegWrite = '1' and (EXMEM_WriteReg /= "00000") and (EXMEM_WriteReg = IDEX_RegisterRs)) then
      sForwardASel <= '1';
      sForwardA <= '1';
    elsif (MEMWB_RegWrite = '1' and (MEMWB_WriteReg /= "00000") and (MEMWB_WriteReg = IDEX_RegisterRs)) then
    -- MEM hazard, forward MEM/WB to ALU input A
      sForwardASel <= '0';
      sForwardA <= '1';
    else
      sForwardA <= '0';
    end if;
    -- EX hazard, forward EX/MEM to ALU input B
    if(EXMEM_RegWrite = '1' and (EXMEM_WriteReg /= "00000") and (EXMEM_WriteReg = IDEX_RegisterRt)) then
      sForwardBSel <= '1';
      sForwardB <= '1';
    elsif (MEMWB_RegWrite = '1' and (MEMWB_WriteReg /= "00000") and (MEMWB_WriteReg = IDEX_RegisterRt)) then
    -- MEM hazard, forward MEM/WB to ALU input B
      sForwardBSel <= '0';
      sForwardB <= '1';
    else
      sForwardB <= '0';
    end if;
    -- Store Forwarding hazard
    if((MEMWB_WriteReg = IDEX_RegisterRt) or (MEMWB_WriteReg = EXMEM_RegisterRt)) then
      sForwardStore <= '1';
    else
      sForwardStore <= '0';
    end if;
    --Branch Forwarding hazard with Rs
    if(Branch = '1' and (MEMWB_WriteReg = IFID_RegisterRs)) then
      sForwardRs <= '1';
    else
      sForwardRs <= '0';
    end if;
    --Branch Forwarding hazard with Rt
    if(Branch = '1' and (MEMWB_WriteReg = IFID_RegisterRt)) then
      sForwardRt <= '1';
    else
      sForwardRt <= '0';
    end if;
  end process;
  ForwardA <= sForwardA;
  ForwardB <= sForwardB;
  ForwardASel <= sForwardASel;
  ForwardBSel <= sForwardBSel;
  ForwardStore <= sForwardStore;
  ForwardRs <= sForwardRs;
  ForwardRt <= sForwardRt;
end sel_when;