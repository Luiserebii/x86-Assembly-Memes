#
# Find the sum of a pre-defined list of numbers, terminating in 0
#

.section .data

nums:
	.long 1, 2, 3, 4, 5

size:
	.long 5

.section .text
.globl _start

_start:

	# Reserve %ebx for the sum of nums
	movl $0, %ebx
	# Use %ecx as index
	movl $0, %ecx

for_each_num:
	
	# Check to see that the index hasn't hit the size
	cmpl %ecx, size
	je for_each_num_end
	
	# Load num into %eax, and add
	movl nums(, %ecx, 4), %eax
	addl %eax, $ebx

	# Increment and jump
	incl %ecx
	jmp for_each_num
	
for_each_num_end:

	# We already have the sum at %ebx, so
	# just set exit num and syscall
	movl $1, %eax
	int $0x80
