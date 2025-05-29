#!/bin/bash

#! /bin/bash


####### SPEC #######
# $1: Distro


# color variables
start_green="\033[0;32m";
end_green="\033[0m ";
start_red="\033[0;31m";
end_red="\033[0m";

## checking if is run with two arguements
if [ -z $1 ]; then
    echo -e "$start_red This script expects at least one argument $end_red";
    exit 1;
fi

## If running archlinux no need to download font
if [ $1 = "archlinux" ]; then
    exit 0;
fi

command -v curl || (sudo apt install curl || sudo dnf install curl);

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz;

if ! [ -d $HOME/.local/share/fonts ]; then
    mkdir -p $HOME/.local/share/fonts;
fi
    
tar xJvf JetBrainsMono.tar.xz -C $HOME/.local/share/fonts/;
rm JetBrainsMono.tar.xz;
