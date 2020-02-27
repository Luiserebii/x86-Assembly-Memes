.section .data

nums:
	long 1, 2, 3

size:
	long 5

.section .text
.globl _start

_start:
	
	# Load all nums onto stack
	# (Let's do this manually)
	subl $12, %esp
	movl nums(, 0, 4), 12(%esp)
	movl nums(, 1, 4), 8(%esp)
	movl nums(, 2, 4), 4(%esp)

	# (The alternate way is to movl first, subl after)
	# (The way we address %esp is different in that case though)
	
	# Grab each and pop!
	movl $0, %ebx
	
	# Grab the first and pop
	addl 4(%esp), %ebx
	addl $4, %esp
	
	# Grab the second and pop
	addl 8(%esp), %ebx
	addl $4, %esp

	# Grab the third and pop
	addl 12(%esp), %ebx
	addl $4, %esp

	# Finally, load syscall and return
	movl $1, %eax
	int $0x80
