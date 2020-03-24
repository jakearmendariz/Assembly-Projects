.data
 space: .asciiz " "
 array: .space 32

 .text
 main:
 la $s0, array
 li $t0, 0
 li $t2, 65

 loop:
 bgt $t2, 75, printArray
 add $t3, $s0, $t0

 sb $t2, 0($t3)
 add $t0, $t0, 1
 add $t2, $t2, 2
 j loop

 printArray:
 la $a0, array
 li $v0, 4
 syscall

 nop
 li $v0, 10
 syscall