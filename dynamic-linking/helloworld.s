.section .data

helloworld:
	.ascii "Hello world!\n\0"

.section .text
.globl _start

_start:

	# Push argument for printf
	pushl $helloworld
	call printf

	movl $1, %eax
	movl $0, %ebx
	int $0x80
