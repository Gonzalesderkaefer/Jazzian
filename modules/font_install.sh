#!/bin/bash

####### SPEC #######
# $1: Distro

# color variables
start_green="\033[0;32m"  
end_green="\033[0m "
start_red="\033[0;31m"
end_red="\033[0m"


## checking if is run with two arguements
if [ -z $1 ]; then
    echo -e "$start_red This script expects at least two arguments $end_red";
    exit 1;
fi


if ! [ $1="archlinux" ]; then
    echo -e "$start_green Going to download Jetbrains Mono Nerd Font from: $end_green";
    echo "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz";

    curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz

    if ! [ -d $HOME/.local/share/fonts ]; then
        mkdir -p $HOME/.local/share/fonts
    fi

    mv JetBrainsMono.tar.xz $HOME/.local/share/fonts/;

    tar xJvf $HOME/.local/share/fonts/JetBrainsMono.tar.xz -C $HOME/.local/share/fonts/
fi




