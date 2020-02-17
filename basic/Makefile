# Set name via make, i.e. make NAME=count

simple:
	as $(NAME).s -o $(NAME).o && ld $(NAME).o

count: 
	$(MAKE) simple NAME=count

clean:
	rm *.o a.out
