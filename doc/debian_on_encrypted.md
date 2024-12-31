# How to install Debian on an already encrypted btrfs drive

This guide is uses the information from the following resources:  
- [Installing Debian on Existing Encrypted LVM](https://www.blakecarpenter.dev/installing-debian-on-existing-encrypted-lvm)

- [Debian 12 Bookworm Installation w/BTRFS/XFCE/TIMESHIFT & GRUB-BTRFS](https://youtu.be/9htEaXAXfdg?si=gc4US12XcwKzdGGt)

## Prerequisites
- Drive with a BTRFS filesystem, subvolumes and some knowledge how to use it
- Experience with installing Debian and installing Operating Systems in general
(This was tested in a VM with a UEFI Bios)

## Starting the Installer
As soon as you land in the go to `Advanced Options` and then select `Expert Install` Whether you use
GUI does not matter in this guide we will use the non-GUI variant.

## First steps in installer
Walkthrough the installer just before `Load installer components from installation media`.  
Hit Enter and check `crypto-dm-modules` and `rescue-mode`. Then walkthrough the installer just before
`Detect disk`

## Decrypting the disk
Now We need to enter Busybox do this by hitting `CTRL-ALT-F2` then hit `ENTER`  
You have to know which drive you want to decrypt you can get more information by running:  
```
~ # blkid
```
You should get an output that looks like the following:  
```
/dev/sda1: UUID="<UUID>" ...
/dev/sda2: UUID="<UUID>" ...
/dev/sda3: UUID="<UUID>" ...
```
Once you have identified the encrypted partition run:  
```
~ # cryptsetup open /dev/sda3 root-crypt
```
You don't have to use `root-crypt` you can use another name but you should write it down for later.
Now Press `CTRL-ALT-F1` to go back and continue unitl just before `Partition disks`

## Partitioning the drive
Hit `ENTER` on `Partition disks` and then select `Manual` Now you should see The Partition Editor UI.  
Select the BTRFS partition under the `Encrypted volume` section and in `Use as:` select `btrfs journaling file system`  
For `Format the partition:` select `no, keep existing data` and as `Mount point` choose `/ - The root file system`  
Then select `Done setting up the partition`

Then format the `/boot/efi`, `/boot` and swap partition (I don't have one) as you usually would Then hit 
`Finish partitionioning and write changes to the disk`

## Remounting the subvolumes
Now you should be back at the global menu. Hit `CTRL-ALT-F2` to enter Busybox again. We have to remount 
the subvolumes

First unmount the drives:  
```
~ # umount /target/boot/efi
~ # umount /target/boot
~ # umount /target
```

then mount the btrfs partition to `/mnt`:  
```
~ # mount /dev/mapper/root-crypt /mnt
```
replace `root-crypt` with your name if you chose another one. Then `cd /mnt`
If you have an old root subvolume you can remove it debian names the newly create one `@rootfs`
Remove the old sub volume with:  
```
/mnt # btrfs subvolume delete @
```
The previous subvolume was called `@`.

Now you can rename `@rootfs` to `@` with `mv`:  
```
/mnt # mv @rootfs/ @  
```

Now remount the subvolumes  
```
mount -o noatime,compress=zstd,subvol=@ /dev/mapper/root-crypt /target
mkdir /target/home
mount -o noatime,compress=zstd,subvol=@home /dev/mapper/root-crypt /target/home # only if you had a home subvolume
mount /dev/sda2 /target/boot 
mount /dev/sda1 /target/boot/efi
```
If you plan to use the same home directory make sure to rename to `username.bac` from `username`

### Editing fstab
To edit the `fstab` on your new install use:  
```
~ # nano /target/etc/fstab
```

Replace the following line:  
`/dev/mapper/root-crypt /       btrfs   defaults,subvol=@rootfs  0 0` with  

`/dev/mapper/root-crypt /       btrfs   noatime,compress=zstd,subvol=@  0 0` and for your home add:  
`/dev/mapper/root-crypt /home       btrfs   noatime,compress=zstd,subvol=@home  0 0`

And again replace `root-crypt` with the name you chose if you did choose another one.

Go back with `CTRL-ALT-F1` and select `Install the base system`

## Adding encryption on boot
Proceed with the install and stop just before selecting `Install the GRUB bootloader`. Here jump back to 
Busybox and run:  
```
~ # blkid /dev/sda3 >> /target/etc/crypttab # sda3 is the partition with the encrypted partition
```
open the file in nano and in the last line delete everything except the `UUID="<UUID>"` part
Then remove the quotes and make sure it has the following format
```
# <target-name>  <source device>    <key file>   <options>
  root-crypt     UUID=<UUID>        none         luks
```

You don't need the first line and as always: use the name you gave it if you gave it another name.        

## Finishng
Proceed with the installation the initramfs will be rebuilt and you should be able to use Debian


