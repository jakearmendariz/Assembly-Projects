.data
	prompt: .asciiz "Enter your age: "
	message: .asciiz "\nYour age is "

.text
	#ask for age
	li $v0, 4
	la $a0, prompt
	syscall
	
	#get user's age
	li $v0, 5
	syscall
	
	#store result in t0
	move $t0, $v0
	
	#display message
	li $v0, 4
	la $a0, message
	syscall
	
	#Print age
	li $v0, 1
	move $a0, $t0
	syscall 
	
	li $v0, 10
 	syscall
 