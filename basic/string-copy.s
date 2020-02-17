#
# Copies string a to string b. 
#

.section .data

stra:
	.ascii "apple\0"

strb:
	.ascii "banana\0"

.section .text
.globl _start

_start:

for_initializer:
	
	# Reserve %ebx as initializer (index)
	movl $0, %ebx
	
for_check_set_valid:
	
	# Set the b char to the a char at %ebx (does this work?)
	# Ah! Maybe, load in address to itself to register, add, and...?
	movl $strb, %eax
	# Use %edx to hold result of mul
	movl $4, %edx
	imull %ebx, %edx
	# Finally, add result to %eax
	addl %edx, %eax
	# And, move to addr:
	movl stra(, %ebx, 4), %eax
	
	# Increment
	incl %ebx
	
	# Check the newly set value to see that it is not \0
	movl strb(, %ebx, 4), %ecx
	cmpl $0, %ecx

	# If not zero, hop back
	jne for_check_set_valid

for_end:

	# Load in exit value and syscall
	movl $1, %eax
	int $0x80
