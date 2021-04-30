#==========================================================================================
# Simple Sort of Structures
#==========================================================================================
.data
newline: .asciiz "\n"
space:   .asciiz " "
year:	 .space 200
month:	 .space 200
day:     .space 200
ID:      .space 200

.text
main:
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add     $t0, $0, $v0            # copy the value of recNum into $t0
    li      $t1, 0                  # $t1 = initial value of i

forloop1:
    #############
    # Scan year #
    #############
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add     $t2, $0, $v0
    sll     $a1, $t1, 2
    sw      $t2, year($a1)          # store value into data[i].year

    ##############
    # Scan month #
    ##############
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add     $t2, $0, $v0
    sll     $a1, $t1, 2
    sw      $t2, month($a1)         # store value into data[i].month

    ############
    # Scan day #
    ############
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add     $t2, $0, $v0
    sll     $a1, $t1, 2
    sw      $t2, day($a1)           # store value into data[i].day

    ###########
    # Scan ID #
    ###########
    addi    $v0, $0, 5              # system call 5 is for reading an integer
    syscall                         # integer value read is in $v0
    add     $t2, $0, $v0
    sll     $a1, $t1, 2
    sw      $t2, ID($a1)            # store value into data[i].ID  	

    addi    $t1, $t1, 1             # increment the value of i
    slt     $t2, $t1, $t0
    bne     $t2, $0, forloop1       # loop again if i < recNum
    add     $t1, $0, $0             # reset the value of $t1 to -1 otherwise
    addi    $t1, $t1, -1
    addi    $t3, $t0, -1            # (recNum - 1) ---> for second for-loop

forloop2:
    addi    $t1, $t1, 1             # i = 0
    beq     $t1, $t3, printloop     # Jump to last for-loop for printing
    addi    $t2, $t1, 1             # $t2 ---> j = i + 1

forloop3:
    sll     $a1, $t1, 2
    lw      $t4, year($a1)          # get value of data[i].year
    sll     $a2, $t2, 2
    lw      $t5, year($a2)          # get value of data[j].year
    slt     $t6, $t5, $t4
    bne     $t6, $0, swap
    beq     $t5, $t4, f_elif

    addi    $t2, $t2, 1             # j++
    beq     $t2, $t0, forloop2      # outer loop
    j       forloop3                # inner loop

f_elif:
    sll     $a1, $t1, 2
    lw      $t4, month($a1)         # get value of data[i].month
    sll     $a2, $t2, 2
    lw      $t5, month($a2)         # get value of data[j].month
    slt     $t6, $t5, $t4
    bne     $t6, $0, swap
    beq     $t5, $t4, s_elif

    addi    $t2, $t2, 1             # j++
    beq     $t2, $t0, forloop2      # outer loop
    j       forloop3                # inner loop

s_elif:
    sll     $a1, $t1, 2
    lw      $t4, day($a1)           # get value of data[i].day
    sll     $a2, $t2, 2
    lw      $t5, day($a2)           # get value of data[j].day
    slt     $t6, $t5, $t4
    bne     $t6, $0, swap
    beq     $t5, $t4, t_elif

    addi    $t2, $t2, 1             # j++
    beq     $t2, $t0, forloop2      # outer loop
    j       forloop3                # inner loop	

t_elif:
    sll     $a1, $t1, 2
    lw      $t4, ID($a1)            # get value of data[i].ID
    sll     $a2, $t2, 2
    lw      $t5, ID($a2)            # get value of data[j].ID
    slt     $t6, $t5, $t4
    bne     $t6, $0, swap

swap:
    sll     $a1, $t1, 2
    sll     $a2, $t2, 2

    lw      $t4, year($a1)          # value of data[i].year
    lw      $t5, year($a2)          # value of data[j].year
    sw      $t5, year($a1)          # swap them
    sw      $t4, year($a2)

    lw      $t4, month($a1)         # value of data[i].month
    lw      $t5, month($a2)         # get value of data[j].month
    sw      $t5, month($a1)         # swap them
    sw      $t4, month($a2)

    lw      $t4, day($a1)           # value of data[i].day
    lw      $t5, day($a2)           # get value of data[j].day
    sw      $t5, day($a1)           # swap them
    sw      $t4, day($a2)

    lw      $t4, ID($a1)            # value of data[i].ID
    lw      $t5, ID($a2)            # get value of data[j].ID
    sw      $t5, ID($a1)            # swap them
    sw      $t4, ID($a2)

    addi    $t2, $t2, 1             # j++
    beq     $t2, $t0, forloop2      # outer loop
    j       forloop3                # inner loop	

printloop:
    ##############
    # Print year #
    ##############
    sll     $a2, $t8, 2
    lw      $t2, year($a2)          # data[i].year
    addi    $v0, $0, 1              # system call 1 is for printing an integer
    add     $a0, $0, $t2
    syscall

    addi    $v0, $0, 4              # system call 4 is for printing a string
    la      $a0, space
    syscall

    ###############
    # Print month #
    ###############
    sll     $a2, $t8, 2
    lw      $t2, month($a2)         # data[i].month
    addi    $v0, $0, 1              # system call 1 is for printing an integer
    add     $a0, $0, $t2
    syscall

    addi    $v0, $0, 4              # system call 4 is for printing a string
    la      $a0, space
    syscall

    #############
    # Print day #
    #############
    sll     $a2, $t8, 2
    lw      $t2, day($a2)           # data[i].day
    addi    $v0, $0, 1              # system call 1 is for printing an integer
    add     $a0, $0, $t2
    syscall

    addi    $v0, $0, 4              # system call 4 is for printing a string
    la      $a0, space
    syscall

    ############
    # Print ID #
    ############
    sll     $a2, $t8, 2
    lw      $t2, ID($a2)            # data[i].ID
    addi    $v0, $0, 1              # system call 1 is for printing an integer
    add     $a0, $0, $t2
    syscall

    addi    $v0, $0, 4              # system call 4 is for printing a string
    la      $a0, newline
    syscall

    addi    $t8, $t8, 1             # increment the value of i by 1
    slt     $t9, $t8, $t0
    bne     $t9, $0, printloop

end:
    addi    $v0, $0, 10             # system call code 10 for exit
    syscall                         # exit the program
