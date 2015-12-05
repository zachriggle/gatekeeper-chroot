all: chroot-full chroot-empty

chroot-full: capdrop.c  chroot.c  main.c
	gcc -std=c99 *.c -o $@

chroot-empty: capdrop.c  chroot.c  main.c
	gcc -std=c99 *.c -o $@ -DEMPTY_CHROOT

test:
	bats *.bats

clean:
	rm -f chroot-full chroot-empty
