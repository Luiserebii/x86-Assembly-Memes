.section .data

title:
	.ascii "Hello world\n"

.section .text
.globl _start

_start:

	movl $title, %ebx
	movl $1, %eax
	int $0x80
