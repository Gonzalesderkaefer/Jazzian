#!/bin/sh

echo $1
echo $2

f=$2/$1


    case $f in
        *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar xjvf $f;;
        *.tar.gz|*.tgz) tar xzvf $f;;
        *.tar.xz|*.txz) tar xJvf $f;;
        *.zip) unzip $f;;
        *.rar) unrar x $f;;
        *.7z) 7z x $f;;
    esac

