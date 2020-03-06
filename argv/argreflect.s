#
# argreflect
# 
# Reflects the name, number of arguments, and each argument 
# to the standard output stream.
#
#

.section .bss
	.equ BUFFER_SIZE, 1000
	.lcomm buffer, BUFFER_SIZE

.section .data
title:
	.ascii "==============\nargreflect\n=============\n\n\0"
meme:
	.ascii "\nowo senpai pls notice me uwu\n"

.section .text
.globl _start

_start:
	# Capture current stack position into base pointer
	movl %esp, %ebp

	.equ ARGC_NUM, 0
	.equ ARGV_N, 4

	# Write piece to buffer
	pushl $title
	pushl $buffer
	call strcpy

	# Attempt strcat into buffer
	pushl $meme
	pushl $buffer
	call strcat

	# Print buffer
	.equ WRITE_SYSCALL, 4
	.equ STDOUT, 1
	movl $WRITE_SYSCALL, %eax
	movl $STDOUT, %ebx
	movl $buffer, %ecx
	movl $BUFFER_SIZE, %edx
	int $0x80

	# Exit
	movl $1, %eax
	int $0x80

#=========
# strcpy 
#=========
#  Takes two arguments, a destination and a source.
#
#  Each is expected to be a null-terminated array of chars,
#  and it is expected that each argument be the address to
#  the first element in the array.
.type strcpy, @function
strcpy:
	pushl %ebp
	movl %esp, %ebp
	
	# Copy each element into the destination, until '\0' found
	# Uses %eax for destination, %ecx as source
	movl 8(%ebp), %eax
	movl 12(%ebp), %ecx

while_copy:
	# Set char in destination to char in source
	# Using least-significant piece of %edx
	movb (%ecx), %dl
    	movb %dl, (%eax)

	# Increment both
	incl %eax
	incl %ecx

	# Check value of copied char, if 0, move to end	
	cmpb $0, %dl
	jne while_copy

while_end:

	movl %ebp, %esp
	popl %ebp
	ret

#=========
# strcat
#=========
#  Takes two arguments, a destination and a source.
#
#  Each is expected to be a null-terminated array of chars,
#  and it is expected that each argument be the address to
#  the first element in the array.
.type strcat, @function
strcat:
	pushl %ebp
	movl %esp, %ebp

	# Load in addresses to registers
	# Uses %eax for destination, %ecx as source
	movl 8(%ebp), %eax
	movl 12(%ebp), %ecx

while_src_not_0:
	cmpl $0, (%eax)
	je while_src_not_0_end

	# Increment %eax's address a byte to the next char
	incl %eax

	jmp while_src_not_0

while_src_not_0_end:

while_cat_copy:
	# Set char in destination to char in source
	# Using least-significant piece of %edx
	movb (%ecx), %dl
	movb %dl, (%eax)

	# Increment both
	incl %ecx
	incl %eax

	# Check value of copied char, if 0, move to end
	cmpb $0, %dl
	jne while_cat_copy

while_cat_copy_end:
	movl %ebp, %esp
	popl %ebp
	ret
