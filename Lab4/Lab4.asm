########################################################################
# Created by:  Armendariz, Jake
#              jsarmend
#              22 November 2019
#
# Assignment:  Lab 4: Sorting floats
#              CSE 012, Computer Systems and Assembly Language
#              UC Santa Cruz, FALL 2019
# 
# Description: 	This program recieves 3 program arguments in string/IEE form
#		Thiis code will turn these into hex/floating point form and sort them
#		Using a variation in bubble sort
# 
# Notes:       This program is intended to be run from the MARS IDE.
########################################################################
	
########################################################################
### Pseudo Code:
#  Syscall 4 to print Program arguments
#  Get arg1, its value is in $a0
#  lw its address into $t1 and $s0
#  Increment by a value of 4 each time to obtain the other two arguments
#  repreat saving address and values
#  Before incrementing print each value using syscall 4
#
#  Now move $a0 back by 8, so we can begin turning the args into the registers
#  In three seperate loops of size 8
#  Go through each hex value multiplying by its 16 base and the value given  either a number of a letter
#  To obtain 16 to a power we loop through a specified number of times multplying $t1 by 16
#
#  mtc1 to move the registers into floating point form
#  Loop over the registers 3 times
#  If f1 > f2 or f2 > f3 swap these values and the corresponding $s4/5/6 register
#  This sorts the numbers where f1<f2<f3 and s4<s5<s6
#
#  Now print the s4,s5,s6 using syscall 32
#  Finally print their floating point brothers using syscall 2
########################################################################

.data
	progarg: .asciiz "Program Arguments:\n"
	sortieee: .asciiz "\n\nSorted values (IEEE 754 single precision floating point format):\n"
	sortdec: .asciiz "\n\nSorted values (decimal):\n" 
	newLine: .asciiz "\n"
#puesdo code

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
	

########################################################################
### Adds the first hex into s4
########################################################################
#Save the sign of these three numbers in $a1, $a2, $a3 perspectivly
#Loop through the 3, 10 characters of the string, adding the data to s4, s5, s6
	#addi $s0, $s0, 1	
	li $t2, 0 	#This is my counter
	li $t3, 8	#run 8 times
	li $s4, 0 
	start_loop:
		li $t1, 0
		beq $t2, $t3, end_loop
		lb $t1, 2($s0)#address of string	#First memory address of string, I think
		
		li $v0, 11
		li $a0, 32
		syscall
		
		li $v0, 1
		move $a0, $t1
		syscall
			
		
		
		li $t4, 58	#Brabc 
		bge $t1, $t4, letter
			addi $t1, $t1, -48	#Converts ascii to decimal
			j After
		letter:
			addi $t1, $t1, -55	#Converts ascii to decimal
		After:
			li $v0, 1
			move $a0, $t1
			#syscall
			
			li $v0, 11
			li $a0, 32
			#syscall
			
			#Add to $s4 to 16 power
			li $t7, 7
			sub $t7, $t7, $t2	#To what power of 16 do we multiply
			li $t8, 16
			start_power:
				beqz $t7, end_power	#Once $7 == 0 the loop with end
				mul $t1, $t1, $t8	#Multiples $t1 by 16
				addi $t7, $t7, -1	#Iteration of loop
				b start_power
			end_power:
			add $s4, $s4, $t1		#Adds the character's value from hex into s4
			
		addi $t2, $t2, 1	#increment inner loop
		addi $s0, $s0, 1	#increment the character
		b start_loop
	end_loop:
	li $v0, 34
	move $a0, $s4
	#syscall
	
########################################################################
### Adds the first hex into s5
########################################################################
	
	li $t2, 0 	#This is my counter
	li $t3, 8	#run 8 times
	li $s5, 0 
	start_loop2:
		li $t1, 0
		beq $t2, $t3, end_loop2
		lb $t1, 2($s1)#address of string	#First memory address of string, I think
		
		li $v0, 1
		move $a0, $t1
		#syscall
			
		li $v0, 11
		li $a0, 32
		#syscall
		
		li $t4, 58	#Brabc 
		bge $t1, $t4, letter2
			addi $t1, $t1, -48	#Converts ascii to decimal
			j After2
		letter2:
			addi $t1, $t1, -55	#Converts ascii to decimal
		After2:
			li $v0, 1
			move $a0, $t1
			#syscall
			
			li $v0, 11
			li $a0, 32
			#syscall
			
			#Add to $s4 to 16 power
			li $t7, 7
			sub $t7, $t7, $t2	#To what power of 16 do we multiply
			li $t8, 16
			start_power2:
				beqz $t7, end_power2	#Once $7 == 0 the loop with end
				mul $t1, $t1, $t8	#Multiples $t1 by 16
				addi $t7, $t7, -1	#Iteration of loop
				b start_power2
			end_power2:
			add $s5, $s5, $t1		#Adds the character's value from hex into s4
			
		addi $t2, $t2, 1	#increment inner loop
		addi $s1, $s1, 1	#increment the character
		b start_loop2
	end_loop2:
	
	
