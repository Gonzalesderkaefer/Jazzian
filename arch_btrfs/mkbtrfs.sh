#!/bin/bash

# color variables
green="\033[0;32m";
red="\033[0;31m";
end="\033[0m";


# Install JQ
pacman -S jq;


# Get all drives
DRIVES=$(lsblk -p --json | jq -r '.blockdevices[].name');


# Array of drives
arr=();
drive_index=1;

for drive in $DRIVES; do
    arr+=($drive);
    echo "[$drive_index] $drive";
    drive_index=$((drive_index+1));
done

# Ask user which drive to use
echo -ne "${green}Which drive would you like to use? ${end}";
read num;

# Check input is valid
while [[ ! $num =~ [[:digit:]]+ ]] || [[ ! $((num-1)) < ${#arr[@]} ]] || (( $((num-1)) < 0 )); do
    echo -ne "${red}Not valid, enter valid index: ${end}";
    read num;
done


# Root drive
root_drive=${arr[$((num-1))]};

echo -e "${green}Going to format ${root_drive}${end}";
echo -e "${green}Press ENTER to continue ${end}";
read cont;

# New GPT
sgdisk -o $root_drive;

# Boot partition
sgdisk -n1::+4096MiB $root_drive;
sgdisk -t1:EF00 $root_drive;

# LUKS partition
sgdisk -n2:: $root_drive;
sgdisk -t2:8300 $root_drive;

# Get partitions
PARTS=$(lsblk -p --json | jq -r ".blockdevices[] | select(.name==\"$root_drive\").children[].name");

# Array of partitions
parts=();
for part in $PARTS; do
    parts+=($part);
done

# Define partitons
efipart=${parts[0]};
lukspart=${parts[1]};

echo -e "${green}Your Boot partition is ${efipart}${end}";
echo -e "${green}Your LUKS partition is ${lukspart}${end}";
echo -e "${green}Press ENTER to continue ${end}";
read cont;

# Encrypt LUKS partition
echo -e "${green}Encrypting ${lukspart}...${end}";
cryptsetup luksFormat ${lukspart};

# Open encrypted partition
luks_name="root"
cryptsetup open ${lukspart} ${luks_name};

# Create filesystems
mkfs.fat -F32 ${efipart};
mkfs.btrfs /dev/mapper/${luks_name};

# Create temp mount directory and mount
mkdir /target;
mount /dev/mapper/${luks_name} /target;
cd /target;

# Create root subvolume
btrfs subvolume create @;

# Create swap subvolume
btrfs subvolume create @swap;
btrfs filesystem mkswapfile --size 4g --uuid clear @swap/swapfile; # Might switch to zram
cd ~

# Remounting subvolumes
umount /target;
mount -o noatime,compress=zstd,discard=async,space_cache=v2,subvol=@ /dev/mapper/${luks_name} /mnt;
mount --mkdir -o noatime,compress=zstd,discard=async,space_cache=v2,subvol=@swap /dev/mapper/${luks_name} /mnt/swap;
swapon /mnt/swap/swapfile;

# Mount boot partition
mount --mkdir ${efipart} /mnt/boot;

# installing the base system
pacstrap -K /mnt base linux linux-firmware linux-headers networkmanager cryptsetup btrfs-progs grub grub-btrfs vim sudo;

# generate fstab and write it to rootdrive
genfstab -U /mnt >> /mnt/etc/fstab;

# chrooting into the new system
arch-chroot /mnt ./chroot.sh ${rootuuid} ${luks_name};

# user specific configuration
arch-chroot /mnt;
