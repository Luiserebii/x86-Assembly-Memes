#
# The idea is to create a basic sum function that takes two numbers,
# and returns the sum.
#

.section .data

.section .text
.globl _start

_start:

	# Push two nums onto stack
	pushl $64
	pushl $36

	# Call sum and load sum into %ebx
	call sum
	movl %eax, %ebx

	# Clean up and exit
	movl $1, %eax
	int $0x80

#
# sum expects two arguments via the stack, and returns a long
# value representing the sum of the numbers passed.
# 
sum: 
	# Perform basic function entry
	pushl %ebp
	movl %esp, %ebp

	# Logic
	movl $0, %eax
	addl 8(%ebp), %eax
	addl 12(%ebp), %eax

	# Perform exit logic and return
	movl %ebp, %esp
	popl %ebp
	ret
