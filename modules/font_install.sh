#!/bin/bash


curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz


if ! [ -d $HOME/.local/share/fonts ]; then
    mkdir -p $HOME/.local/share/fonts;
fi
    
tar xJvf JetBrainsMono.tar.xz -C $HOME/.local/share/fonts/;
rm JetBrainsMono.tar.xz;
