# No Operation in order to pulse RST.
	addi $0, $0, 0
	addi $0, $0, 0


# add 0 & 256 into $26. USED FOR FINAL MEMORY DESTINATION.
	addi $26, $0, 512

# add 0 & 1000 into $10. USED FOR TEMPORARY LOADS AND STORES.
	addi $10, $0, 1000

	
# beq (fail, should fall through)
	addi $1, $0, 1
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	beq $0, $1, BeqNext
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop

	
# beq (success branch to BeqNext)
	addi $1, $0, 0
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	beq $1, $0, BeqNext
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop

	
# random instruction that should never be executed. ($8 = 0xFFFFFFFF)
	addi $8, $0, -1
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)

# a random instruction to see if we branched successfully. ($8 = 0x4)
BeqNext:
	addi $8, $0, 4
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)
	
	
# bne (fail, should fall through)
    addi $1, $0, 0
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	bne $1, $0, BneNext
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop

	
# bne (success branch to BneNext)
    addi $1, $0, 1
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	bne $1, $0, BneNext
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	
# random instruction that should never be executed. ($8 = 0xFFFFFFFE)
	addi $8, $0, -2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)

# a random instruction to see if we branched successfully. ($8 = 0x5)
BneNext:
	addi $8, $0, 5
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)

	
# jump to JumpTest instruction
	j JumpTest

	
# random instruction that should never be executed. ($8 = 0xFFFFFFFD)
	addi $8, $0, -3
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)
	
# a random instruction to see if we branched successfully. ($8 = 0x2)
JumpTest:
	addi $8, $0, 2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)
	
	
# jump and link to JALTest instruction, the value stored in $31 should be 0x00000128 if PC + 4
	jal JALTest
	
	
# random instruction that should never be executed. ($8 = 0xFFFFFFFC)
	addi $8, $0, -4
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)
	
# a random instruction to see if we jump successfully. ($8 = 0x3)
JALTest:
	addi $8, $0, 3
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)
	

# jr (jump forward 2 instructions). Assumming jump address desired is 0x00000158.
	lui $1, 0
	ori $1, $0, 0x158
	jr $1
	
# random instruction that should never be executed. ($8 = 0xFFFFFFFB)
	addi $8, $0, -5
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)
	
# a random instruction to see if we jump successfully. ($8 = 0x8)
	addi $8, $0, 8
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $8, 32($0)

	
# add  (Should be decimal 7)
	addi $1, $0, 5
	addi $2, $0, 2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $2, 4($10)
	
	lw $3, 0($10)
	lw $4, 4($10)
	
	add $5, $3, $4
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $5, 0($26)
	
	

# addi  (Should be decimal 9)
	addi $1, $0, 7
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	lw $2, 0($10)
	
	addi $3, $2, 2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $3, 4($26)
	
	
	
# addiu w/o overflow  (Should be hex 0)
    # sALUOP <= "0001";
	
    lui $1, 0x7FFF
	ori $1, 0xFFFF
	
	addi $1, $0, 1
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	lw $2, 0($10)
	
    addiu $3, $2, 0xFFFF
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 8($26)
	
	
	
# addu  (Should be decimal 10)
	addi $1, $0, 6
	addi $2, $0, 4
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $2, 4($10)
	
	lw $3, 0($10)
	lw $4, 4($10)
	
	addu $5, $3, $4
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $5, 12($26)
	
	
	
# and  (Should be hex 0AAA)
    # sALUOP <= "0010";
	
    addi $1, $0, 2730  #0AAA
    addi $2, $0, 4095  #FFFF
	
    and $3, $1, $2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 16($26)
	
	
	
# andi  (Should be hex 0AAA)
    # sALUOP <= "0010";
	
    addi $1, $0, 2730  #0AAA
	
    andi $2, $1, 0x0FFF
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $2, 20($26)
	
	
	
# nor   (Should be hex FFFF F000)                     
    # sALUOP <= "0101";
	
    addi $1, $0, 2730  #0AAA
    addi $2, $0, 4095  #0FFF
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $2, 4($10)
	
	lw $3, 0($10)
	lw $4, 4($10)
	
    nor $5, $3, $4
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $5, 24($26)
	
	
	
# xor  (Should be hex 0555)
    # sALUOP <= "0100";
	
    addi $1, $0, 2730  #0AAA
    addi $2, $0, 4095  #0FFF
	
    xor $3, $1, $2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 28($26)
	
	
	
# xori  (Should be hex 0555)
    # sALUOP <= "0100";
	
    addi $1, $0, 2730  #0AAA
	
    xori $2, $1, 0x0FFF
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $2, 32($26)
	
	
	
# or  (Should be hex 0FFF)
    # sALUOP <= "0011";
	
    addi $1, $0, 2730  #0AAA
    addi $2, $0, 4095  #0FFF
	
    or $3, $1, $2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 36($26)
	
	
	
