
# chroot

Starts the target process in a chroot environment.  Most common world-readable resources can be bind-mounted so that we don't have to copy libraries around.

## usage

```sh
$ make
$ ./chroot $(mktemp -d) /bin/sh
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
