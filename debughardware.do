onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hardwarescheduledpipeline/clk
add wave -noupdate /hardwarescheduledpipeline/RST
add wave -noupdate /hardwarescheduledpipeline/Stall_EXMEM
add wave -noupdate /hardwarescheduledpipeline/Stall_MEMWB
add wave -noupdate /hardwarescheduledpipeline/Overflow
add wave -noupdate /hardwarescheduledpipeline/sDatatoPC
add wave -noupdate /hardwarescheduledpipeline/IF_instruct
add wave -noupdate /hardwarescheduledpipeline/WB_Data
add wave -noupdate /hardwarescheduledpipeline/sMemReg
add wave -noupdate /hardwarescheduledpipeline/sJumpJrBranch
add wave -noupdate /hardwarescheduledpipeline/IFID_Flush
add wave -noupdate /hardwarescheduledpipeline/Stall_PC
add wave -noupdate /hardwarescheduledpipeline/Stall_IFID
add wave -noupdate /hardwarescheduledpipeline/Stall_IDEX
add wave -noupdate -expand /hardwarescheduledpipeline/decode/regs/sQ
add wave -noupdate -expand -group Add4's -radix decimal /hardwarescheduledpipeline/IF_Add4
add wave -noupdate -expand -group Add4's /hardwarescheduledpipeline/IFID_Add4
add wave -noupdate -expand -group Add4's /hardwarescheduledpipeline/ID_Add4
add wave -noupdate -expand -group Add4's /hardwarescheduledpipeline/IDEX_Add4
add wave -noupdate -expand -group Add4's /hardwarescheduledpipeline/EX_Add4
add wave -noupdate -expand -group Add4's /hardwarescheduledpipeline/EXMEM_Add4
add wave -noupdate -expand -group Add4's /hardwarescheduledpipeline/MEM_Add4
add wave -noupdate -expand -group Add4's /hardwarescheduledpipeline/MEMWB_Add4
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_MemRead
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_RsData
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_RtData
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_Immed
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_ALUOP
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/IDEX_instruct5_0
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_shamt
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_instruct20_16
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_instruct25_21
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_instruct
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_instruct5_0
add wave -noupdate -group IDsignals /hardwarescheduledpipeline/ID_control
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/Flush
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/Stall
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/add4DataIn
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/imemDataIn
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/add4DataOut
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/imemDataOut
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/sWE
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/simemDataIn
add wave -noupdate -group IFID_regs /hardwarescheduledpipeline/IFID_regs/sadd4DataIn
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_Flush
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_MemRead
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_RsData
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_Rt_Data
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_Immed
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_ALUOP
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_shamt
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_instruct20_16
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_instruct25_21
add wave -noupdate -group IDEXsignals /hardwarescheduledpipeline/IDEX_Control
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/Stall
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/Flush
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/add4DataIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/RsDataIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/RtDataIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/ImmedIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/ALUOpIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/shamtIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/instruct25_21In
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/instruct20_16In
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/instruct5_0In
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/controlIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/MemReadIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/add4DataOut
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/RsDataOut
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/RtDataOut
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/ImmedOut
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/ALUOpOut
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/shamtOut
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/instruct25_21Out
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/instruct20_16Out
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/instruct5_0Out
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/controlOut
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/MemReadOut
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sWE
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sMemReadIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sadd4DataIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sRsDataIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sRtDataIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sImmedIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sALUOpIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sinstruct5_0In
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sshamtIn
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sinstruct25_21In
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/sinstruct20_16In
add wave -noupdate -group IDEX_regs /hardwarescheduledpipeline/IDEX_regs/scontrolIn
add wave -noupdate -group {EX signals} /hardwarescheduledpipeline/EX_ALU
add wave -noupdate -group {EX signals} /hardwarescheduledpipeline/EX_Rt_Data
add wave -noupdate -group {EX signals} /hardwarescheduledpipeline/EX_Control
add wave -noupdate -group {EX signals} /hardwarescheduledpipeline/EX_instruct20_16
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/Stall
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/add4DataIn
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/ALUResultIn
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/RtDataIn
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/instruct20_16In
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/controlIn
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/add4DataOut
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/ALUResultOut
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/RtDataOut
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/instruct20_16Out
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/controlOut
add wave -noupdate -group EXMEM_regs /hardwarescheduledpipeline/EXMEM_regs/sWE
add wave -noupdate -group EXMEMsignals /hardwarescheduledpipeline/EXMEM_instruct20_16
add wave -noupdate -group EXMEMsignals /hardwarescheduledpipeline/EXMEM_Control
add wave -noupdate -group EXMEMsignals /hardwarescheduledpipeline/EXMEM_ALU
add wave -noupdate -group EXMEMsignals /hardwarescheduledpipeline/EXMEM_Rt_Data
add wave -noupdate -group MEMsignals /hardwarescheduledpipeline/MEM_ALU
add wave -noupdate -group MEMsignals /hardwarescheduledpipeline/MEM_Data
add wave -noupdate -group MEMsignals /hardwarescheduledpipeline/MEMWB_Data
add wave -noupdate -group MEMsignals /hardwarescheduledpipeline/MEMWB_ALU
add wave -noupdate -group MEMsignals /hardwarescheduledpipeline/MEM_Control
add wave -noupdate -group MEMWBsignals /hardwarescheduledpipeline/MEMWB_Control
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/Stall
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/add4DataIn
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/ALUResultIn
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/ReadDataIn
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/controlIn
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/add4DataOut
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/ALUResultOut
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/ReadDataOut
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/controlOut
add wave -noupdate -group MEMWB_regs /hardwarescheduledpipeline/MEMWB_regs/sWE
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/RegWrite
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/WriteRegIn
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/WriteData
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/instruction
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Add4In
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/IDEX_RegisterRt
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/EXMEM_WriteReg
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/IDEX_MEMRead
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/ForwardRsSel
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/ForwardRtSel
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/EXMEM_ALUResult
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Stall_PC
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Stall_IFID
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/IFID_Flush
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/IDEX_Flush
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Rs_Data
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Rt_Data
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/ALUOp
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Immed
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/shamt
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/DatatoPC
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Special
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Add4Out
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/WriteRegOut
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/instruct25_21
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/instruct20_16
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/instruct5_0
add wave -noupdate -expand -group Decode -radix binary /hardwarescheduledpipeline/decode/controlOut
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/MemRead
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Branch
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sAdd4
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sRt
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sRs
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sImmed
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sBranchAdd
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sBranchMux
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sBranchShift
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sJump
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sJumpMux
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sRsRegData
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sRtRegData
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/instruct15_0
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/instruct31_26
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sinstruct5_0
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sinstruct25_21
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sinstruct20_16
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sinstruct15_11
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sRegDst
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/JumpControl
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/JumpRetControl
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sBranch
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sCarryIn
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sNotZero
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/Zero
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sZeroMux
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/BranchControl
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/BneControl
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sBranchOR
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sLink
add wave -noupdate -expand -group Decode /hardwarescheduledpipeline/decode/sRegDstControl
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/Rs_Data
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/Rt_Data
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/ALUOp
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/Immed
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/shamt
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/Add4In
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/instruct25_21In
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/instruct20_16In
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/instruct5_0
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/controlIn
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/EXMEM_RegWrite
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/MEMWB_RegWrite
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/EXMEM_ALUResult
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/WB_WriteData
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/WriteDataOut
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/ALUResult
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/Add4Out
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/instruct20_16Out
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/controlOut
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/Overflow
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/AmuxOut
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/BmuxOut
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sAdd4
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sForwardASource
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sForwardBSource
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/Bnormal
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sShamt
add wave -noupdate -expand -group execute -radix binary /hardwarescheduledpipeline/execute/sALUSrc
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sControl
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sControlVector
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sinstruct20_16
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sForwardA
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sForwardB
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sForwardASel
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/sForwardBSel
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/inputALUSrc
add wave -noupdate -expand -group execute /hardwarescheduledpipeline/execute/ALUSelectA
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/Add4In
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/controlIn
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/ALUResult
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/WriteRegIn
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/ReadData
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/Add4Out
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/ALUResultOut
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/WriteRegOut
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/controlOut
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/sAdd4
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/sALUResult
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/sWriteReg
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/truncate
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/dmemAddr
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/WriteData
add wave -noupdate -expand -group Memory /hardwarescheduledpipeline/mem/sControl
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/EXMEM_RegWrite
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/MEMWB_RegWrite
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/Branch
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/IFID_RegisterRs
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/IFID_RegisterRt
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/IDEX_RegisterRs
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/IDEX_RegisterRt
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/EXMEM_RegisterRt
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/EXMEM_WriteReg
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/MEMWB_WriteReg
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/ForwardA
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/ForwardB
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/ForwardASel
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/ForwardBSel
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/ForwardRs
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/ForwardRt
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/sForwardASel
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/sForwardBSel
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/sForwardA
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/sForwardB
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/sForwardRs
add wave -noupdate -expand -group ForwardUnit /hardwarescheduledpipeline/execute/forwardUnit/sForwardRt
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/IFID_RegisterRs
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/IFID_RegisterRt
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/IDEX_RegisterRt
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/IDEX_WriteReg
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/EXMEM_WriteReg
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/IDEX_MEMRead
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/Branch
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/BranchTaken
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/Jump
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/JAL
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/JR
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/Stall_PC
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/Stall_IFID
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/Stall_IDEX
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/IFID_Flush
add wave -noupdate -expand -group HazardUnit /hardwarescheduledpipeline/decode/hazardUnit/IDEX_Flush
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3672 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 401
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {3046 ns} {3997 ns}