# ori  (Should be hex 0FFF)
    # sALUOP <= "0011";
	
    addi $1, $0, 2730  #0AAA
	
    ori $2, $1, 0x0FFF
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $2, 40($26)
	
	
	
#slt with result of 0  (Should be decimal 0)
    # sALUOP <= "1000";
	
    addi $1, $0, 12
    addi $2, $0, 15
	
    slt $3, $2, $1
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 44($26)


# slt with result of 1  (Should be decimal 1)
    #sALUOP <= "1000";
	
    addi $1, $0, 10
    addi $2, $0, 15
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $2, 4($10)
	
	lw $3, 0($10)
	lw $4, 4($10)
	
    slt $5, $3, $4
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $5 48($26)
	
	

# slti with result of 1  (Should be decimal 1)
    #sALUOP <= "1000";
	
    addi $1, $0, 10
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	lw $2, 0($10)
	
    slti $3, $2, 0xF
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $3 52($26)
	
	
	
# sltiu with result of 1  (Should be decimal 1)
    #sALUOP <= "1000";
	
    addi $1, $0, 10
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	lw $2, 0($10)
	
    sltiu $3, $2, 0xF
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $3 56($26)
	
	
	
# sltu with result of 1  (Should be decimal 1)
    #sALUOP <= "1000";
	
    addi $1, $0, 10
	addi $2, $0, 15
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $2, 4($10)
	
	lw $3, 0($10)
	lw $4, 4($10)
	
    sltu $5, $3, $4
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $5 60($26)
	
	
	
# sll  (Should be hex 80)                     
    # sALUOP <= "0110"
	
    addi $1, $0, 1
	
    sll $2, $1, 7   # 7 is the shamt value
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $2, 64($26)
	
	
	
# srl  (Should be decimal 0)                      
    # sALUOP <= "0111"
	
    addi $1, $0, 1
	
    srl $2, $1, 5   # 5 is the shamt value.
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $2, 68($26)
	
	
	
# sra with zero shift-ins  (Should be hex 0380) 
    # sALUOP <= "1111";
	
    addi $1, $0, 28672  #h'7000
	
    sra $2, $1, 5
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $2, 72($26)

	
	
# sra with one shift-ins  (Should be FFFFFC00)  
    # sALUOP <= "1111";
	
    lui $1, 0xFFFF
	
    ori $1, $0, 0x8000
	
    sra $2, $1, 5
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $2, 76($26)
	
	
	
# sub  (Should be decimal 2)
	addi $1, $0, 3
	addi $2, $0, 1
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $2, 4($10)
	
	lw $3, 0($10)
	lw $4, 4($10)
	
	sub $5, $3, $4 
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $5, 80($26)
	
	
	
# subu  (Should be decimal 6)
	addi $1, $0, 9
	addi $2, $0, 3
	
	subu $3, $1, $2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $3, 84($26)
	
	

# lui   (Should be hex FFFF0000)             
	# sALUOP <= "0110";
	
	lui $1, 0xFFFF
	ori $1, 0x0000
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 88($26)
	
	
	
# sllv  (Should be hex 20)                  
    # sALUOP <= "0110"
	
    addi $1, $0, 1
	addi $2, $0, 5
	
    sllv $3, $1, $2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 92($26)
	
	
	
# srlv  (Should be hex 1)              
    # sALUOP <= "0111"
	
    addi $1, $0, 32
	addi $2, $0, 5
	
    srlv $3, $1, $2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 96($26)
	
	
	
# srav  (Should be hex F800) (SHIFT IN 1's)
    # sALUOP <= "1111"
	
    lui $1, 0xFFFF
	
	ori $1, $0, 0x8000
	
	addi $2, $0, 4
	
    srav $3, $1, $2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 100($26)
	
	
	
# srav  (Should be hex 700) (SHIFT IN 0's)
    # sALUOP <= "1111"
	
    addi $1, $0, 28672
	addi $2, $0, 4
	
    srav $3, $1, $2
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $3, 104($26)
	
	
	
# zero w/ addition  (Should be decimal 0)
    # sALUOP <= "0001";
	
    addi $1, $0, 4
	addi $2, $0, -4   #FFFC
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $2, 4($10)
	
	lw $3, 0($10)
	lw $4, 4($10)
	
    add $5, $3, $4 
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $5, 108($26)

	
	
# zero w/ subtraction  (Should be decimal 0)
    # sALUOP <= "1001";
	
    addi $1, $0, 3
    addi $2, $0, 3
	
    sub $3, $2, $1 
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $3, 112($26)
    

	
# overflow w/ addition  (Should be decimal 0)
    # sALUOP <= "0001";
	
    addi $2, $0, 1
    lui $1, 0x7FFF
	ori $1, $0, 0xFFFF
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	
	sw $1, 0($10)
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	sw $2, 4($10)
	
	lw $3, 0($10)
	lw $4, 4($10)
	
    add $5, $3, $4 
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
	addi $0, $0, 0 #noop
    sw $5, 116($26)
