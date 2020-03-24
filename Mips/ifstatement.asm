.text
	li $v0, 4
	la $a0, treePrompt
	syscall
	
	#get number of trees
	li $v0, 5
	syscall
	
	#store result in t0
	move $t0, $v0
	
	li $v0, 4
	la $a0, sizePrompt
	syscall
	
	#get the length of trees
	li $v0, 5
	syscall
	
	#store result in t1
	move $t1, $v0
	
	sra $s0, $t1, 1    #divides t1 in two and puts it in s0
	add $s0, $s0, $t1  #s0 = s0 + t0 : This will store the number of iterations or the total height of tree
	
	li $s1, 0 #s1 is the counter for outer loop
	li $t2, 0 #check uf equal
	li $s3, 0 #s3 is the counter for inner loop
	
	addi $t0,$t0, -1
	
	
	#if block
		 lw $s0, num
		 slti $t1, $s0, 0
		 sgt $t2, $s0, 100
		 or $t1, $t1, $t2
		 beqz $t1, grade_A
	 #invalid input block
	b end_if
	grade_A:
	sge $t1, $s0, 90
	beqz $t1, grade_B
	b end_if
 	grade_B:
 	sge $t1, $s0, 80
 	beqz $t1, grade_C
 	b end_if
 	grade_C:
 	sge $t1, $s0, 70
 	beqz $t1, grade_D
	b end_if
	grade_D:
 	sge $t1, $s0, 60
 	beqz $t1, else
 	b end_if
 	else:
 	b end_if
 	end_if: 
		
	#Prints the height of each tree (including branches)
	li $v0, 1
	move $a0, $s0
	#syscall 
	
	
	
	# At this point, t0 is the number of trees and t1 is the size of these trees
	
	
	
	li $v0, 10
 	syscall

.data
	treePrompt: .asciiz "Enter the number of trees to print (must be greater than 0): "
	invalid: .asciiz "Invalid entry!\n"
	sizePrompt: .asciiz "Enter the size of one tree (must be greater than 1): "
	programEnd: .asciiz "\n-- program is finished running --\n"
	stump: .asciiz " || "
	base: .asciiz  "----"
	tip: .asciiz  " /\  "
	branch: .asciiz  "/  \ "
	nextLine: .asciiz "\n"
	num: .word 70 
	
