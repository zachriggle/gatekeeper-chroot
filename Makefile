all:
	gcc -std=c99 *.c -o chroot

test:
	bats *.bats
