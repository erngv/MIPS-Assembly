#======================================================================================================
# Bubble Sort of Strings
#======================================================================================================
.data
stringArray: .space 12800

.text
main:
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # read the value of N
    add     $t1, $0, $v0            # copy the value of N to $t1
    add     $t0, $0, $0

readingLoop:
    sll     $s0, $t0, 7
    li      $v0, 8                  # system call 8 is for reading a string
    la      $a0, stringArray($s0)
    li      $a1, 100
    syscall

    addi    $t0, $t0, 1
    blt     $t0, $t1, readingLoop

    addi    $t3, $t1, -1            # $t3 = N - 1
    add     $t0, $0, $0

swapingLoop:
    beq     $t0, $t3, print
    addi    $t2, $t0, 1

internalLoop:
    sll     $s0, $t0, 7
    sll     $s2, $t2, 7
    la      $a0, stringArray($s0)
    la      $a1, stringArray($s2)

    addi    $v0, $0, 0
    jal     strcmp
    add     $t6, $v0, $0
    la      $a0, stringArray($s0)
    la      $a1, stringArray($s2)
    bne     $t6, $0, swapFunc

endSwapping:
    addi    $t2, $t2, 1             # update j++
    blt     $t2, $t1, internalLoop  # loop internally again if (j < N)
    addi    $t0, $t0, 1             # else, update i++
    beq     $t2, $t1, swapingLoop   # loop externally if (j == N)

print:
    add     $t0, $0, $0

printingLoop:
    sll     $s0, $t0, 7
    li      $v0, 4                  # system call 4 is for printing a string
    la      $a0, stringArray($s0)
    syscall

    addi    $t0, $t0, 1
    blt     $t0, $t1, printingLoop

end:
    addi    $v0, $0, 10             # system call code 10 for exit
    syscall                         # exit the program

strcmp:                             # string comparison function
    lb      $t4, ($a0)              # load character from first string
    lb      $t5, ($a1)              # load character from second string
    add     $a0, $a0, 1
    add     $a1, $a1, 1
    beq     $t4, $0, nullReached    # if null terminator is reached, we are ready to swap
    beq     $t5, $0, nullReached

    beq     $t4, $t5, strcmp
    blt     $t4, $t5, doNotSwapIndic
    blt     $t5, $t4, swapIndic

nullReached:
    beq     $t4, $t5, doNotSwapIndic
    beq     $t4, $0, doNotSwapIndic
    beq     $t5, $0, swapIndic
    jr      $ra

doNotSwapIndic:                     # string 2 is less than or equal to string 2
    addi    $v0, $0, 0              # indicator 0 ---> do not swap!
    jr      $ra

swapIndic:                          # string 2 is greater than string 1
    addi    $v0, $0, 1              # indicator 1 ---> swap!
    jr      $ra

swapFunc:
    lb 	    $t4, ($a0)              # load character from first string
    lb 	    $t5, ($a1)              # load character from second string
    sb	    $t5, ($a0)              # store character from string 2 to string 1
    sb	    $t4, ($a1)              # store character from string 1 to string 2
    add 	$a0, $a0, 1
    add 	$a1, $a1, 1

    bne 	$t4, $0, swapFunc       # null terminator must be reached for both strings
    bne 	$t5, $0, swapFunc       # otherwise, keep swaping!
    j	    endSwapping
