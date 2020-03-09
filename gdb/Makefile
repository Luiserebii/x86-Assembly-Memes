# Set name via make, i.e. make NAME=count

ASFLAGS=-g --32
LDFLAGS=-m elf_i386

main: mainp link

mainp: 
	as $(ASFLAGS) main.s -o main.o 

link: 
	ld $(LDFLAGS) main.o

clean:
	rm *.o a.out
