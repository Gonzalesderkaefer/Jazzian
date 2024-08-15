#!/bin/bash

# configfile location
config_file=$HOME/Jazzian/modules/devicespecific.conf

# run config script if config file does not exist
if ! [ -f $config_file ]; then
    bash $HOME/Jazzian/modules/config.sh
fi

# read config file and create variables
displayserver=$(grep -E  "Displayserver: " $config_file | awk '{print $2}');
windowmanager=$(grep -E  "Windowmanager: " $config_file | awk '{print $2}');
transfer=$(grep -E  "Transfer: " $config_file | awk '{print $2}');
distro=$(grep -E  "Distro: " $config_file | awk '{print $2}');

echo $displayserver;
echo $windowmanager;
echo $transfer;
echo $distro;

