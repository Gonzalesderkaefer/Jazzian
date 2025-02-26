#!/bin/bash

# color variables
green="\033[0;32m";
red="\033[0;31m";
end="\033[0m";


# Arguments:
# 1. UUID of root
# 2. Name of the luks part

if [[ "$1" == "" ]] || [[ "$2" == "" ]]; then
    echo "${red}This script requires 2 arguments${end}";
fi






# setting the time and timezone
# TODO: check if Input is valid
echo -ne "${green}Please enter the region:${end} ";
read region;

echo -ne "${green}Please enter the city:${end} ";
read city;

ln -sf /usr/share/zoneinfo/$region/$city /etc/localtime;
hwclock --systohc;

# 'uncomment' en_US.UTF-8 UTF-8 from /etc/locale.gen
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen;
locale-gen;


# Hostname configuration
echo -ne "${green}What hostname would you like to use? :${end} ";
read hostname;
echo "${hostname}" >> /etc/hostname;

# mkinitcpio config
sed -i 's/\(^MODULES=(\)/\1btrfs/g' /etc/mkinitcpio.conf
sed -i 's/\(HOOKS=(.*block\)/\1 encrypt/g' /etc/mkinitcpio.conf
mkinitcpio -P;

# user creation
echo -ne "${green}Username: ${end}";
read username;
useradd -m -G wheel,audio,video ${username};
passwd ${username};
echo "${user}   ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/${user};



# Install Grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

# Build kernel-parameter string
rootuuid=$1;
luks_name=$2;
kernel_param="cryptdevice=UUID=${rootuuid}:${luks_name} root=/dev/mapper/${luks_name}";

# Add kernel-parameter
sed -i "s|\(GRUB_CMDLINE_LINUX_DEFAULT=.*\)\"|\1 ${kernel_param}\"|g" /etc/default/grub

# Create grub config
grub-mkconfig -o /boot/grub/grub.cfg

# Enabling services
systemctl enable NetworkManager.service
