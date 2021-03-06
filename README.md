
# chroot

Starts the target process in a chroot environment.  Most common world-readable resources can be bind-mounted so that we don't have to copy libraries around.

If you want a more restrictive chroot, just modify `main.c` to remove the `chroot_add_bind` statements.  If you want to add additional directories to the chroot, just add `chroot_add_bind` statements.

## building

Just run `make`.

## usage

If you want a full chroot, with some directories mounted (e.g. `/home`):

```sh
$ ./chroot-full $(mktemp -d) /bin/sh
$ pwd
/
$ echo $$
1
$ ps auxf
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
user         1  0.0  0.0  29080  2364 pts/81   S    00:18   0:00 sh
user        14  0.0  0.0  26188  1168 pts/81   R+   00:20   0:00 ps auxf
$ touch /foo
touch: cannot touch ‘/foo’: Read-only file system
$ find /tmp
/tmp
$ crontab -e
/var/spool/cron: No such file or directory
```

If you want a very sparse, pre-prepared `chroot`, use `chroot-empty` instead.

```sh
$ ./chroot-empty empty-chroot sh
$ ls -la
sh: ls: command not found
$ echo *
bin dev etc flag home lib lib32 lib64 proc sbin tmp usr
$ echo bin/*
bin/sh
$ cat flag
sh: cat: command not found
$ while read line; do echo $line; done < flag
Flag{Hurray_chroots_are_fun_amirite?}
```
