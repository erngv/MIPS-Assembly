# ============================================================================================
# Binomial Coefficient
# ============================================================================================
.data
  	newline:	.asciiz "\n"

.text

main:
	ori	$sp, $0, 0x3000     		# Initialize stack pointer
    	addi    $fp, $sp, -4			# Set $fp to the start of main's stack frame
# ============================================================================================
# Write code here to do exactly what main does in the C program.
#
# Please follow these guidelines:
#	- Use syscall 5 each time to read an integer (scanf("%d", ...))
#	- Then call NchooseK to compute the function
#	- Then use syscall 1 to print the result
#   	- Put all of the above inside a loop
# ============================================================================================
  
    	# Read the value of N
	addi	$v0, $0, 5			# System call 5 is for reading an integer
  	syscall 				# Integer value read is in $v0
	add	$a0, $0, $v0			# Copy the value of N into $a0
	beq	$a0, $0, end 			# Check if N is equal to zero
	
	# Read the value of K
	addi	$v0, $0, 5			# System call 5 is for reading an integer
  	syscall 				# Integer value read is in $v0
	add	$a1, $0, $v0			# Copy the value of K into $a1
	
	jal	NchooseK
	
	add 	$a0, $0, $v0 			# Store value of $v0 into $a0
	addi 	$v0, $0, 1  			# System call 1 is for printing an integer
      	syscall

  	# Print new line
  	addi 	$v0, $0, 4  			# System call 4 is for printing a string
  	la 	$a0, newline
  	syscall
	
	j	main

end: 
	ori   $v0, $0, 10			# System call 10 for exit
	syscall

NchooseK:					# PLEASE DO NOT CHANGE THE NAME "NchooseK"
# ============================================================================================
# $a0 has the number N, $a1 has K, from which to compute N choose K
#
# Write code here to implement the function you wrote in C.
# Your implementation MUST be recursive; an iterative implementation is not acceptable.
#
# $v0 should have the NchooseK result to be returned to main.
# ============================================================================================

	# Base cases
	beq	$a1, $0, baseCase		# K == 0 
	beq 	$a0, $a1, baseCase 		# N == k
	
	addi 	$sp, $sp, -8 			# Make room on stack for saving $ra and $fp
    	sw	$ra, 4($sp)         		# Save $ra
    	sw	$fp, 0($sp)         		# Save $fp
    	addi	$fp, $sp, 4         		# Set $fp to the start of proc1's stack frame
	sw 	$a0, -8($fp)			# Save $a0
	sw 	$a1, -12($fp)			# Save $a1
	addi	$sp, $sp, -8			# Shift the stack pointer
	
	addi 	$a0, $a0, -1 			# Update N = N - 1
	addi 	$a1, $a1, -1 			# Update K = K - 1
	jal 	NchooseK 			# Recursive call to NchooseK(N-1, K-1)

	lw 	$a0, -8($fp) 			# Restore previous value of N
	lw 	$a1, -12($fp) 			# Restore previous value of K
	sw 	$v0, -8($fp)			# Store current value of N in $v0
	
	addi 	$sp, $sp, 4			# Shift the stack pointer
	addi 	$a0, $a0, -1			# Update N = N - 1
	jal 	NchooseK 			# Recursive call to NchooseK(N-1, K)
	
	lw 	$t0, -8($fp)			# Restore $v0
	add 	$v0, $v0, $t0			# NchooseK(N-1, K-1) + NchooseK(N-1, K)
	addi    $sp, $fp, 4			# Restore $sp
    	lw      $ra, 0($fp)     		# Restore $ra
    	lw      $fp, -4($fp)    		# Restore $fp
    	jr      $ra             		# Return from procedure

baseCase:
	addi 	$v0, $0, 1
	jr 	$ra
