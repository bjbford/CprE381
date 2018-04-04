addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op

#### VARIABLE SETUP ####	
lui $a0, 0x0000
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op

ori $a0, 0x1000
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op

addi $t0, $zero, 10	# Length of the final array
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
	
add $t2, $zero, $t0     # Set Counter to number of elements. Will decrement by one with each save.
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op

sll	$t0, $t0, 2	# Multiple length by 4 to get total byte size
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op

add	$a1, $a0, $t0	# Get final array size
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op

add $t1, $zero, $zero   # Iter = 0
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op

j Cond
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op
addi $zero, $zero, 0 # No Op

StartingLoop: 
	addu $t5, $zero, $t2    # $t5 = Count
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	addu $t3, $a0, $t1      # $t3 = &(array[i])
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	sw $t5, 0($t3)     	# arr[i] = Counter          #### FOR LOOP BODY ####
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	addi $t2, $t2, -1  	# Counter--
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	addi $t1, $t1, 4   	# i++
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
Cond:
	slt $t4, $t1, $t0  # Iter < NumElements        #### FOR LOOP CONDITION ####
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	bne $t4, $zero, StartingLoop
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op

#Call MergeSort
jal	MergeSort
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op

j Exit
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op

#This is the mergesort algorithm. It recursively splits the given array until it has individual integers. 
#   At which it calles the merge function to recreate the array in sorted order. 
MergeSort:
	#Increase the depth of the stack.
	addi $sp, $sp, -16
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#Push the ra onto the stack.
	sw $ra, 0($sp)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#Push the array starting address onto the stack. 
	sw $a0, 4($sp)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#Push the array ending address onto the stack. 
	sw $a1, 8($sp)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
		
	#Find the difference between the first and last element of the array.
	sub $t0, $a1, $a0
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#If branch, this means the array only had one element. 
	ble	$t0, 4, MSEnd
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#Else, divide to split the array in half.
	srl	$t0, $t0, 3
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	sll	$t0, $t0, 2
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#Find the middle of the new array. 
	add	$a1, $a0, $t0
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#Push the middle onto the stack. 
	sw $a1, 12($sp)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#This function call back to MergeSort is a recursive call. This call will behave the same, except 
	#   it will carry out those same tasks on the first half of the array. (element 0 -> arraySize/2)
	jal	MergeSort
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op	
	addi $zero, $zero, 0 # No Op
	
	#After the entire first half of the original array has been disected, we need to recursively pop
	#   the middle & end addrresses from the stack as the program prepares to preform the same 
	#   recursive sort on the second half of that original array. (arraySize/2 -> arraySize-1)
	lw $a0, 12($sp)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	lw $a1, 8($sp)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#This function call back to MergeSort is a recursive call. This call will behave the same, except 
	#   it will carry out those same tasks on the second half of the array. (arraySize/2 -> arraySize-1)
	jal	MergeSort
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#After both the first and second halfs of the original array have been disected, we need to call
	#   the merge function to recreate the array, but in a sorted order. Todo this, the program must 
	#   pop the starting, middle, and the ending addresses from the stack. 
	lw $a0, 4($sp)  #Start
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	lw $a1, 12($sp) #Middle
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	lw $a2, 8($sp)  #End
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#This is the final part of the MergeSort algorithm. As described above, it will recreate the original 
	#   array in sorted order by placing the left and right sub arrays in their respective places.
	jal	Merge
	
