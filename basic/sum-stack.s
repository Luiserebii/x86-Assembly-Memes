.section .data

nums:
	.long 10, 20, 30

size:
	.long 3

.section .text
.globl _start

_start:
	
	# Load all nums onto stack
	# (Let's do this manually)
	subl $12, %esp
	
	# We can't do a memory-to-memory move, so we need a register intermediary
	# This is why we need %ecx
	# Indexed addressing **requires** a register for the second, so we'll need
	# to load one up via %edx
	movl $0, %edx
	movl nums(, %edx, 4), %ecx
	movl %ecx, 12(%esp)
	
	movl $1, %edx
	movl nums(, %edx, 4), %ecx
	movl %ecx, 8(%esp)
	
	movl $2, %edx
	movl nums(, %edx, 4), %ecx
	movl %ecx, 4(%esp)
	
	# (The alternate way is to movl first, subl after)
	# (The way we address %esp is different in that case though)
	
	# Grab each and pop!
	movl $0, %ebx
	
	# Grab the first and pop
	addl 4(%esp), %ebx
	addl $4, %esp
	
	# Grab the second and pop
	addl 4(%esp), %ebx
	addl $4, %esp

	# Grab the third and pop
	addl 4(%esp), %ebx
	addl $4, %esp

	# Finally, load syscall and return
	movl $1, %eax
	int $0x80
