.data
	progarg: .asciiz "Program Arguments\n"
	
	
.text
	#Intake the three strings.
#First string is at address $a1
	
	li $v0, 4
	la $a0, progarg
	syscall
	
	lw $t1 ($a1)
	move $a0, $t1
	move $s0, $t1
	li $v0, 4
	syscall
	
	li $v0, 11
	li $a0, 32
	syscall

#second string is at address $a1+4bytes
	addi $a1, $a1, 4
	lw $t1 ($a1)
	move $a0, $t1
	move $s1, $t1
	li $v0, 4
	syscall
	
	li $v0, 11
	li $a0, 32
	syscall
	

#third string is at $a1+8bytes
	addi $a1, $a1, 4
	lw $t1 ($a1)
	move $a0, $t1
	move $s2, $t1
	li $v0, 4
	syscall
	
	addi $a1, $a1, -8
	
	#ends program
	li $v0, 10
	syscall
