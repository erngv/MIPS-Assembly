# ============================================================================================
# Binomial Coefficient
# ============================================================================================
.data
newline: .asciiz "\n"

.text
main:
    ori     $sp, $0, 0x3000         # initialize stack pointer
    addi    $fp, $sp, -4            # set $fp to the start of main's stack frame

                                    # read the value of N
    addi    $v0, $0, 5			    # system call 5 is for reading an integer
    syscall 				        # integer value read is in $v0
    add     $a0, $0, $v0            # copy the value of N into $a0
    beq     $a0, $0, end            # check if N is equal to zero

                                    # read the value of K
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add	    $a1, $0, $v0            # copy the value of K into $a1

    jal	NchooseK

    add 	$a0, $0, $v0            # store value of $v0 into $a0
    addi 	$v0, $0, 1              # system call 1 is for printing an integer
    syscall
                                    # print new line
    addi    $v0, $0, 4              # system call 4 is for printing a string
    la      $a0, newline
    syscall

    j       main

end: 
    ori     $v0, $0, 10             # system call 10 is for exit
    syscall

NchooseK:
    beq     $a1, $0,  baseCase
    beq     $a0, $a1, baseCase

    addi    $sp, $sp, -8 			# make room on stack for saving $ra and $fp
    sw	    $ra, 4($sp)         	# save $ra
    sw	    $fp, 0($sp)         	# save $fp
    addi	$fp, $sp, 4         	# set $fp to the start of proc1's stack frame
    sw 	    $a0, -8($fp)			# save $a0
    sw 	    $a1, -12($fp)			# save $a1
    addi	$sp, $sp, -8			# shift the stack pointer

    addi 	$a0, $a0, -1 			# update N = N - 1
    addi 	$a1, $a1, -1 			# update K = K - 1
    jal 	NchooseK 			    # recursive call to NchooseK(N-1, K-1)

    lw 	    $a0, -8($fp) 			# restore previous value of N
    lw 	    $a1, -12($fp) 			# restore previous value of K
    sw 	    $v0, -8($fp)			# store current value of N in $v0

    addi 	$sp, $sp, 4			    # shift the stack pointer
    addi 	$a0, $a0, -1			# update N = N - 1
    jal 	NchooseK 			    # recursive call to NchooseK(N-1, K)

    lw      $t0, -8($fp)			# restore $v0
    add     $v0, $v0, $t0			# NchooseK(N-1, K-1) + NchooseK(N-1, K)
    addi    $sp, $fp, 4			    # restore $sp
    lw      $ra, 0($fp)     		# restore $ra
    lw      $fp, -4($fp)    		# restore $fp
    jr      $ra             		# return from procedure

baseCase:
    addi    $v0, $0, 1
	jr      $ra