########################################################################
### Adds the first hex into s6
########################################################################
	li $t2, 0 	#This is my counter
	li $t3, 8	#run 8 times
	li $s6, 0 
	start_loop3:
		li $t1, 0
		beq $t2, $t3, end_loop3
		lb $t1, 2($s2)#address of string	#First memory address of string, I think
		
		li $v0, 1
		move $a0, $t1
		#syscall
			
		li $v0, 11
		li $a0, 32
		#syscall
		
		li $t4, 58	#Brabc 
		bge $t1, $t4, letter3
			addi $t1, $t1, -48	#Converts ascii to decimal
			j After3
		letter3:
			addi $t1, $t1, -55	#Converts ascii to decimal
		After3:
			li $v0, 1
			move $a0, $t1
			#syscall
			
			li $v0, 11
			li $a0, 32
			#syscall
			
			#Add to $s4 to 16 power
			li $t7, 7
			sub $t7, $t7, $t2	#To what power of 16 do we multiply
			li $t8, 16
			start_power3:
				beqz $t7, end_power3	#Once $7 == 0 the loop with end
				mul $t1, $t1, $t8	#Multiples $t1 by 16
				addi $t7, $t7, -1	#Iteration of loop
				b start_power3
			end_power3:
			add $s6, $s6, $t1		#Adds the character's value from hex into s4
			
		addi $t2, $t2, 1	#increment inner loop
		addi $s2, $s2, 1	#increment the character
		b start_loop3
	end_loop3:
	
	
########################################################################
### Sorts the numbers
# Compares the floating point numbers
# swaps the hex reg and floating reg when f2 < f1 or f2 < f3
########################################################################
	mtc1 $s4, $f1
	mtc1 $s5, $f2
	mtc1 $s6, $f3

	#for i = 0 < i = 3
	li $t2, 0 	#This is my counter
	li $t3, 4	#run 3 times
	start_inner_loop:
		li $t1, 0
		beq $t2, $t3, end_inner_loop
		
		c.lt.s $f1, $f2
		bc1t fswap
			move $t4, $s4
			move $s4, $s5
			move $s5, $t4
			
			mov.s $f4, $f1
			mov.s $f1, $f2
			mov.s $f2, $f4
		fswap:
		
		
		c.lt.s $f2, $f3
		bc1t fswap1
			move $t5, $s5
			move $s5, $s6
			move $s6, $t5
			
			mov.s $f4, $f2
			mov.s $f2, $f3
			mov.s $f3, $f4
		
		fswap1:
		
		addi $t2, $t2, 1	#increment inner loop
		b start_inner_loop
	end_inner_loop:
	
	
	
########################################################################
### Prints the hex versions, then the floating point versions
########################################################################
	
	
	#Sorted values in IEEE precisuon
	li $v0, 4
	la $a0, sortieee
	syscall
	#print each one
	li $v0, 34
	move $a0, $s4
	syscall
	#print space
	li $v0, 11
	li $a0, 32
	syscall
	
	li $v0, 34
	move $a0, $s5
	syscall
	
	#print space
	li $v0, 11
	li $a0, 32
	syscall
	
	li $v0, 34
	move $a0, $s6
	syscall
	
	#printing numbers in floating point form
	li $v0, 4
	la $a0, sortdec
	syscall
	
	#mtc1 $s4, $f1

	li $v0, 2
	mov.s $f12, $f1
	syscall
	
	#print space
	li $v0, 11
	li $a0, 32
	syscall
	
	#mtc1 $s5, $f2
	
	li $v0, 2
	mov.s $f12, $f2
	syscall
	
	#print space
	li $v0, 11
	li $a0, 32
	syscall
	
	#mtc1 $s6, $f3
	
	li $v0, 2
	mov.s $f12, $f3
	syscall
	
	li $v0, 4
	la $a0, newLine
	syscall
	
	
#ends program
li $v0, 10
syscall
