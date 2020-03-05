#
# argreflect
# 
# Reflects the name, number of arguments, and each argument 
# to the standard output stream.
#
#

.section .bss
	.equ BUFFER_SIZE 1000
	.lcomm buffer, BUFFER_SIZE

.section .data
title:
	.ascii "=============\nargreflect\n=============\n\n\0"

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
