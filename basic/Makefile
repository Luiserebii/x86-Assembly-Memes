# Set name via make, i.e. make NAME=count

ASFLAGS=-g3 --32
LDFLAGS=-m elf_i386

simple:
	as $(ASFLAGS) $(NAME).s -g -o $(NAME).o && ld $(LDFLAGS) $(NAME).o

count: 
	$(MAKE) simple NAME=count

string-equal:
	$(MAKE) simple NAME=string-equal

sum:
	$(MAKE) simple NAME=sum

string-copy:
	$(MAKE) simple NAME=string-copy

sum-no-jmp:
	$(MAKE) simple NAME=sum-no-jmp

sum-stack:
	$(MAKE) simple NAME=sum-stack

sum-stack-pushl:
	$(MAKE) simple NAME=sum-stack-pushl

function-sum:
	$(MAKE) simple NAME=function-sum

function-sum-variable:
	$(MAKE) simple NAME=function-sum-variable

clean:
	rm *.o a.out
