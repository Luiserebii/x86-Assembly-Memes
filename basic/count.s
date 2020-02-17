#
# Count all of the elements in a certain pre-defined list
#

.section .data

nums:
	.long 1, 2, 3, 4, 5, 0

.section .text
.globl _start

_start: 

	movl $0, %eax   # Set register for our count to 0
	
while_not_zero:

	# Load in indexed number from list
	movl nums(, %eax, 4), %ebx

	# Test if we hit the end, so we can exit our loop
	cmpl $0, %ebx
	je end_while_not_zero

	# If we've made it this far, increment, as we found a valid element
	incl %eax
	jmp while_not_zero

end_while_not_zero:

	# Return value as status code
	# Since %eax holds the system call number, and %ebx the return,
	# we have to set as necessary (we could simply use %ebx as the counter,
        # but I think not doing so shows the logical flow better)
	movl %eax, %ebx
	movl $1, %eax

	# Finally, interrupt into system call
	int $0x80
