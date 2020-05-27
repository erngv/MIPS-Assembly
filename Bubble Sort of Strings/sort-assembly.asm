#======================================================================================================
# Bubble Sort of Strings
#======================================================================================================
.data
	stringArray:		.space 12800

.text

main:
  	addi	$v0, $0, 5			# System call 5 is for reading an integer
  	syscall 				# Read the value of N
  	add	$t1, $0, $v0			# Copy the value of N to $t1
  	add	$t0, $0, $0			# for (int i = 0; ...
#======================================================================================================
#======================================================================================================
readingLoop:
	sll	$s0, $t0, 7
	li	$v0, 8				# System call 8 is for reading a string
	la	$a0, stringArray($s0)
	li	$a1, 100
	syscall
	
	addi	$t0, $t0, 1
	blt	$t0, $t1, readingLoop
#======================================================================================================
#======================================================================================================
	addi	$t3, $t1, -1			# $t3 = N - 1
	add	$t0, $0, $0			# for (int i = 0; ...
swapingLoop:
	beq	$t0, $t3, print
	addi	$t2, $t0, 1			# for (int j = i + 1; ...

internalLoop:
	sll	$s0, $t0, 7
	sll	$s2, $t2, 7
	la	$a0, stringArray($s0)
	la	$a1, stringArray($s2)

	addi 	$v0, $0, 0
	jal	strcmp
	add	$t6, $v0, $0
	la	$a0, stringArray($s0)
	la	$a1, stringArray($s2)
	bne	$t6, $0, swapFunc

endSwapping:
	addi	$t2, $t2, 1			# Update j++
	blt	$t2, $t1, internalLoop		# Loop internally again if (j < N)
	addi	$t0, $t0, 1			# Else, update i++
	beq	$t2, $t1, swapingLoop		# Loop externally if (j == N)
#======================================================================================================
#======================================================================================================
print:
	add	$t0, $0, $0
printingLoop:
	sll	$s0, $t0, 7
	li	$v0, 4				# System call 4 is for printing a string
	la	$a0, stringArray($s0)
	syscall
	
	addi	$t0, $t0, 1
	blt	$t0, $t1, printingLoop
#======================================================================================================
#======================================================================================================
end:
	addi 	$v0, $0, 10			# System call code 10 for exit
  	syscall					# Exit the program
#======================================================================================================
#======================================================================================================
strcmp:						# Sring comparison function
	lb 	$t4, ($a0)			# Load character from first string
	lb 	$t5, ($a1)			# Load character from second string
	add 	$a0, $a0, 1
	add 	$a1, $a1, 1
	beq 	$t4, $0, nullReached		# If null terminator is reached, we are ready to swap
	beq 	$t5, $0, nullReached

	beq 	$t4, $t5, strcmp
	blt 	$t4, $t5, doNotSwapIndic	# If string 1 is less than string 2
	blt 	$t5, $t4, swapIndic		# If string 1 is greater than string 2

nullReached:
	beq 	$t4, $t5, doNotSwapIndic
	beq 	$t4, $0, doNotSwapIndic
	beq 	$t5, $0, swapIndic
	jr 	$ra

doNotSwapIndic:					# String 2 is less than or equal to string 2
	addi 	$v0, $0, 0			# Indicator 0 ---> do not swap!
	jr 	$ra

swapIndic:					# String 2 is greater than string 1
	addi 	$v0, $0, 1			# Indicator 1 ---> swap!
	jr 	$ra

swapFunc:
	lb 	$t4, ($a0)			# Load character from first string
	lb 	$t5, ($a1)			# Load character from second string
	sb	$t5, ($a0)			# Store character from string 2 to string 1
	sb	$t4, ($a1)			# Store character from string 1 to string 2
	add 	$a0, $a0, 1
	add 	$a1, $a1, 1

	bne 	$t4, $0, swapFunc		# Null terminator must be reached for both strings
	bne 	$t5, $0, swapFunc		# Otherwise, we keep swaping!
	j	endSwapping
