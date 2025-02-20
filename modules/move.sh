#!/bin/bash

####### SPEC #######
# $1: Transfer 

# color variables
start_green="\033[0;32m"  
end_green="\033[0m "
start_red="\033[0;31m"
end_red="\033[0m"

copy_files()
{
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.config

    echo -e "$start_green Going to copy some config files from $HOME/Jazzian/cfg_files to $HOME/.config $end_green";

    # Don't copy these files
    declare -a illegal_files=(
        "$HOME/Jazzian/cfg_files/X11" 
        "$HOME/Jazzian/cfg_files/passgen" 
        "$HOME/Jazzian/cfg_files/shell"
        "$HOME/Jazzian/cfg_files/vim"
        "$HOME/Jazzian/cfg_files/vifm"
        "$HOME/Jazzian/cfg_files/code"

        );

    # Copy generic config and wayland-stuff configs 
    for file in $HOME/Jazzian/cfg_files/*; do
        if ! [[ ${illegal_files[@]} =~ $file ]]; then
            cp -r -f $file $HOME/.config/;
        fi
    done

    # Copy shell config files to $HOME
    shell_path=$HOME/Jazzian/cfg_files/shell
    for sh_file in $(ls $shell_path); do
        cp "$shell_path/$sh_file" "$HOME/.$sh_file";
    done



    # Copying vim config
    if ! [ -d $HOME/.vim ]; then
        cp -r $HOME/Jazzian/cfg_files/vim $HOME/.vim;
    fi

    echo -e "$start_green copying scripts from $HOME/Jazzian/bin to $HOME/.local/bin $end_green";
    # Copying scripts 
    for script in $HOME/Jazzian/bin/*; do
        cp $script $HOME/.local/bin/;
    done
}


link_files()
{
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.config

    echo -e  "$start_green Going to copy some config files from $HOME/Jazzian/cfg_files to $HOME/.config $end_green";
    # Don't copy these files
    declare -a illegal_files=(
            "$HOME/Jazzian/cfg_files/X11" 
            "$HOME/Jazzian/cfg_files/passgen" 
            "$HOME/Jazzian/cfg_files/shell"
            "$HOME/Jazzian/cfg_files/nvim"
            "$HOME/Jazzian/cfg_files/vim"
            "$HOME/Jazzian/cfg_files/qutebrowser"
            "$HOME/Jazzian/cfg_files/code"
            );

    # Link general config files
    for file in $HOME/Jazzian/cfg_files/*; do
        if ! [[ ${illegal_files[@]} =~ $file ]]; then
            ln -sf $file $HOME/.config/;
        fi
    done

    # copying qutebrowser config
    if ! [ -d $HOME/.config/qutebrowser ]; then
        cp -r $HOME/Jazzian/cfg_files/qutebrowser $HOME/.config/;
    fi

    # Link shell config files to $HOME
    shell_path=$HOME/Jazzian/cfg_files/shell
    for sh_file in $(ls $shell_path); do
        ln -sf "$shell_path/$sh_file" "$HOME/.$sh_file";
    done



    # Linking scripts 
    for script in $HOME/Jazzian/bin/*; do
        ln -sf $script $HOME/.local/bin/;
    done

    # Linking vim config
    if ! [ -e $HOME/.vim ]; then
        ln -sf $HOME/Jazzian/cfg_files/vim $HOME/.vim
    fi
}

case $1 in 
    "link")
        link_files;
        ;;
    "copy")
        copy_files;
        ;;
esac




