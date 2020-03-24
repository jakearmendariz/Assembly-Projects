Lab4 ReadMe
Armendariz, Jake
Jsarmend
1650932
Fall 2019

Description -> This program receives 3 program arguments in string/IEE. form This code will turn these into hex/floating point form and sort them. Using a variation in bubble sort, it will swap values and then print out the three arguments in increasing order to the console window, first in IEEE 754 floating point format. Then in decimal format.
Thanks!

Lab4.asm -> program in Mips that executes the code. Uses registers, no arrays and swaps between registers when needed.
Syscall 4 to print Program arguments
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

Diagram -> outdated version of my pseudo code, before I realized how easy the lab was.
~                      
