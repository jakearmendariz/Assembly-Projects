.text
 li $v0, 4
la $a0, prompt
syscall

#get value
li $v0, 5
syscall

 move $s1, $v0
 li $s0, 0
 li $s2, 0 # Initialize the total

 start_loop:
 	sle $t1, $s0, $s1
 	beqz $t1, end_loop

 	# code block
 	add $s2, $s2, $s0 #Adding the counter to the sun 
 	addi $s0, $s0, 1 #This is the counter
 	b start_loop
 end_loop:

 la $a0, output
 move $a1, $s2
 
#print s2
li $v0, 1
move $a0, $s2
syscall 

#ends program
li $v0, 10
syscall
 
.data
 prompt: .asciiz "enter the value to calculate the sum up to: "
 output: .asciiz "The final result is: "
