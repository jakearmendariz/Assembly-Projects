#------------------------------------------------------------------------
# Created by:  Armendariz, Jake
#              jsarmend
#              11 December 2019 
#
# Assignment:  Lab 5: Subroutines
#              CSE 12, Computer Systems and Assembly Language
#              UC Santa Cruz, Fall 2019
# 
# Description: Library of subroutines used to convert an array of
#              numerical ASCII strings to ints, sort them, and print
#              them.
# 
# Notes:       This file is intended to be run from the Lab 5 test file.
#------------------------------------------------------------------------

.data
	inputstr: .asciiz "Input string array:\n"
	dec: .asciiz "\nDecimal value :"
	newLine: .asciiz "\n"
	subtracting: .asciiz "\nSubtracting: "
	aspace: .asciiz " "
	sortArr: .asciiz "Sort Array :\n"
	
	Begin: .asciiz "Runnning lab5.asm\n"
	
	.align 4
	intarray: .space 12

.text

#jal main_function_lab5_19q4_fa_ce12
  
j  exit_program                # prevents this file from running
                               # independently (do not remove)

#------------------------------------------------------------------------
# MACROS
#------------------------------------------------------------------------

#------------------------------------------------------------------------
# print new line macro

.macro lab5_print_new_line
    addiu $v0 $zero   11
    addiu $a0 $zero   0xA
    syscall
.end_macro

#------------------------------------------------------------------------
# print string

.macro lab5_print_string(%str)

    .data
    string: .asciiz %str

    .text
    li  $v0 4
    la  $a0 string
    syscall
    
.end_macro

#------------------------------------------------------------------------
# add additional macros here


#------------------------------------------------------------------------
# main_function_lab5_19q4_fa_ce12:
#
# Calls print_str_array, str_to_int_array, sort_array,
# print_decimal_array.
#
# You may assume that the array of string pointers is terminated by a
# 32-bit zero value. You may also assume that the integer array is large
# enough to hold each converted integer value and is terminated by a
# 32-bit zero value
# 
# arguments:  $a0 - pointer to integer array
#
#             $a1 - double pointer to string array (pointer to array of
#                   addresses that point to the first characters of each
#                   string in array)
#
# returns:    $v0 - minimum element in array (32-bit int)
#             $v1 - maximum element in array (32-bit int)
#-----------------------------------------------------------------------
# REGISTER USE
# $s0 - pointer to int array
# $s1 - double pointer to string array
# $s2 - length of array
#-----------------------------------------------------------------------

.text
main_function_lab5_19q4_fa_ce12: nop
    
    subi  $sp    $sp   16       # decrement stack pointer
    sw    $ra 12($sp)           # push return address to stack
    sw    $s0  8($sp)           # push save registers to stack
    sw    $s1  4($sp)
    sw    $s2   ($sp)
    
    move  $s0    $a0            # save ptr to int array
    move  $s1    $a1            # save ptr to string array
    
    move  $a0    $s1            # load subroutine arguments
    jal   get_array_length      # determine length of array
    move  $s2    $v0            # save array length
    
                                # print input header
   # la $a0, Begin
    #li $v0, 4
    #syscall
                                 
                                                        
    lab5_print_string("\n----------------------------------------")
    lab5_print_string("\nInput string array\n")
                       
    ########################### # add code (delete this comment)
                                # load subroutine arguments
    jal   print_str_array       # print array of ASCII strings
    
    
    move $a2, $s0
    move $a1, $s1
    
    ########################### # add code (delete this comment)
                                # load subroutine arguments
    jal   str_to_int_array      # convert string array to int array
                                
    move $a1, $s0
    ########################### # add code (delete this comment)
                                # load subroutine arguments
    jal   sort_array            # sort int array
                                # save min and max values from array

                                # print output header    
    lab5_print_new_line
    lab5_print_string("\n----------------------------------------")
    lab5_print_string("\nSorted integer array\n")
    
    move $a1, $s0
    ########################### # add code (delete this comment)
                                # load subroutine arguments
    jal   print_decimal_array   # print integer array as decimal
                                # save output values
    
    lab5_print_new_line
    
    ########################### # add code (delete this comment)
                                # move min and max values from array
                                # to output registers
                                
            
    lw    $ra 12($sp)           # pop return address from stack
    lw    $s0  8($sp)           # pop save registers from stack
    lw    $s1  4($sp)
    lw    $s2   ($sp)
    addi  $sp    $sp   16       # increment stack pointer
    
    jr    $ra                   # return from subroutine

#-----------------------------------------------------------------------
# print_str_array	
#
# Prints array of ASCII inputs to screen.
#
# arguments:  $a0 - array length (optional)
# 
#             $a1 - double pointer to string array (pointer to array of
#                   addresses that point to the first characters of each
#                   string in array)
#
# returns:    n/a
#-----------------------------------------------------------------------
# REGISTER USE
# 
#-----------------------------------------------------------------------

.text
print_str_array: nop

    #push $a1 onto the stack
    addi $sp, $sp, -8
    sw   $a0, 0($sp)
    sw   $a1, 4($sp)
    
    
    li   $v0, 4
    la   $a0, inputstr
    #syscall
    
    li   $t0, 0
    move $t1, $a0
    li   $t1, 3
    #These will regulate forloop, loop while $t0 < $t1
    start_str_loop:
    	beq  $t0, $t1, end_str_loop
    	
    	lw   $t3, 0($a1)
    	move $a0, $t3
    	li   $v0, 4
    	syscall
    	
    	li   $v0, 11
	li   $a0, 32
	syscall
    	
    	addi $a1, $a1, 4 #This will increment the loop counter
    	
    	addi $t0, $t0, 1     #Increment loop counter
    	b    start_str_loop
    end_str_loop:

    lw   $a0, 0($sp)
    lw   $a1, 4($sp)
    addi $sp, $sp, 8
    
    jr   $ra
    
    
    
#-----------------------------------------------------------------------
# str_to_int	
#
# Converts ASCII string to integer. Strings will be in the following
# format: '0xABCDEF00'
# 
# i.e zero, lowercase x, followed by 8 hexadecimal digits, capitalizing
# A - F.
# 
# argument:   $a0 - pointer to first character of ASCII string
#
# returns:    $v0 - integer conversion of input string
#-----------------------------------------------------------------------
# REGISTER USE
# 
#-----------------------------------------------------------------------

.text
str_to_int: nop
	li $v0, 4
	#syscall 
	addi $sp, $sp, -12#a0, s0, s4
    	sw   $a0, 0($sp)
    	sw   $s0, 4($sp)
    	sw   $s4, 8($sp)
	
    	la   $s0, 2($a0)
    	
    	
	########################################################################
	### Adds the first hex into s4
	########################################################################
	#Save the sign of these three numbers in $a1, $a2, $a3 perspectivly
	#Loop through the 3, 10 characters of the string, adding the data to s4, s5, s6
	#addi $s0, $s0, 1	
	li   $t2, 0 	#This is my counter
	li   $t3, 8	#run 8 times
	li   $s4, 0 
	start_loopp:
		#li $t1, 0
		beq  $t2, $t3, end_loopp
		lb   $t1, ($s0)#address of string	#First memory address of string, I think
		
		
			
		li   $v0, 11
		li   $a0, 32
		#syscall
		
		li   $t4, 58	#Brabc 
		bge  $t1, $t4, letterr
			addi $t1, $t1, -48	#Converts ascii to decimal
			j    Afterr
		letterr:
			addi $t1, $t1, -55	#Converts ascii to decimal
		Afterr:
			
			
			li   $v0, 11
			li   $a0, 32
			#syscall
			
			#Add to $s4 to 16 power
			li   $t7, 7
			sub  $t7, $t7, $t2	#To what power of 16 do we multiply
			li   $t8, 16
			start_powerr:
				beqz $t7, end_powerr	#Once $7 == 0 the loop with end
				mul  $t1, $t1, $t8	#Multiples $t1 by 16
				addi $t7, $t7, -1	#Iteration of loop
				b start_powerr
			end_powerr:
			add  $s4, $s4, $t1		#Adds the character's value from hex into s4
			
		addi $t2, $t2, 1	#increment inner loop
		addi $s0, $s0, 1	#increment the character
		b start_loopp
	end_loopp:
	
	
	
	move $v0, $s4
	lw   $a0, 0($sp)
	lw   $s0, 4($sp)
    	lw   $s4, 8($sp)
	
    	addi $sp, $sp, 12
    	jr   $ra
    
    
