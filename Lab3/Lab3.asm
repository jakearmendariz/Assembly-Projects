########################################################################
# Created by:  Armendariz, Jake
#              jsarmend
#              8 November 2019
#
# Assignment:  Lab 3: ASCII Forest
#              CSE 012, Computer Systems and Assembly Language
#              UC Santa Cruz, FALL 2019
# 
# Description: This program prints trees in ASCII based of user input for number and size
# 
# Notes:       This program is intended to be run from the MARS IDE.
########################################################################
.text
	########################################################################
	### Asks for number of trees
	########################################################################
	li $v0, 4
	la $a0, treePrompt
	syscall
	
	#get number of trees
	li $v0, 5
	syscall
	
	
	#store result in t0
	move $t0, $v0
	li $t7, 1
	########################################################################
	### If the number is less than 0, keep asking
	########################################################################
	start_loop_trees:
		slt $t2, $t0, $t7
		beqz $t2, end_loop_trees
		
		li $v0, 4
		la $a0, invalid
		syscall
		
		li $v0, 4
		la $a0, treePrompt
		syscall
	
		#get number of trees
		li $v0, 5
		syscall
		
		move $t0, $v0
		
		b start_loop_trees
	end_loop_trees:
	
	########################################################################
	### Asks for size of trees
	########################################################################
	li $v0, 4
	la $a0, sizePrompt
	syscall
	
	#get the length of trees
	li $v0, 5
	syscall
	
	#store result in t1
	move $t1, $v0
	
	########################################################################
	### Continue to iterate until size is > 1
	########################################################################
	li $t7, 2
	start_loop_size:
		slt $t2, $t1, $t7
		beqz $t2, end_loop_size
		
		li $v0, 4
		la $a0, invalid
		syscall
		
		li $v0, 4
		la $a0, sizePrompt
		syscall
	
		#get size of trees
		li $v0, 5
		syscall
		
		move $t1, $v0
		
		b start_loop_size
	end_loop_size:
	
	
	sra $s0, $t1, 1    #divides t1 in two and puts it in s0-> Used for printing brabnches
	
	li $s1, 0 #s1 is the counter for outer loop
	li $t2, 0 #check if equal
	li $s3, 0 #s3 is the counter for inner loop
	
	
	########################################################################
	### First loop, adds the /\
	########################################################################
	start_loop_one: #Ends once s1 === t0
 		slt $t2, $s1, $t0
		beqz $t2, end_loop_one
		
		#li $v0, 4
		#la $a0, tip
		#syscall
		li $v0, 11
		li $a0, 32
		syscall
		li $a0, 47
		syscall
		li $a0, 92
		syscall
		li $a0, 32
		syscall
		li $a0, 32
		syscall
		li $a0, 32
		syscall
		
		addi $s1, $s1, 1 #counter
		b start_loop_one
	end_loop_one:
	
	li $s1, 0 #s1 is the counter for outer loop
	#NextLine
	li $v0, 4
	la $a0, nextLine
	syscall
	
	addi $t1, $t1, -1
	########################################################################
	### Second loop, adds the /  \
	########################################################################
	start_loop: #This loop will stop when s1 == 10
 		slt $t2, $s1, $t1
		beqz $t2, end_loop
		start_inner_loop:
			slt $t3, $s3, $t0
			beqz $t3, end_inner_loop
			
			 #print ||
			#li $v0, 4
			#la $a0, branch
			#syscall
			li $v0, 11
			li $a0, 47
			syscall
			li $a0, 32
			syscall
			li $a0, 32
			syscall
			li $a0, 92
			syscall
			li $a0, 32
			syscall
			li $a0, 32
			syscall

			
			addi $s3, $s3, 1
			b start_inner_loop
		end_inner_loop:
		li $s3, 0 #s3 is the counter for inner loop
		# print skipLine
		
		li $v0, 4
		la $a0, nextLine
		syscall
		
		
		addi $s1, $s1, 1 #counter
		b start_loop
	end_loop:
		
		
	
	########################################################################
	### Thrid loop, adds the ---
	########################################################################
	li $s1, 0 #s1 is the counter for outer loop
	start_loop_three: #
 		slt $t2, $s1, $t0
		beqz $t2, end_loop_three
		
		#li $v0, 4
		#la $a0, base
		#syscall
		li $v0, 11
		li $a0, 45
		syscall
		li $a0, 45
		syscall
		li $a0, 45
		syscall
		li $a0, 45
		syscall
		li $a0, 32
		syscall
		li $a0, 32
		syscall
		
		addi $s1, $s1, 1 #counter
		b start_loop_three
	end_loop_three:
	
	li $s1, 0 #s1 is the counter for outer loop
	#NextLine
	li $v0, 4
	la $a0, nextLine
	syscall	
		
		
		
	########################################################################
	### Fourth loop, adds the ||
	########################################################################
	li $s1, 0 #s1 is the counter for outer loop
	li $t2, 0 #check if equal
	li $s3, 0 #s3 is the counter for inner loop
	start_loop_four: #This loop will stop when s1 == s0
 		slt $t2, $s1, $s0
		beqz $t2, end_loop_four
		start_inner_loop_four:
			slt $t3, $s3, $t0
			beqz $t3, end_inner_loop_four
			
			 #print ||
			#li $v0, 4
			#la $a0, stump
			#syscall
			li $v0, 11
			li $a0, 32
			syscall
			li $a0, 124
			syscall
			li $a0, 124
			syscall
			li $a0, 32
			syscall
			li $a0, 32
			syscall
			li $a0, 32
			syscall

			
			addi $s3, $s3, 1
			b start_inner_loop_four
		end_inner_loop_four:
		li $s3, 0 #s3 is the counter for inner loop
		# print skipLine
		
		li $v0, 4
		la $a0, nextLine
		syscall
		
		
		addi $s1, $s1, 1 #counter
		b start_loop_four
	end_loop_four:
		
	
	########################################################################
	### End of Program
	########################################################################
	li $v0, 10
 	syscall

.data
	treePrompt: .asciiz "Enter the number of trees to print (must be greater than 0): "
	invalid: .asciiz "Invalid entry!\n"
	sizePrompt: .asciiz "Enter the size of one tree (must be greater than 1): "
	stump: .asciiz " ||   "
	base: .asciiz  "----  "
	tip: .asciiz  " /\\   "
	branch: .asciiz  "/  \\  "
	nextLine: .asciiz "\n"
	
