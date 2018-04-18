-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- hardwareScheduledPipeline.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a MIPS multi-cycle hardware-scheduled
-- pipelined processor.
--
-- NOTES:
-- 4/10/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity hardwareScheduledPipeline is
  port(clk		: in std_logic;
       RST		: in std_logic;
       Stall_EXMEM	: in std_logic;
       Stall_MEMWB	: in std_logic;
       Overflow		: out std_logic);
end hardwareScheduledPipeline;

architecture structure of hardwareScheduledPipeline is
component pipeIFID
  port(clk			: in std_logic;
       RST			: in std_logic;
       Flush			: in std_logic;
       Stall			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       imemDataIn		: in std_logic_vector(31 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       imemDataOut		: out std_logic_vector(31 downto 0));
end component;

component pipeIDEX
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
end component;

component pipeEXMEM
  port(clk			: in std_logic;
       RST			: in std_logic;
       Stall			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       ALUResultIn		: in std_logic_vector(31 downto 0);
       RtDataIn			: in std_logic_vector(31 downto 0);
       WriteRegIn		: in std_logic_vector(4 downto 0);
       instruct20_16In		: in std_logic_vector(4 downto 0);
       controlIn		: in std_logic_vector(3 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       ALUResultOut		: out std_logic_vector(31 downto 0);
       RtDataOut		: out std_logic_vector(31 downto 0);
       WriteRegOut		: out std_logic_vector(4 downto 0);
       instruct20_16Out		: out std_logic_vector(4 downto 0);
       controlOut		: out std_logic_vector(3 downto 0));
end component;

component pipeMEMWB
  port(clk			: in std_logic;
       RST			: in std_logic;
       Stall			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       ALUResultIn		: in std_logic_vector(31 downto 0);
       ReadDataIn		: in std_logic_vector(31 downto 0);
       WriteRegIn		: in std_logic_vector(4 downto 0);
       controlIn		: in std_logic_vector(3 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       ALUResultOut		: out std_logic_vector(31 downto 0);
       ReadDataOut		: out std_logic_vector(31 downto 0);
       WriteRegOut		: out std_logic_vector(4 downto 0);
       controlOut		: out std_logic_vector(3 downto 0));
end component;

component fetchStage
  port(clk		: in std_logic;
       RST		: in std_logic;
       JumpJrBranch	: in std_logic;
       Stall		: in std_logic;
       Special		: in std_logic_vector(31 downto 0);
       Add4Out		: out std_logic_vector(31 downto 0);
       instruct		: out std_logic_vector(31 downto 0));
end component;

component decodeStage
  port(clk	    	: in std_logic;
       RST	    	: in std_logic;
       RegWrite     	: in std_logic;
       WriteRegIn	: in std_logic_vector(4 downto 0);
       WriteData    	: in std_logic_vector(31 downto 0);
       instruction    	: in std_logic_vector(31 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       IDEX_RegisterRt  : in std_logic_vector(4 downto 0);
       IDEX_WriteReg	: in std_logic_vector(4 downto 0);
       EXMEM_WriteReg   : in std_logic_vector(4 downto 0);
       IDEX_MEMRead	: in std_logic;
       ForwardRs	: in std_logic;
       ForwardRt	: in std_logic;
       ForwardRsSel	: in std_logic;
       ForwardRtSel	: in std_logic;
       EXMEM_ALUResult  : in std_logic_vector(31 downto 0);
       WB_WriteData  	: in std_logic_vector(31 downto 0);
       Stall_PC		: out std_logic;
       Stall_IFID     	: out std_logic;
       Stall_IDEX     	: out std_logic;
       IFID_Flush    	: out std_logic;
       IDEX_Flush    	: out std_logic;
       Rs_Data      	: out std_logic_vector(31 downto 0);
       Rt_Data      	: out std_logic_vector(31 downto 0);
       ALUOp		: out std_logic_vector(5 downto 0);
       Immed  		: out std_logic_vector(31 downto 0);
       shamt  		: out std_logic_vector(4 downto 0);
       DatatoPC		: out std_logic_vector(31 downto 0);
       Special		: out std_logic;
       Add4Out    	: out std_logic_vector(31 downto 0);
       WriteRegOut	: out std_logic_vector(4 downto 0);
       instruct25_21	: out std_logic_vector(4 downto 0);
       instruct20_16	: out std_logic_vector(4 downto 0);
       instruct5_0    	: out std_logic_vector(5 downto 0);
       controlOut	: out std_logic_vector(3 downto 0);
       MemRead		: out std_logic;
       Branch     	: out std_logic;
       JR	     	: out std_logic);
end component;

component executionStage
  port(Rs_Data      	: in std_logic_vector(31 downto 0);
       Rt_Data      	: in std_logic_vector(31 downto 0);
       ALUOp		: in std_logic_vector(5 downto 0);
       Immed  		: in std_logic_vector(31 downto 0);
       shamt  		: in std_logic_vector(4 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       WriteRegIn	: in std_logic_vector(4 downto 0);
       IFID_RegisterRs	: in std_logic_vector(4 downto 0);
       IFID_RegisterRt	: in std_logic_vector(4 downto 0);
       instruct25_21In	: in std_logic_vector(4 downto 0);
       instruct20_16In	: in std_logic_vector(4 downto 0);
       instruct5_0	: in std_logic_vector(5 downto 0);
       controlIn	: in std_logic_vector(3 downto 0);
       EXMEM_RegisterRt : in std_logic_vector(4 downto 0);
       EXMEM_WriteReg	: in std_logic_vector(4 downto 0);
       MEMWB_WriteReg	: in std_logic_vector(4 downto 0);
       EXMEM_RegWrite   : in std_logic;
       MEMWB_RegWrite   : in std_logic;
       Branch		: in std_logic;
       JR		: in std_logic;
       EXMEM_ALUResult  : in std_logic_vector(31 downto 0);
       WB_WriteData	: in std_logic_vector(31 downto 0);
       ALUResult	: out std_logic_vector(31 downto 0);
       WriteDataOut    	: out std_logic_vector(31 downto 0);
       Add4Out    	: out std_logic_vector(31 downto 0);
       WriteRegOut	: out std_logic_vector(4 downto 0);
       instruct20_16Out	: out std_logic_vector(4 downto 0);
       controlOut	: out std_logic_vector(3 downto 0);
       ForwardRs	: out std_logic; --Use forward mux data
       ForwardRt	: out std_logic; --Use forward mux data
       ForwardRsSel	: out std_logic; --Forward Rs mux selector
       ForwardRtSel	: out std_logic; --Forward Rt mux selector
       Overflow		: out std_logic);
end component;

component memoryStage
  port(clk		: in std_logic;
       WriteData      	: in std_logic_vector(31 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       controlIn	: in std_logic_vector(3 downto 0);
       ALUResult	: in std_logic_vector(31 downto 0);
       MEMWB_ALUResult	: in std_logic_vector(31 downto 0);
       WriteRegIn	: in std_logic_vector(4 downto 0);
       ReadData    	: out std_logic_vector(31 downto 0);
       Add4Out    	: out std_logic_vector(31 downto 0);
       ALUResultOut    	: out std_logic_vector(31 downto 0);
       WriteRegOut	: out std_logic_vector(4 downto 0);
       controlOut	: out std_logic_vector(3 downto 0));
end component;

component mux2to1Nbit
  generic(N : integer := 32);
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B	    : in std_logic_vector(N-1 downto 0);
       i_X	    : in std_logic;
       o_Y          : out std_logic_vector(N-1 downto 0));
end component;

signal IF_Add4,IFID_Add4,ID_Add4,IDEX_Add4,EX_Add4,EXMEM_Add4,MEM_Add4,MEMWB_Add4 : std_logic_vector(31 downto 0);
signal sDatatoPC,IF_instruct,ID_instruct,WB_Data,sMemReg : std_logic_vector(31 downto 0);
signal sJumpJrBranch,IFID_Flush,IDEX_Flush,Stall_PC,Stall_IFID,Stall_IDEX,IDEX_MemRead,ID_MemRead,ID_Branch,ID_JR,EX_ForwardStore,EX_ForwardRs,EX_ForwardRt,EX_ForwardRsSel,EX_ForwardRtSel : std_logic;
signal ID_RsData,ID_RtData,ID_Immed,EX_ALU,EX_Rt_Data,MEM_ALU,MEM_Data,MEMWB_Data 	: std_logic_vector(31 downto 0);
signal IDEX_RsData,IDEX_Rt_Data,IDEX_Immed,EXMEM_ALU,EXMEM_Rt_Data,MEMWB_ALU 	: std_logic_vector(31 downto 0);
signal ID_ALUOP,IDEX_ALUOP			: std_logic_vector(5 downto 0);
signal ID_instruct5_0,IDEX_instruct5_0		: std_logic_vector(5 downto 0);
signal ID_control,IDEX_Control,EX_Control,EXMEM_Control,MEM_Control,MEMWB_Control 	: std_logic_vector(3 downto 0);
signal ID_shamt,IDEX_shamt,ID_instruct20_16	: std_logic_vector(4 downto 0);
signal IDEX_instruct20_16,EX_instruct20_16,EXMEM_instruct20_16 : std_logic_vector(4 downto 0);
signal ID_instruct25_21,IDEX_instruct25_21 : std_logic_vector(4 downto 0);
signal ID_WriteReg,MEMWB_WriteReg,IDEX_WriteReg,EX_WriteReg,EXMEM_WriteReg,MEM_WriteReg : std_logic_vector(4 downto 0);

begin
  fetch: fetchStage port map(clk,RST,sJumpJrBranch,Stall_PC,sDatatoPC,IF_Add4,IF_instruct);
  IFID_regs: pipeIFID port map(clk,RST,IFID_Flush,Stall_IFID,IF_Add4,IF_instruct,IFID_Add4,ID_instruct);

  decode: decodeStage port map(clk,RST,MEMWB_Control(2),MEMWB_WriteReg,WB_Data,ID_instruct,IFID_Add4,IDEX_instruct20_16,IDEX_WriteReg,EXMEM_WriteReg,IDEX_MemRead,EX_ForwardRs,EX_ForwardRt,EX_ForwardRsSel,EX_ForwardRtSel,EXMEM_ALU,WB_Data,Stall_PC,Stall_IFID,Stall_IDEX,IFID_Flush,IDEX_Flush,
				ID_RsData,ID_RtData,ID_ALUOP,ID_Immed,ID_shamt,sDatatoPC,sJumpJrBranch,ID_Add4,ID_WriteReg,ID_instruct25_21,ID_instruct20_16,ID_instruct5_0,ID_control,ID_MemRead,ID_Branch,ID_JR);

  IDEX_regs: pipeIDEX port map(clk,RST,Stall_IDEX,IDEX_Flush,ID_Add4,ID_RsData,ID_RtData,ID_Immed,ID_ALUOP,ID_shamt,ID_WriteReg,ID_instruct25_21,ID_instruct20_16,ID_instruct5_0,ID_Control,ID_MemRead,
				IDEX_Add4,IDEX_RsData,IDEX_Rt_Data,IDEX_Immed,IDEX_ALUOP,IDEX_shamt,IDEX_WriteReg,IDEX_instruct25_21,IDEX_instruct20_16,IDEX_instruct5_0,IDEX_Control,IDEX_MemRead);

  execute: executionStage port map(IDEX_RsData,IDEX_Rt_Data,IDEX_ALUOP,IDEX_Immed,IDEX_shamt,IDEX_Add4,IDEX_WriteReg,ID_instruct25_21,ID_instruct20_16,IDEX_instruct25_21,IDEX_instruct20_16,IDEX_instruct5_0,IDEX_Control,EXMEM_instruct20_16,EXMEM_WriteReg,MEMWB_WriteReg,
					EXMEM_Control(2),MEMWB_Control(2),ID_Branch,ID_JR,EXMEM_ALU,WB_Data,EX_ALU,EX_Rt_Data,EX_Add4,EX_WriteReg,EX_instruct20_16,EX_Control,EX_ForwardRs,EX_ForwardRt,EX_ForwardRsSel,EX_ForwardRtSel,Overflow);

  EXMEM_regs: pipeEXMEM port map(clk,RST,Stall_EXMEM,EX_Add4,EX_ALU,EX_Rt_Data,EX_WriteReg,EX_instruct20_16,EX_Control,
					EXMEM_Add4,EXMEM_ALU,EXMEM_Rt_Data,EXMEM_WriteReg,EXMEM_instruct20_16,EXMEM_Control);

  mem: memoryStage port map(clk,EXMEM_Rt_Data,EXMEM_Add4,EXMEM_Control,EXMEM_ALU,MEMWB_ALU,EXMEM_WriteReg,
          MEM_Data,MEM_Add4,MEM_ALU,MEM_WriteReg,MEM_Control);
  
  MEMWB_regs: pipeMEMWB port map(clk,RST,Stall_MEMWB,MEM_Add4,MEM_ALU,MEM_Data,MEM_WriteReg,MEM_Control,
					MEMWB_Add4,MEMWB_ALU,MEMWB_Data,MEMWB_WriteReg,MEMWB_Control);

  MemtoReg_mux: mux2to1Nbit port map(MEMWB_Data,MEMWB_ALU,MEMWB_Control(0),sMemReg);
  Link_mux: mux2to1Nbit port map(sMemReg,MEMWB_Add4,MEMWB_Control(3),WB_Data);
end structure;