#This is signaled by the ending of the Merge & MergeSort functions. In order to return to the main program,
#   the program needs to pop one final time to recover its original return address. (the first MergeSort call)
#   Along with recovering the return address, the program adjusts the stack pointer by raising its depth back 
#   to coincide with the stack point depth of the original program. 
MSEnd:				
	lw $ra, 0($sp)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	addi $sp, $sp, 16
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	jr $ra
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
#This is the final part of the MergeSort algorithm. As described above, it will recreate the original 
#   array in sorted order by placing the left and right sub arrays in their respective places.
Merge:
	#Since merge needs to return to where it was called much like other functions in our program, it has
	#   to push its return address, its (start middle end) addresses, and adjust the stack pointer to
	#   hold these additional variables. 
	addi $sp, $sp, -16
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	sw $ra, 0($sp)  #Ra
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	sw $a0, 4($sp)  #Start
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	sw $a1, 8($sp)  #Middle
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	sw $a2, 12($sp) #End
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#These following instructions generate temporary versions of the addresses used in both the first and
	#   second half of the original array. From these, the program can iterate over 
	add $s0, $a0, $zero
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	add $s1, $a1, $zero
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
#This function iterates through the first and second halves of the array while comparing their values. If
#   it is found that the second half value is less then that of the first half value, the program moves 
#   that element to the its appropriate position. This is done by iterating over the first and second
#   subarrays and either incrementing or decrementing the index levels until it is found that the 
#   lesser value has been moved to that of a positon that is below the higher value. 
MergeSortLoop:
	#The below two instructions load up the index of the first half of the array and its corresponding value. 
	lw $t0, 0($s0)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#The below two instructions load up the index of the second half of the array and its corresponding value.
	lw $t1, 0($s1)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#If branch, this means that the value of the first half is less than that of the second half, which
	#   is what is needed in order for the array to be sorted. 
	blt $t0, $t1, Acceptable
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	
	#These below two instructions firstly pop the value stored in the argument register from the stack
	#   and then pop the address that the value will be sent to from the stack as well. 
	add $a0, $s1, $zero
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	add $a1, $s0, $zero
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#The NotAcceptable function call sends the first half variable to be indexed to its appropriate position
	#   to where it is no longer conflicting with the specific second half variable. 
	jal	NotAcceptable
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
		

	#Since the first half has already been accounted for and shifted if need, the second half index can all be
	#   adjust appropriately without fear of conflict. 
	addi $s1, $s1, 4
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	
#This function handles the scenario when indexed elements do no conflict with each other or with their relative
#   positions on the array. 
Acceptable:
	#The two following instructions are responsible for iterating to the next index in the first half of 
	#   the array and then pops the end address from the stack. 
	addi $s0, $s0, 4
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
				
	lw $a2, 12($sp)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#These two instructions check both halfs to see if the arrays are null or if they contain values. 
	bge	$s0, $a2, LoopNullEnd
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	bge	$s1, $a2, LoopNullEnd
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	j MergeSortLoop
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#This nested function is responsible for recovering the return address from the stack, adjusting the stack 
	#   pointer to accomodate for the popped ra, and to use that popped address to return the the Acceptable's 
	#   callee. 
	LoopNullEnd:
		lw $ra, 0($sp)
		addi $zero, $zero, 0 # No Op
		addi $zero, $zero, 0 # No Op
		addi $zero, $zero, 0 # No Op
	
		addi $sp, $sp, 16
		addi $zero, $zero, 0 # No Op
		addi $zero, $zero, 0 # No Op
		addi $zero, $zero, 0 # No Op
	
		jr $ra
		addi $zero, $zero, 0 # No Op
		addi $zero, $zero, 0 # No Op
		addi $zero, $zero, 0 # No Op

#This function handles the scenario when indexed elements DO conflict with with other and need to be moved to 
#   not be out of order. 
NotAcceptable:
	li $t0, 10
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#If branch, the program has moved the current element to an index that is acceptable and does not conflict
	#   with its counter element. 
	ble	$a0, $a1, Adjusted
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
		
	#Else, this function is reponsible for looking back at the last known address, retrieving that address's index
	#   along with its index's previous index and then swapping those two indexs and their values. This looking 
	#   back in the array and swapping indexes is what "shifts" the value back to where it is can be deemed in a
	#   acceptable positon. 
	addi $t6, $a0, -4
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	lw $t7, 0($a0) #1 index back in the array
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	lw $t8, 0($t6) #2 index's back in the array
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#As mentioned above these three lines swap the previous index of the current element and the previous previous 
	#   index. This effectively shifts the element back in the array by one index per swap.
	sw $t7, 0($t6)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	sw $t8, 0($a0)
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	add $a0, $t6, $zero
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	
	#This instruction jumps back to repeat the NotAcceptable loop. 
	j NotAcceptable
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op
	addi $zero, $zero, 0 # No Op

	#This is run when the previously conflict element has been sorted out and moved back to its appropriate position
	#   in the array. This return address jumps the program back to MergeSortLoop function. 
	Adjusted:
		jr $ra
		addi $zero, $zero, 0 # No Op
		addi $zero, $zero, 0 # No Op
		addi $zero, $zero, 0 # No Op
	

#This is signaled by the entire MergeSort algorithm completing and thus the program ending. 
Exit:
