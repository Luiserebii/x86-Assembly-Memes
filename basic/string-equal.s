#
# Compare two strings and return 0 if equal
#
# NOTE: Not currently working, I think part of the issue is our
# loading of chars into a 32-bit register
#

.section .data

str1:
	.ascii "apple\0"

str2:
	.ascii "apple\0"

.section .text
.globl _start

_start:

	# Set counter to 0
	movl $0, %eax

	# Reserve %ebx for equality status, and assume equal
	movl $0, %ebx

while_equal:
	
	# Load in both chars, and see if either is 0
	# if one is 0, and they are not both 0, we will
	# have to throw and note that they aren't equal
	movl str1(, %eax, 4), %ecx
	movl str2(, %eax, 4), %edx

	cmpl %ecx, %edx
	je if_equal

	# If we hit here, not equal, so... 
	movl $1, %ebx
	jmp end_while_equal

if_equal:

	# Ensure both are not 0 before moving on, otherwise,
	# we can break out and increment counter
	# if(%ecx == 0 && %edx == 0) { jmp end_while_equal } else { ++eax, jmp while_equal }
	cmpl $0, %ecx
	jne if_equal_not_zero

	cmpl $0, %edx
	jne if_equal_not_zero
	# If we hit here, branch to the zero one
	jmp if_equal_zero

	if_equal_not_zero:

		incl %eax
		jmp while_equal
	
	if_equal_zero:
	
		# If we hit here, both are 0, so equal!
		jmp end_while_equal
		
end_while_equal:

	# Set the exit system call number and interrupt out
	movl $1, %eax
	int $0x80
