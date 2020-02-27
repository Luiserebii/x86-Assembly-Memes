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
	cmpl %ecx, size
	jle for_exit

	# sum += size[i]
	addl nums(, %ecx, 4), %ebx
	
	# ++i
	incl %ecx
	# jmp for_loop

	# This line will break here:
	# movl $for_loop, %eip
	# Yielding: "sum-no-jmp.s:34: Error: unsupported instruction `mov'"
	# Seems like %eip is read-only; not possible
	jmp for_loop

for_exit:
	
	# Load up %eax and syscall
	movl $1, %eax
	int $0x80