#-----------------------------------------------------------------------
# print_decimal
#
# Prints integer in decimal representation.
#
# arguments:  $a0 - integer to print
#
# returns:    n/a
#-----------------------------------------------------------------------
# REGISTER USE
# 
#-----------------------------------------------------------------------

.text
print_decimal: nop
	addi $sp, $sp, -20#a0, s0, s1, s2, s4
    	sw   $a0, 0($sp)
    	sw   $s0, 4($sp)
    	sw   $s1, 8($sp)
    	sw   $s2, 12($sp)
    	sw   $s4, 16($sp)

	clz  $t1, $a0
	move $s0, $a0
	
	
    	
	bne  $t1, $zero, positive
		#take it out of two's complement form
		not  $s0, $s0
		addi $s0, $s0, 1
		
		#Print a negative sign
		li   $v0, 11
		li   $a0, 45
		syscall
	positive:
	
	move $a0, $s0
	li   $v0, 1
	#syscall
	#Two copies of the integer
	move $s1, $s0
	move $s2, $s0
	
	li   $t0, 0
	li   $t1, 9   #loops 
	li   $s4, 0
	
	
	#Loops through 10 times
	#Prints each nuber by subtracting number - 10^power* *lead 
	#Prints lead
	start_print:
	beq $t0, $t1, end_print
			li $v0, 4
    			la $a0, newLine
    			#syscall
    			
		li   $t7, 7
		sub  $t7, $t7, $t0	#To what power of 10 do we multiply
		li   $t8, 10
		addi $t3, $zero, 1
		start_power:
			bgt  $zero, $t7, end_power	#Once $7 < 0 the loop with end
			mul  $t3, $t3, $t8	#Multiples $t1 by 10
			addi $t7, $t7, -1	#Iteration of loop
			b    start_power
		end_power:
		
		move $a0, $t3
		li   $v0, 1
		#syscall
		
		blt $s1, $t3, tooSmall #if its just a 0 in front right now
			
			div  $t4, $s1, $t3
			addi $t4, $t4,  48
			#Printing a character containing the values
    			
			move $a0, $t4 
			li   $v0, 11
			syscall
			li   $s4, 1
			
			#subtract the largest number. If $s1 = 86890 it should subtract 80000 bc we printed 8 already
			addi $t4, $t4, -48
			mul  $t5, $t4, $t3 
			sub  $s1, $s1, $t5
			
			li   $v0, 4
    			la   $a0, subtracting
    			#syscall
			
			
			
			j printed #does not print 0
		tooSmall:
			beqz $s4, printed
			li   $a0, 48
			li   $v0, 11
			syscall
		printed:
		
		addi $t0, $t0, 1
		
		b start_print
	end_print:
	
	
    	lw   $a0, 0($sp)
    	lw   $s0, 4($sp)
    	lw   $s1, 8($sp)
    	lw   $s2, 12($sp)
    	lw   $s4, 16($sp)
	addi $sp, $sp, 20#a0, s0, s1, s2, s4
    	jr   $ra 
    	
    
#-----------------------------------------------------------------------
# str_to_int_array
#
# Converts array of ASCII strings to array of integers in same order as
# input array. Strings will be in the following format: '0xABCDEF00'
# 
# i.e zero, lowercase x, followed by 8 hexadecimal digits, with A - F
# capitalized
# 
# arguments:  $a0 - array length (optional)
#
#             $a1 - double pointer to string array (pointer to array of
#                   addresses that point to the first characters of each
#                   string in array)
#
#             $a2 - pointer to integer array
#
# returns:    n/a
# Converts every string indivudally using str_to_int function
# Stores inside of $a2
#-----------------------------------------------------------------------
# REGISTER USE
# 
#-----------------------------------------------------------------------

.text
str_to_int_array: nop
	
	addi $sp, $sp, -32
    	sw   $a0, 0($sp)
    	sw   $a1, 4($sp)
    	sw   $ra, 8($sp)
    	sw   $s4, 12($sp)
    	sw   $s0, 16($sp)
    	sw   $s1, 20($sp)
    	sw   $s2, 24($sp)
    	sw   $a2, 28($sp)
    	 
    	
    	li   $t0, 0            #Loop counter
    	li   $t1, 3            #Loop iteratioms
    	
    	#-------------------------
    	#Prints new line, then converts first stirng to int
    	
    	lw $t2, ($a1)
    	move $a0, $t2
    	move $s4, $a0          #s4 contains the contents of string1
    	
    	jal str_to_int        #Call this with $a0 = pointer of first character in the string
    	move $s0, $v0
    	
    	move $a0, $s0
    	li $v0, 1
    	#syscall
    	#-------------------------
    	#Saves to s1
    	#addi $s4, $s4, 2     #s4 contains contents of string 2
    	addi $a1, $a1, 4
    	
    	li $v0, 4
    	la $a0, newLine
    	#syscall 
    	
    	lw $t2, ($a1)
    	move $a0, $t2
    	move $s4, $a0          #s4 contains the contents of string1
    	
    	jal str_to_int        #Call this with $a0 = pointer of first character in the string
    	move $s1, $v0
    	
    	move $a0, $s1
    	li $v0, 1
    	#syscall
    	
    	#-------------------------
    	#Saves to s2
    	#addi $s4, $s4, 2     #s4 contains contents of string 2
    	addi $a1, $a1, 4
    	
    	li $v0, 4
    	la $a0, newLine
    	#syscall 
    	
    	lw $t2, ($a1)
    	move $a0, $t2
    	move $s4, $a0          #s4 contains the contents of string1
    	
    	jal str_to_int        #Call this with $a0 = pointer of first character in the string
    	move $s2, $v0
    	
    	move $a0, $s2
    	li $v0, 1
    	#syscall
    	
    	addi $a1, $a1, -1
    	
    	
    	#Adding the integers to an array!!!!!!!
    	#la $a2, intarray
    	sw $s0, 0($a2)
    	sw $s1, 4($a2)
    	sw $s2, 8($a2)
	
	#Popping the stack
	lw   $a0, 0($sp)
   	lw   $a1, 4($sp)
   	lw   $ra, 8($sp)
   	lw   $s4, 12($sp)
    	lw   $s0, 16($sp)
    	lw   $s1, 20($sp)
    	lw   $s2, 24($sp)
    	lw   $a2, 28($sp)
    	addi $sp, $sp,32
		
 	jr   $ra
#-----------------------------------------------------------------------
# sort_array
#
# Sorts an array of integers in ascending numerical order, with the
# minimum value at the lowest memory address. Assume integers are in
# 32-bit two's complement notation.
#
# arguments:  $a0 - array length (optional)
#             $a1 - pointer to first element of array
#
# returns:    $v0 - minimum element in array
#             $v1 - maximum element in array
#-----------------------------------------------------------------------
# REGISTER USE
#
# Sorted using bubble sort, very simple algorithm
# 
#-----------------------------------------------------------------------

.text
sort_array: nop
#This function is currently pulling fron the array addressed at $a2
#Change so that this array will be pulled from $a1
#

	addi $sp, $sp, -20
    	sw   $a0, 0($sp)
    	sw   $a1, 4($sp)
    	sw   $s4, 8($sp)
    	sw   $s5, 12($sp)
    	sw   $s6, 16($sp)
    	
	li $v0, 4
    	la $a0, sortArr
    	#syscall 
    	
    	#move $a1, $a2
    	#la $a1, intarray
    	li $v0, 4
    	la $a0, newLine
    	#syscall 
    	
    	lw $a0, 0($a1)
    	move $s4, $a0
	li $v0, 1
	#syscall
	
	#print space
	li $v0, 11
	li $a0, 32
	#syscall
	
	lw $a0, 4($a1)
	move $s5, $a0
	li $v0, 1
	#syscall
	
	#print space
	li $v0, 11
	li $a0, 32
	#syscall
	
	lw   $a0, 8($a1)
	move $s6, $a0
	li   $v0, 1
	#syscall
	
	#print space
	li $v0, 11
	li $a0, 32
	#syscall
	
	#for i = 0 < i = 3
	li   $t2, 0 	#This is my counter
	li   $t3, 4	#run 3 times
	start_inner_loop:
		li $t1, 0
		beq $t2, $t3, end_inner_loop
		
		#c.lt.s $s4, $s5
		blt $s4, $s5, fswap
			move $t4, $s4
			move $s4, $s5
			move $s5, $t4
			
			
		fswap:
		
		
		#c.lt.s $s5, $s6
		blt  $s5, $s6, fswap1
			move $t5, $s5
			move $s5, $s6
			move $s6, $t5
		
		fswap1:
		
		addi $t2, $t2, 1	#increment inner loop
		b start_inner_loop
	end_inner_loop:

#	li   $v0, 1
#	move $a0, $s4
#	syscall
#	li   $v0, 4
#	la   $a0, aspace
#	syscall
	
#	li   $v0, 1
#	move $a0, $s5
#	syscall
#	li   $v0, 4
#	la   $a0, aspace
#	syscall
	
#	li   $v0, 1
#	move $a0, $s6
#	syscall
#	li   $v0, 4
#	la   $a0, aspace
#	syscall
	
	#la   $a2, intarray
    	sw   $s4, 0($a1)
   	sw   $s5, 4($a1)
   	sw   $s6, 8($a1)
    	
    	#li $v0, 34
    	#move $a0, $s4
    	#syscall 
    	
    	move $v0, $s4
    	move $v1, $s6
    	
    	
    	lw   $a0, 0($sp)
    	lw   $a1, 4($sp)
    	lw   $s4, 8($sp)
    	lw   $s5, 12($sp)
    	lw   $s6, 16($sp)
	addi $sp, $sp, 20
	
    jr   $ra

#-----------------------------------------------------------------------
# print_decimal_array
#
# Prints integer input array in decimal, with spaces in between each
# element.
#
# arguments:  $a0 - array length (optional)
#             $a1 - pointer to first element of array
#
# returns:    n/a
#
# Pops of the array, printing the 
#-----------------------------------------------------------------------
# REGISTER USE
# 
#-----------------------------------------------------------------------

.text
print_decimal_array: nop
	addi $sp, $sp, -28
    	sw   $a0, 0($sp)
    	
    	#la $a1, intarray
    	sw   $a1, 4($sp)
    	sw   $ra, 8($sp)
    	sw   $s4, 12($sp)
    	sw   $s0, 16($sp)
    	sw   $s1, 20($sp)
    	sw   $s2, 24($sp)
    	
    	li $v0, 4
    	la $a0, newLine
    	#syscall
	
	lw $a0, ($a1)
    	move $s0, $a0
	
	
	jal print_decimal
	
	#print space
	li $v0, 11
	li $a0, 32
	syscall
	
	lw $a0, 4($a1)
	move $s1, $a0
	
	
	jal print_decimal
	
	#print space
	li $v0, 11
	li $a0, 32
	syscall
	
	lw   $a0, 8($a1)
	move $s2, $a0
	
	jal print_decimal
	
	
	
	#Popping the stack
	lw   $a0, 0($sp)
   	lw   $a1, 4($sp)
   	lw   $ra, 8($sp)
   	lw   $s4, 12($sp)
    	lw   $s0, 16($sp)
    	lw   $s1, 20($sp)
    	lw   $s2, 24($sp)
    	addi $sp, $sp,28
	
	jr   $ra
    
#-----------------------------------------------------------------------
# exit_program (given)
#
# Exits program.
#
# arguments:  n/a
#
# returns:    n/a
#-----------------------------------------------------------------------
# REGISTER USE
# $v0: syscall
#-----------------------------------------------------------------------

.text
exit_program: nop
    
    addiu   $v0  $zero  10      # exit program cleanly
    syscall
    
#-----------------------------------------------------------------------
# OPTIONAL SUBROUTINES
#-----------------------------------------------------------------------
# You are permitted to delete these comments.

#-----------------------------------------------------------------------
# get_array_length (optional)
# 
# Determines number of elements in array.
#
# argument:   $a0 - double pointer to string array (pointer to array of
#                   addresses that point to the first characters of each
#                   string in array)
#
# returns:    $v0 - array length
#-----------------------------------------------------------------------
# REGISTER USE
# 
#-----------------------------------------------------------------------

.text
get_array_length: nop
    
    addiu   $v0  $zero  3       # replace with /code to
                                # determine array length
    jr      $ra
    
#-----------------------------------------------------------------------
# save_to_int_array (optional)
# 
# Saves a 32-bit value to a specific index in an integer array
#
# argument:   $a0 - value to save
#             $a1 - address of int array
#             $a2 - index to save to
#
# returns:    n/a
#-----------------------------------------------------------------------
# REGISTER USE
# 
#-----------------------------------------------------------------------
