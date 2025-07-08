#!/usr/bin/bash


# Get relevant df entries
rootentry=$(df -TH | grep -E '/$')
homeentry=$(df -TH | grep -E '/home$')

# Get Filesystems
rootfs=$(echo ${rootentry} | awk '{print $1}')
homefs=$(echo ${homeentry} | awk '{print $1}')

# Get used space
rootused=$(echo ${rootentry} | awk '{print $4}')
homeused=$(echo ${homeentry} | awk '{print $4}')

# NOTE: Might implement it to print json
if [[ $1 == "home" ]]; then
    if [[ ${rootfs} == ${homefs} ]]; then
        printf "";
    else
        printf "${homeused}  \n";
    fi
elif [[ $1 == "root" ]]; then
    printf "${rootused}  \n"
fi

