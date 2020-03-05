#
# argreflect
# 
# Reflects the name, number of arguments, and each argument 
# to the standard output stream.
#
#

.section .text
.globl _start

_start:
	# Capture current stack position into base pointer
	movl %esp, %ebp

	movl 4(%ebp), %eax
	movl 8(%ebp), %ebx
	movl 12(%ebp), %ecx
	
	# Exit
	movl $1, %eax
	int $0x80
