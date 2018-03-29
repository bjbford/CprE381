onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pipeline/clk
add wave -noupdate /pipeline/RST
add wave -noupdate /pipeline/Flush
add wave -noupdate /pipeline/Stall
add wave -noupdate /pipeline/Overflow
add wave -noupdate /pipeline/IF_Add4
add wave -noupdate /pipeline/IFID_Add4
add wave -noupdate /pipeline/ID_Add4
add wave -noupdate /pipeline/IDEX_Add4
add wave -noupdate /pipeline/EX_Add4
add wave -noupdate /pipeline/EXMEM_Add4
add wave -noupdate /pipeline/MEM_Add4
add wave -noupdate /pipeline/MEMWB_Add4
add wave -noupdate /pipeline/sDatatoPC
add wave -noupdate /pipeline/IF_instruct
add wave -noupdate /pipeline/ID_instruct
add wave -noupdate /pipeline/WB_Data
add wave -noupdate /pipeline/sMemReg
add wave -noupdate /pipeline/WB_RegWrite
add wave -noupdate /pipeline/WB_RegDst
add wave -noupdate /pipeline/WB_Link
add wave -noupdate /pipeline/sJumpJrBranch
add wave -noupdate /pipeline/ID_RsData
add wave -noupdate /pipeline/ID_RtData
add wave -noupdate /pipeline/ID_Immed
add wave -noupdate /pipeline/EX_ALU
add wave -noupdate /pipeline/EX_Rt_Data
add wave -noupdate /pipeline/MEM_ALU
add wave -noupdate /pipeline/MEM_Data
add wave -noupdate /pipeline/MEMWB_Data
add wave -noupdate /pipeline/IDEX_RsData
add wave -noupdate /pipeline/IDEX_Rt_Data
add wave -noupdate /pipeline/IDEX_Immed
add wave -noupdate /pipeline/EXMEM_ALU
add wave -noupdate /pipeline/EXMEM_Rt_Data
add wave -noupdate /pipeline/MEMWB_ALU
add wave -noupdate /pipeline/ID_ALUOP
add wave -noupdate /pipeline/IDEX_ALUOP
add wave -noupdate /pipeline/ID_instruct5_0
add wave -noupdate /pipeline/IDEX_instruct5_0
add wave -noupdate /pipeline/ID_control
add wave -noupdate /pipeline/IDEX_Control
add wave -noupdate /pipeline/EX_Control
add wave -noupdate /pipeline/EXMEM_Control
add wave -noupdate /pipeline/MEM_Control
add wave -noupdate /pipeline/MEMWB_Control
add wave -noupdate /pipeline/ID_shamt
add wave -noupdate /pipeline/IDEX_shamt
add wave -noupdate /pipeline/decode/WriteData
add wave -noupdate /pipeline/decode/instruction
add wave -noupdate /pipeline/decode/Add4In
add wave -noupdate /pipeline/decode/Rs_Data
add wave -noupdate /pipeline/decode/Rt_Data
add wave -noupdate -radix binary /pipeline/decode/ALUOp
add wave -noupdate /pipeline/decode/Immed
add wave -noupdate /pipeline/decode/shamt
add wave -noupdate /pipeline/decode/DatatoPC
add wave -noupdate /pipeline/decode/Special
add wave -noupdate /pipeline/decode/Add4Out
add wave -noupdate /pipeline/decode/instruct5_0
add wave -noupdate /pipeline/decode/controlOut
add wave -noupdate /pipeline/decode/sAdd4
add wave -noupdate /pipeline/decode/sRt
add wave -noupdate /pipeline/decode/sRs
add wave -noupdate /pipeline/decode/sImmed
add wave -noupdate /pipeline/decode/sBranchAdd
add wave -noupdate /pipeline/decode/sBranchMux
add wave -noupdate /pipeline/decode/sBranchShift
add wave -noupdate /pipeline/decode/sJump
add wave -noupdate /pipeline/decode/sJumpMux
add wave -noupdate /pipeline/decode/instruct15_0
add wave -noupdate /pipeline/decode/instruct31_26
add wave -noupdate /pipeline/decode/sALUOP
add wave -noupdate /pipeline/decode/sinstruct5_0
add wave -noupdate /pipeline/decode/instruct25_21
add wave -noupdate /pipeline/decode/instruct20_16
add wave -noupdate /pipeline/decode/instruct15_11
add wave -noupdate /pipeline/decode/sWrite
add wave -noupdate /pipeline/decode/sWriteReg
add wave -noupdate /pipeline/decode/reg31
add wave -noupdate /pipeline/decode/JumpControl
add wave -noupdate /pipeline/decode/JumpRetControl
add wave -noupdate /pipeline/decode/sBranch
add wave -noupdate /pipeline/decode/sCarryIn
add wave -noupdate /pipeline/decode/sNotZero
add wave -noupdate /pipeline/decode/Zero
add wave -noupdate /pipeline/decode/sZeroMux
add wave -noupdate /pipeline/decode/BranchControl
add wave -noupdate /pipeline/decode/BneControl
add wave -noupdate /pipeline/decode/sBranchOR
add wave -noupdate -expand /pipeline/decode/regs/sQ
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {449 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 215
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
WaveRestoreZoom {105 ns} {1052 ns}