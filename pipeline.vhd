-------------------------------------------------------------------------
-- Brian Bradford
-- CprE 381 - Section A
-- Iowa State University
-------------------------------------------------------------------------

-- pipeline.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a MIPS multi-cycle pipelined processor.
--
-- NOTES:
-- 3/28/18 by BJB:Design created.
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
  port(clk		: in std_logic;
       RST		: in std_logic;
       Flush		: in std_logic;
       Stall		: in std_logic;
       Overflow		: out std_logic);
end pipeline;

architecture structure of pipeline is
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
       add4DataIn		: in std_logic_vector(31 downto 0);
       RsDataIn			: in std_logic_vector(31 downto 0);
       RtDataIn			: in std_logic_vector(31 downto 0);
       ImmedIn			: in std_logic_vector(31 downto 0);
       ALUOpIn			: in std_logic_vector(5 downto 0);
       shamtIn			: in std_logic_vector(4 downto 0);
       instruct5_0In		: in std_logic_vector(5 downto 0);
       controlIn		: in std_logic_vector(4 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       RsDataOut		: out std_logic_vector(31 downto 0);
       RtDataOut		: out std_logic_vector(31 downto 0);
       ImmedOut			: out std_logic_vector(31 downto 0);
       ALUOpOut			: out std_logic_vector(5 downto 0);
       shamtOut			: out std_logic_vector(4 downto 0);
       instruct5_0Out		: out std_logic_vector(5 downto 0);
       controlOut		: out std_logic_vector(4 downto 0));
end component;

component pipeEXMEM
  port(clk			: in std_logic;
       RST			: in std_logic;
       Stall			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       ALUResultIn		: in std_logic_vector(31 downto 0);
       RtDataIn			: in std_logic_vector(31 downto 0);
       controlIn		: in std_logic_vector(4 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       ALUResultOut		: out std_logic_vector(31 downto 0);
       RtDataOut		: out std_logic_vector(31 downto 0);
       controlOut		: out std_logic_vector(4 downto 0));
end component;

component pipeMEMWB
  port(clk			: in std_logic;
       RST			: in std_logic;
       Stall			: in std_logic;
       add4DataIn		: in std_logic_vector(31 downto 0);
       ALUResultIn		: in std_logic_vector(31 downto 0);
       ReadDataIn		: in std_logic_vector(31 downto 0);
       controlIn		: in std_logic_vector(4 downto 0);
       add4DataOut		: out std_logic_vector(31 downto 0);
       ALUResultOut		: out std_logic_vector(31 downto 0);
       ReadDataOut		: out std_logic_vector(31 downto 0);
       controlOut		: out std_logic_vector(4 downto 0));
end component;

component fetchStage
  port(clk		: in std_logic;
       RST		: in std_logic;
       JumpJrBranch	: in std_logic;
       Special		: in std_logic_vector(31 downto 0);
       Add4Out		: out std_logic_vector(31 downto 0);
       instruct		: out std_logic_vector(31 downto 0));
end component;

component decodeStage
  port(clk	    	: in std_logic;
       RST	    	: in std_logic;
       RegWrite     	: in std_logic;
       RegDst     	: in std_logic;
       Link		: in std_logic;
       WriteData    	: in std_logic_vector(31 downto 0);
       instruction    	: in std_logic_vector(31 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       Rs_Data      	: out std_logic_vector(31 downto 0);
       Rt_Data      	: out std_logic_vector(31 downto 0);
       ALUOp		: out std_logic_vector(5 downto 0);
       Immed  		: out std_logic_vector(31 downto 0);
       shamt  		: out std_logic_vector(4 downto 0);
       DatatoPC		: out std_logic_vector(31 downto 0);
       Special		: out std_logic;
       Add4Out    	: out std_logic_vector(31 downto 0);
       instruct5_0    	: out std_logic_vector(5 downto 0);
       controlOut	: out std_logic_vector(4 downto 0));
end component;

component executionStage
  port(Rs_Data      	: in std_logic_vector(31 downto 0);
       Rt_Data      	: in std_logic_vector(31 downto 0);
       ALUOp		: in std_logic_vector(5 downto 0);
       Immed  		: in std_logic_vector(31 downto 0);
       shamt  		: in std_logic_vector(4 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       instruct5_0	: in std_logic_vector(5 downto 0);
       controlIn	: in std_logic_vector(4 downto 0);
       ALUResult	: out std_logic_vector(31 downto 0);
       Rt_DataOut    	: out std_logic_vector(31 downto 0);
       Add4Out    	: out std_logic_vector(31 downto 0);
       controlOut	: out std_logic_vector(4 downto 0);
       Overflow		: out std_logic);
end component;

component memoryStage
  port(clk		: in std_logic;
       Rt_Data      	: in std_logic_vector(31 downto 0);
       Add4In    	: in std_logic_vector(31 downto 0);
       controlIn	: in std_logic_vector(4 downto 0);
       ALUResult	: in std_logic_vector(31 downto 0);
       ReadData    	: out std_logic_vector(31 downto 0);
       Add4Out    	: out std_logic_vector(31 downto 0);
       ALUResultOut    	: out std_logic_vector(31 downto 0);
       controlOut	: out std_logic_vector(4 downto 0));
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
signal WB_RegWrite,WB_RegDst,WB_Link,sJumpJrBranch : std_logic;
signal ID_RsData,ID_RtData,ID_Immed,EX_ALU,EX_Rt_Data,MEM_ALU,MEM_Data,MEMWB_Data 	: std_logic_vector(31 downto 0);
signal IDEX_RsData,IDEX_Rt_Data,IDEX_Immed,EXMEM_ALU,EXMEM_Rt_Data,MEMWB_ALU 	: std_logic_vector(31 downto 0);
signal ID_ALUOP,IDEX_ALUOP			: std_logic_vector(5 downto 0);
signal ID_instruct5_0,IDEX_instruct5_0		: std_logic_vector(5 downto 0);
signal ID_control,IDEX_Control,EX_Control,EXMEM_Control,MEM_Control,MEMWB_Control 	: std_logic_vector(4 downto 0);
signal ID_shamt, IDEX_shamt 			: std_logic_vector(4 downto 0);

begin
  fetch: fetchStage port map(clk,RST,sJumpJrBranch,sDatatoPC,IF_Add4,IF_instruct); 
  IFID_regs: pipeIFID port map(clk,RST,Flush,Stall,IF_Add4,IF_instruct,IFID_Add4,ID_instruct); 

  decode: decodeStage port map(clk,RST,WB_RegWrite,WB_RegDst,WB_Link,WB_Data,ID_instruct,IFID_Add4,
				ID_RsData,ID_RtData,ID_ALUOP,ID_Immed,ID_shamt,sDatatoPC,sJumpJrBranch,ID_Add4,ID_instruct5_0,ID_control);
  IDEX_regs: pipeIDEX port map(clk,RST,Stall,ID_Add4,ID_RsData,ID_RtData,ID_Immed,ID_ALUOP,ID_shamt,ID_instruct5_0,ID_Control,
				IDEX_Add4,IDEX_RsData,IDEX_Rt_Data,IDEX_Immed,IDEX_ALUOP,IDEX_shamt,IDEX_instruct5_0,IDEX_Control);

  execute: executionStage port map(IDEX_RsData,IDEX_Rt_Data,IDEX_ALUOP,IDEX_Immed,IDEX_shamt,IDEX_Add4,IDEX_instruct5_0,IDEX_Control,
					EX_ALU,EX_Rt_Data,EX_Add4,EX_Control,Overflow);
  EXMEM_regs: pipeEXMEM port map(clk,RST,Stall,EX_Add4,EX_ALU,EX_Rt_Data,EX_Control,
					EXMEM_Add4,EXMEM_ALU,EXMEM_Rt_Data,EXMEM_Control);

  mem: memoryStage port map(clk,EXMEM_Rt_Data,EXMEM_Add4,EXMEM_Control,EXMEM_ALU,MEM_Data,MEM_Add4,MEM_ALU,MEM_Control);
  MEMWB_regs: pipeMEMWB port map(clk,RST,Stall,MEM_Add4,MEM_ALU,MEM_Data,MEM_Control,
					MEMWB_Add4,MEMWB_ALU,MEMWB_Data,MEMWB_Control);
  WB_RegWrite <= MEMWB_Control(2);
  WB_RegDst <= MEMWB_Control(4);
  WB_Link <= MEMWB_Control(3);
  MemtoReg_mux: mux2to1Nbit port map(MEMWB_Data,MEMWB_ALU,MEMWB_Control(0),sMemReg);
  Link_mux: mux2to1Nbit port map(sMemReg,MEMWB_Add4,WB_Link,WB_Data);
end structure;