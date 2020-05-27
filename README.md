# Assembly Projects in MIPS

### This repository contains some assembly and C code from different projects from my Computer Organization course.
 
#### `Binomial Coefficient`

This program implements a recursive implementation of the binomial coefficient by following the MIPS procedure calling conventions and properly managing the stack. The program terminates when the N input equals zero (see input and output samples for more details). For more information about the binomial coeffiecient, check out: https://mathworld.wolfram.com/BinomialCoefficient.html

#### `Bubble Sort of Strings`

This program implements the bubble sort algorithm to sort strings in ascending order. Notice that this programs uses load and store byte to read and write characters, instead of load and store word, which access four-byte integers. See the input and output sample files for more information; the first integer in the input sample file denotes the number of strings to sort, including the blank lines.

#### `Matrix Multiplication`

In this program matrices are represented as linear or one-dimensional arrays, instead of 2-D arrays, inside the program since it is harder to work with 2-D matrices in assembly. Notice that the first integer in the input sample file represents the dimensionaly of the two matrices (in this case squared-matrices) we are interested in multiplying, and this integer should not be greater than 10. For a review of matrix multiplication, check out: https://www.mathsisfun.com/algebra/matrix-multiplying.html

#### `Nursery Rhyme`

This program takes a sequence of words and turns them into a story (see input and output sample files for more details). This repository contains both a recursive and iterative implementation in C; however, the assembly version is implemented iteratively. Notice that the input ends when the string `END` is encountered, the number of animal-lyrics pairs is determined at runtime and should not to exceed 20 pairs, each animal name will not exceed 15 characters (including null terminator), and each lyrics line will not exceed 60 characters.

#### `Simple Sort of Structures`


