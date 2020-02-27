#
# An attempt to not use jmp and just set %eip directly
#

.section .data

nums: 
	.long 1, 2, 3

size:
	.long 3

.section .text
.globl _start

_start:


	# for(int i = 0; i < size; ++i)

	# int i = 0;
	movl $0, %ecx
	# int sum = 0;
	movl $0, %ebx

for_loop:
	cmpl %ecx, size(, 0, 4)
	jle for_exit

	# sum += size[i]
	addl %ebx, nums(, %ecx, 4)
	
	# ++i
	incl %ebx
	jmp for_loop

for_exit:
	
	# Load up %eax and syscall
	movl $1, %eax
	int $0x80
