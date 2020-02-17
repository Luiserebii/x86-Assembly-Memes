#
# Compare two strings and return 0 if equal
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

	# Reserve %ebx for equality status
	movl $0, ebx

while_equal:
	
	# Load in both chars, and see if either is 0
	# if one is 0, and they are not both 0, we will
	# have to throw and note that they aren't equal
	movl str1(, %eax, 4), %ecx
	movl str2(, %eax, 4), %edx

	

end_while_equal:
