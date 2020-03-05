# Set name via make, i.e. make NAME=count

ASFLAGS=-g3 --32
LDFLAGS=-m elf_i386

main: helloworld dynlink

simple:
	as $(ASFLAGS) $(NAME).s -g -o $(NAME).o && ld $(LDFLAGS) $(NAME).o

helloworld: 
	as $(ASFLAGS) helloworld.s -g -o helloworld.o 
dynlink: 
	ld $(LDFLAGS) -dynamic-linker /lib/ld-linux.so.2 helloworld.o -lc

clean:
	rm *.o a.out
