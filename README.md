tiny-chroot
===========

Set up a clean chroot environment (a.k.a. sandbox) on a FreeBSD box in 30
seconds:

    tiny-chroot

With the _tiny-chroot_ tools you can manage several nullfs-based chroot
environments for development, testing, or experiments on your FreeBSD
machines.

First define a directory that will be a root for your sandbox:

    % mkdir $HOME/my-test-chroot

Now as a root, using the _sudo(8)_ command:

    % sudo setup-chroot $HOME/my-test-chroot

Your new sandbox is now set up. You can create more than one sandboxes in
different directories. All your sandboxes are identified by their root
directories, and can be listed with:

    % setup-chroot -l
    Your chroots:

    /home/mkushnir/my-test-chroot

Alternative way to see your chroot details is to run:

    % mount -p
    /dev/ad0s1a             /                       ufs     rw              1 1
    devfs                   /dev                    devfs   rw              0 0
    procfs                  /proc                   procfs  rw              0 0
    /bin                    /home/mkushnir/my-test-chroot/bin nullfs   ro              0 0
    /lib                    /home/mkushnir/my-test-chroot/lib nullfs   ro              0 0
    /libexec                /home/mkushnir/my-test-chroot/libexec nullfs       ro              0 0
    /usr/bin                /home/mkushnir/my-test-chroot/usr/bin nullfs       ro              0 0
    /usr/lib                /home/mkushnir/my-test-chroot/usr/lib nullfs       ro              0 0
    /usr/lib32              /home/mkushnir/my-test-chroot/usr/lib32 nullfs     ro              0 0
    /usr/libdata            /home/mkushnir/my-test-chroot/usr/libdata nullfs   ro              0 0
    /usr/libexec            /home/mkushnir/my-test-chroot/usr/libexec nullfs   ro              0 0
    /usr/share              /home/mkushnir/my-test-chroot/usr/share nullfs     ro              0 0
    /etc                    /home/mkushnir/my-test-chroot/etc nullfs   ro              0 0
    /sbin                   /home/mkushnir/my-test-chroot/sbin nullfs  ro              0 0
    /usr/include            /home/mkushnir/my-test-chroot/usr/include nullfs   ro              0 0
    /usr/sbin               /home/mkushnir/my-test-chroot/usr/sbin nullfs      ro              0 0
    /usr/ports              /home/mkushnir/my-test-chroot/usr/ports nullfs     ro              0 0
    devfs                   /home/mkushnir/my-test-chroot/dev devfs    rw              0 0

You will see nullfs mount points that make up your sandbox. Because of the
nullfs feature, your fresh sandbox takes no extra disk space on the
system. Additionally, all your system directories will be read-only.

Now enter your sandbox:

    % sudo chroot $HOME/my-test-chroot /bin/sh

Since the /usr/ports directory is actually a read-only nullfs mount point,
in order to install ports you have to point WRKDIRPREFIX and DISTDIR to
a sensible location:

    # setenv WRKDIRPREFIX /tmp
    # setenv DISTDIR /tmp

Now you can install some app:

    # cd /usr/ports/lang/python25 && make BATCH=yes install clean

**NOTE:**

You have to make sure that there is enough space on the partition
the root directory of your sandbox lies on.

When you no longer need your sandbox, run:

    % sudo cleanup-chroot $HOME/my-test-chroot

It will completely wipe out all your sandbox: delete all applications and
data, and un-mount mountpoints.

