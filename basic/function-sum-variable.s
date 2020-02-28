#
# Uses a function sum which takes a variable number of arguments.
# Pushes all nums onto the stack, calls, and returns value on exit
# 
.section .data

nums:
	.long 1, 2, 3, 4, 5

size:
	.long 5

.section .text
.globl _start

_start:

	# Push the size onto the stack
	pushl size

for_init:
	movl $0, %ebx

for_loop:
	cmpl %ebx, size
	jle for_exit
	
	# Actual logic
	# push each thing onto the stack
	pushl nums(, %ebx, 4)

for_inc:
	incl %ebx
	jmp for_loop

for_exit:
	# Call function sum
	call sum
	# Load return into %ebx
	movl %eax, %ebx

return:
	movl $1, %eax
	int $0x80

# Sum expects a variable number of arguments.
# The first parameter is expected to contain the number of arguments
# passed, and will sum each argument found and return.

.type sum, @function
sum:
	# Sum function setup
	pushl %ebp
	movl %esp, %ebp

	# Process arguments
s_for_init:
	# Note that %eax will be containing the sum
	movl $0, %eax
	# This is the "real" piece of the for initializer
	movl $0, %ecx
	
s_for_loop:
	cmpl %ecx, 8(%ebp)
	jle for_exit
	
	# Actual logic
	# We load 4 into %edx, as we want 4 * i
	movl $4, %edx
	imul %ecx, %edx

	# No clue if this runs
	#addl %edx(%ebp), %eax
	#addl (%ebp)(, %ecx, 4), %eax

s_for_inc:
	incl %ecx
	jmp for_loop

s_for_exit:	

	# Sum function exit
	movl %ebp, %esp
	popl %ebp
	ret
