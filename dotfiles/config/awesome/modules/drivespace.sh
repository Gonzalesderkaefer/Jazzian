#!/usr/bin/env bash

# Get relevant df entries
rootentry=$(df -TH | grep -E '/$')
homeentry=$(df -TH | grep -E '/home$')

# Get Filesystems
rootfs=$(echo ${rootentry} | awk '{print $1}')
homefs=$(echo ${homeentry} | awk '{print $1}')

# Get used space
rootused=$(echo ${rootentry} | awk '{print $4}')
homeused=$(echo ${homeentry} | awk '{print $4}')

if [[ ${rootfs} == ${homefs} ]] || [[ -z ${homefs} ]]; then
    printf "${rootused}  \n"
else
    printf "${rootused}  ${homeused}  \n";
fi


