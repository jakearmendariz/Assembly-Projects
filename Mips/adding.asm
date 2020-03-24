.data 
	nextLine: .asciiz "\n"

.text
# File: Program3-1.asm
# Author: Charles Kann
# Purpose: To illustrate some addition operators
# illustrate R format add operator
li $t1, 100
li $t2, 50
add $t0, $t1, $t2
# illustrate add with an immediate. Note that
# an add with a pseudo instruction translated
# into an addi instruction
addi $t0, $t0, 50
add $t0, $t0, 50
subi $t1, $t0, 210
# using an unsign number. Note that the
# result is not what is expected
# for negative numbers.

#Print t0
#move $v0, $t0
li $v0, 1
move $a0, $t0
syscall 

li $v0, 4
la $a0, nextLine
syscall

li $v0, 1
move $a0, $t1
syscall 

li $v0, 10
syscall