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
	.lcomm buffer_temp, BUFFER_SIZE

.section .data
title:
	.ascii "==============\nargreflect\n=============\n\n\0"
name_init:
	.ascii "name: \0"
num_args_init:
	.ascii "num of args: \0"
endl:
	.ascii "\n\0"

.section .text
.globl _start

_start:
	# Capture current stack position into base pointer
	movl %esp, %ebp

	# Write title to buffer, push $title and $buffer both onto stack
	subl $8, %esp
	movl $title, 4(%esp)
	movl $buffer, (%esp)
	call strcpy

	# Concat in init name field
	movl $name_init, -4(%ebp)
	call strcat

	# Concat in actual name arg
	.equ ARGV_NAME, 4
	# Idea here is to optimize; buffer has already been loaded onto the stack,
	# so just modify the first argument and call again
	movl ARGV_NAME(%ebp), %eax
	movl %eax, -4(%ebp)
	call strcat

	# Concat closing
	movl $endl, -4(%ebp)
	call strcat

	# Concat in init num of args field
	movl $num_args_init, -4(%ebp)
	call strcat

	# argc is at 0, so:
	pushl (%ebp)
	pushl $buffer_temp
	call itoa

	# Ahhh, we're gonna need a function to convert the int into a string... nuts
	#movl (%ebp), %eax
	#movl %eax, -4(%ebp)
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

#=========
# itoa
#=========
#  Takes two arguments, a 32-bit int and an address pointing to
#  an array of chars.
#
#  It is assumed that the char array has enough space to fit the
#  int; otherwise, the behavior is undefined.
.type itoa, @function
itoa:
	pushl %ebp
	movl %esp, %ebp

	# Make room for a few local variables on the stack:
	.equ ITOA_NO_LVARS, 4
	.equ ITOA_LV_BYTES, ITOA_NO_LVARS * 4
	subl $ITOA_LV_BYTES, %esp

	# Use var to hold the mult. counter
	.equ ITOA_MULT_CTR, -4
	movl $1, ITOA_MULT_CTR(%ebp)

	# Use var to hold the 32-bit int to manipulate
	.equ ITOA_N, -8
	movl 8(%ebp), %eax
	movl %eax, ITOA_N(%ebp)

	# Use var to hold the digit to keep track of
	.equ ITOA_DIGIT, -12

	# Use var to hold the address of the string to iterate through
	.equ ITOA_STR, -16
	movl 12(%ebp), %eax
	movl %eax, ITOA_STR(%ebp)

itoa_while_not_zero:
	# while(n != 0)
	cmpl $0, ITOA_N(%ebp)
	je itoa_while_not_zero_end

	# Define dividend ATOI_N in %edx:%eax
	movl $0, %edx
	movl ITOA_N(%ebp), %eax

	# Divide ATOI_N by 10 (10 being the base)
	movl $10, %ecx
	idivl %ecx
	
	# Set remainder (%) to digit, and quotient back to ATOI_N
	movl %edx, ITOA_DIGIT(%ebp)
	movl %eax, ITOA_N(%ebp)
	
	# "Increment" multctr by multiplying by base
	imull %ecx
	movl %eax, ITOA_MULT_CTR(%ebp)

	# Set current string pos to digit equivalent, and increment
	movl ITOA_STR(%ebp), %eax
	.equ ITOA_0_CHAR, '0'
	movl $ITOA_0_CHAR, %ecx
	addl ITOA_DIGIT(%ebp), %ecx
	
	movl %ecx, (%eax)
	incl ITOA_STR(%ebp)

	jmp itoa_while_not_zero

itoa_while_not_zero_end:
	# Finally, cap string off with '\0' null terminator
	movl ITOA_STR(%ebp), %eax
	movl $0, (%eax)

	movl %ebp, %esp
	popl %ebp
	ret
