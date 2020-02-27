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
	pushl nums(, %edx, 4)
	
	movl $1, %edx
	pushl nums(, %edx, 4)
	
	movl $2, %edx
	pushl nums(, %edx, 4)
	
	# (The alternate way is to movl first, subl after)
	# (The way we address %esp is different in that case though)
	
	# Grab each and pop!
	movl $0, %ebx
	
	# Grab the first and pop
	# Something to note; this is a situation where 
	# popl might result in an extra instruction
	popl %ecx
	addl %ecx, %ebx
	
	# Grab the second and pop
	popl %ecx
	addl %ecx, %ebx

	# Grab the third and pop
	popl %ecx
	addl %ecx, %ebx

	# Finally, load syscall and return
	movl $1, %eax
	int $0x80
