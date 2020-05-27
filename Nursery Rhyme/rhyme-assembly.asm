#===================================================================================================
# Nursery Rhyme --- Iterative Version
#===================================================================================================
.data
	oldLady:	.asciiz "There was an old lady who swallowed a "
	semicolon:	.asciiz ";\n"
	swallow1:	.asciiz "She swallowed the "
	swallow2:	.asciiz " to catch the "
	iDoNotKnow:	.asciiz "I don't know why she swallowed a "
	dash:		.asciiz " - "
	END:		.asciiz "END\n"
	space:		.asciiz " "
	newLine:	.asciiz "\n"
	animals:	.space 320
	lyrics:		.space 1280

.text

main:
	add	$t8, $0, $0			# $8 is the value of len
	addi	$t9, $0, 0xa			# End of line representation

whileLoop:
	#----------------------------------------------------------------------------------------------
	# Read animals and strip new line character if different from "END\n"
	#----------------------------------------------------------------------------------------------
	sll	$s1, $t8, 4
	li	$v0, 8				# System call 8 is for reading a string
	la	$a0, animals($s1)
	li	$a1, 15
	syscall

	la	$a2, END			# Load string "END\n" to check for termination
	jal	strcmp				# This is a string comparison function 
	move	$t1, $v0
	li	$t3, -1
	beq	$t1, $t3, endWhileLoop		# We are done reading inputs!
	sll	$s2, $t8, 4			# To remove new line character on animals strings

removeAnimalsNewLine:
    	lb 	$a3, animals($s2)    		# Load character (one byte) at index
    	addi 	$s2, $s2, 1
    	bne 	$a3, $0, removeAnimalsNewLine
    	addi 	$s2, $s2, -2
    	sb 	$0, animals($s2)
	#----------------------------------------------------------------------------------------------
	# Read lyrics and strip new line character
	#----------------------------------------------------------------------------------------------
	sll	$s1, $t8, 6
	li	$v0, 8				# System call 8 is for reading a string
	la	$a0, lyrics($s1)
	li	$a1, 60
	syscall
	sll	$s2, $t8, 6			# To remove new line character on lyrics strings

removeLyricsNewLine:
    	lb 	$a3, lyrics($s2)    		# Load character (one byte) at index
    	addi 	$s2, $s2, 1
    	bne 	$a3, $0, removeLyricsNewLine
    	addi 	$s2, $s2, -2
    	sb 	$0, lyrics($s2)
	#----------------------------------------------------------------------------------------------
	addi	$t8, $t8, 1			# Increment the value of len by 1
	j	whileLoop			# Iterate again...
#======================================================================================================
#======================================================================================================
strcmp:						# Helper function for string comparison
	lb 	$t4, ($a0)			# Load character (one byte) at index
	lb 	$t5, ($a2)			# Load character (one byte) at index
	add 	$a0, $a0, 1
	add 	$a2, $a2, 1
	beq	$t5, $t9, indicator
	bne 	$t4, $t5, return
	beq 	$t4, $t5, strcmp

indicator:
	li 	$v0, -1				# To indicate we are done reading inputs

return:
	jr 	$ra
#======================================================================================================
#======================================================================================================
endWhileLoop:
	add	$t1, $0, $0			# for (current = 0; ...

firstPrintingLoop:
	add	$t2, $0, $0			# Reset space counter
	beq	$t1, $0, thereWasAnOldLady
	jal	spaceLoop
	bgt	$t1, $0, sheSwallowed

thereWasAnOldLady:
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, oldLady			# "There was an old lady who swallowed a "
	syscall

  	sll	$s1, $t1, 4			# Value of current index
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, animals($s1)		# %s ---> animals[current]);
	syscall

	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, semicolon			# semicolon + newline
	syscall
	j	checkEndFirstLoop

sheSwallowed:
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, swallow1			# "She swallowed the "
	syscall

	addi	$t3, $t1, -1			# Value of cuurent index - 1
  	sll	$s1, $t3, 4			#
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, animals($s1)		# %s ---> animals[current - 1]);
	syscall

	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, swallow2			# " to catch the "
	syscall

	sll	$s1, $t1, 4			# Value of cuurent index
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, animals($s1)		# %s ---> animals[current]);
	syscall

	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, semicolon			# semicolon + newline
	syscall

checkEndFirstLoop:
	addi	$t1, $t1, 1			# Increment the value of current by 1
	blt	$t1, $t8, firstPrintingLoop
#======================================================================================================
#======================================================================================================
	addi	$t1, $t8, -1			# Reset value of $t0 to len-1 for second printing loop

secondPrintingLoop:
	add	$t2, $t0, $0			# Reset space counter
	beq	$t1, $0, idkWhy
	jal	spaceLoop

idkWhy:
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, iDoNotKnow			# "I don't know why she swallowed a "
	syscall

  	sll	$s1, $t1, 4
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, animals($s1)		# %s ---> animals[current]);
	syscall
	
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, dash			# " - "
	syscall

  	sll	$s1, $t1, 6
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, lyrics($s1)		# %s ---> lyrics[current]);
	syscall
	
	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, newLine
	syscall

	addi	$t1, $t1, -1			# Decrement the value of current by 1
	bgt	$t1, $0, secondPrintingLoop
	beq	$t1, $0, secondPrintingLoop
	blt	$t1, $0, end
#======================================================================================================
#======================================================================================================
end:
	addi 	$v0, $0, 10			# System call code 10 for exit
  	syscall					# Exit the program

spaceLoop:
  	li 	$v0, 4  			# System call 4 is for printing a string
  	la 	$a0, space			# Print space
	syscall

	addi	$t2, $t2, 1
	blt	$t2, $t1, spaceLoop
	jr	$ra
