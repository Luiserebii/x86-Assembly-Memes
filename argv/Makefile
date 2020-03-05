# Set name via make, i.e. make NAME=count

ASFLAGS=-g3 --32
LDFLAGS=-m elf_i386

main: argreflect link

argreflect: 
	as $(ASFLAGS) argreflect.s -g -o argreflect.o 

link: 
	ld $(LDFLAGS) argreflect.o

clean:
	rm *.o a.out
