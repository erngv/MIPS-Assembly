#===============================================================================================
# Matrix Multiplication
#===============================================================================================

.data
AA: .space 400                      # int AA[100]
BB: .space 400                      # int BB[100]
CC: .space 400                      # int CC[100]
m:  .space 4

newline: .asciiz "\n"
space:   .asciiz " "

.text

main:
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add     $t0, $0, $v0            # copy the value of m into $t0
    li      $t1, 0                  # $t1 = initial value of i
    mul     $t2, $t0, $t0           # $t2 = mxm
    add     $t9, $0, $0

forloop1:
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add     $t3, $0, $v0

    sll     $a1, $t1, 2
    sw      $t3, AA($a1)            # copy the value of $t3 into AA[i]

    addi    $t1, $t1, 1             # increment the value of i
    slt     $t4, $t1, $t2
    bne     $t4, $0, forloop1

    add     $t1, $0, $0             # reset the value of $t1 to 0

forloop2:
    beq     $t1, $t0, triplenested  # if i = m, then go to last nested loops
    add     $t5, $0, $0             # $t5 = j

forloop3:
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add     $t3, $0, $v0

    add     $a2, $t1, $t5           # i+j
    sll     $a3, $a2, 2
    sw      $t3, BB($a3)            # copy the value of $t3 into BB[i]

    add     $t5, $t5, $t0           # increment the value of j by m
    slt     $t6, $t5, $t2
    bne     $t6, $0, forloop3
    addi    $t1, $t1, 1             # increment the value of i by 1
    j       forloop2

triplenested:
    add     $t1, $0, $0             # reset some temporary variables to 0
    add     $t3, $0, $0

forloop4:
    beq     $t1, $t2, exit          # if i = mxm, exit program
    add     $t4, $0, $0             # $t4 = j

forloop5:
    add     $t5, $0, $0             # $t5 = tmp

forloop6:
    add     $a2, $t1, $t5           # i+tmp
    sll     $s2, $a2, 2
    lw      $t6, AA($s2)            # load A[i+tmp]

    add     $a3, $t5, $t4           # tmp+j
    sll     $s3, $a3, 2
    lw      $t7, BB($s3)            # load B[tmp+j]

    mul     $t8, $t6, $t7           # multiplication step
    add     $t9, $t9, $t8

    addi    $t5, $t5, 1             # increment the value of tmp by 1
    slt     $t6, $t5, $t0
    bne     $t6, $0, forloop6

    addi    $v0, $0, 1              # system call 1 is for printing an integer
    add     $a0, $0, $t9
    syscall

    add     $t9, $0, $0             # reset value of $t9 to 0

    addi    $v0, $0, 4              # system call 4 is for printing a string
    la      $a0, space
    syscall

    add     $t4, $t4, $t0           # increment the value of j by m
    slt     $t6, $t4, $t2
    bne     $t6, $0, forloop5

    addi    $v0, $0, 4              # system call 4 is for printing a string
    la      $a0, newline
    syscall

    add     $t1, $t1, $t0           # increment the value of i by m
    j       forloop4

exit:                               # terminate the program
    addi    $v0, $0, 10             # system call code 10 for exit
    syscall                         # exit the program
