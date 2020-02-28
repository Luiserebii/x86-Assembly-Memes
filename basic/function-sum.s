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

# Sum expects a variable number of arguments.
# The first parameter is expected to contain the number of arguments
# passed, and will sum each argument found and return.

.type sum, @function
sum:


