# File Variables
src=install.c
bin=install.out
bindir=.bin

# Define Targets
run:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -o $(bindir)/$(bin) $(src)
	./$(bindir)/$(bin)

val:
	[ -d $(bindir) ] || mkdir $(bindir)
	gcc -o $(bindir)/$(bin) $(src)
	valgrind ./$(bindir)/$(bin)
