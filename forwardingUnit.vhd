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
       JR			: in std_logic;
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
       ForwardRs		: out std_logic; --Use forward mux data
       ForwardRt		: out std_logic; --Use forward mux data
       ForwardRsSel		: out std_logic; --Forward Rs mux selector
       ForwardRtSel		: out std_logic); --Forward Rt mux selector
end forwardingUnit;

architecture sel_when of forwardingUnit is

signal sForwardASel,sForwardBSel,sForwardA,sForwardB,sForwardStore,sForwardRs,sForwardRt,sForwardRtSel,sForwardRsSel : std_logic := '0';

begin
  process (EXMEM_RegWrite,MEMWB_RegWrite,Branch,JR,IFID_RegisterRs,IFID_RegisterRt,IDEX_RegisterRs,IDEX_RegisterRt,EXMEM_RegisterRt,EXMEM_WriteReg,MEMWB_WriteReg)
  begin
    -- EX hazard, forward EX/MEM to ALU input A
    if((EXMEM_RegWrite = '1') and (EXMEM_WriteReg /= "00000") and (EXMEM_WriteReg = IDEX_RegisterRs)) then
      sForwardASel <= '1';
      sForwardA <= '1';
    elsif((MEMWB_RegWrite = '1') and (MEMWB_WriteReg /= "00000") and (MEMWB_WriteReg = IDEX_RegisterRs)) then
    -- MEM hazard, forward MEM/WB to ALU input A
      sForwardASel <= '0';
      sForwardA <= '1';
    else
      sForwardA <= '0';
    end if;
    -- EX hazard, forward EX/MEM to ALU input B
    if((EXMEM_RegWrite = '1') and (EXMEM_WriteReg /= "00000") and (EXMEM_WriteReg = IDEX_RegisterRt)) then
      sForwardBSel <= '1';
      sForwardB <= '1';
    elsif((MEMWB_RegWrite = '1') and (MEMWB_WriteReg /= "00000") and (MEMWB_WriteReg = IDEX_RegisterRt)) then
    -- MEM hazard, forward MEM/WB to ALU input B
      sForwardBSel <= '0';
      sForwardB <= '1';
    else
      sForwardB <= '0';
    end if;
    -- Forward from EX/MEM to Rs mux in decode stage
    if(((Branch = '1') or (JR = '1')) and (EXMEM_WriteReg /= "00000") and (EXMEM_WriteReg = IFID_RegisterRs)) then
      sForwardRsSel <= '1';
      sForwardRs <= '1';
    elsif(((Branch = '1') or (JR = '1')) and (MEMWB_WriteReg /= "00000") and (MEMWB_WriteReg = IFID_RegisterRs)) then
    -- Forward from MEM/WB to Rs mux in decode stage
      sForwardRsSel <= '0';
      sForwardRs <= '1';
    else
      sForwardRs <= '0';
    end if;
    -- Forward from EX/MEM to Rt mux in decode stage
    if((Branch = '1') and (EXMEM_WriteReg /= "00000") and (EXMEM_WriteReg = IFID_RegisterRt)) then
      sForwardRtSel <= '1';
      sForwardRt <= '1';
    elsif((Branch = '1') and (MEMWB_WriteReg /= "00000") and (MEMWB_WriteReg = IFID_RegisterRt)) then
    -- Forward from MEM/WB to Rt mux in decode stage
      sForwardRtSel <= '0';
      sForwardRt <= '1';
    else
      sForwardRt <= '0';
    end if;
  end process;
  ForwardA <= sForwardA;
  ForwardB <= sForwardB;
  ForwardASel <= sForwardASel;
  ForwardBSel <= sForwardBSel;
  ForwardRs <= sForwardRs;
  ForwardRt <= sForwardRt;
  ForwardRsSel <= sForwardRsSel;
  ForwardRtSel <= sForwardRtSel;
end sel_when;