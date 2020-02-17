# Set name via make, i.e. make NAME=count

simple:
	as $(NAME).s -g -o $(NAME).o && ld $(NAME).o

count: 
	$(MAKE) simple NAME=count

string-equal:
	$(MAKE) simple NAME=string-equal

sum:
	$(MAKE) simple NAME=sum

string-copy:
	$(MAKE) simple NAME=string-copy

clean:
	rm *.o a.out
