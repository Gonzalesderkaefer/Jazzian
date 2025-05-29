#!/usr/bin/bash

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
        "$HOME/Jazzian/cfg_files/nnn_plugins"
        "$HOME/Jazzian/cfg_files/vim"

        );

    # Copy generic config and wayland-stuff configs 
    for file in $HOME/Jazzian/cfg_files/*; do
        if ! [[ ${illegal_files[@]} =~ $file ]]; then
            cp -r -f $file $HOME/.config/;
        fi
    done

    # Config files for nnn
    mkdir -p $HOME/.config/nnn/
    cp -r $HOME/Jazzian/cfg_files/nnn_plugins $HOME/.config/nnn/plugins


    # X11 config files
    for x11_file in $HOME/Jazzian/cfg_files/X11/*; do
        cp -r -f $x11_file $HOME/.config/;
    done

    # Copy bash config files to $HOME
    for sh_file in $HOME/Jazzian/cfg_files/shell/bash/*; do
        filename="$(echo $sh_file | grep -E -oi "[^\/]*$*$")"
        cp -f $sh_file $HOME/.$filename;
    done

    # Copy zsh config files to $HOME
    for sh_file in $HOME/Jazzian/cfg_files/shell/zsh/*; do
        filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
        cp $sh_file $HOME/.$filename;
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
            "$HOME/Jazzian/cfg_files/nnn_plugins"
            "$HOME/Jazzian/cfg_files/nvim"
            "$HOME/Jazzian/cfg_files/vim"
            "$HOME/Jazzian/cfg_files/qutebrowser"
            );

    # Link general config files
    for file in $HOME/Jazzian/cfg_files/*; do
        if ! [[ ${illegal_files[@]} =~ $file ]]; then
            ln -sf $file $HOME/.config/;
        fi
    done

    # config files for nnn
    if ! [ -d $HOME/.config/nnn/plugins ];then
        ln -s "$HOME/Jazzian/cfg_files/nnn_plugins" $HOME/.config/nnn/plugins;
    fi

    # copying qutebrowser config
    if ! [ -d $HOME/.config/qutebrowser ]; then
        cp -r $HOME/Jazzian/cfg_files/qutebrowser $HOME/.config/;
    fi

    # Link X11 config files
    for x11_file in $HOME/Jazzian/cfg_files/X11/*; do
        ln -sf $x11_file $HOME/.config/;
    done

    # Copy bash config files to $HOME
    for sh_file in $HOME/Jazzian/cfg_files/shell/bash/*; do
        filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
        ln -sf $sh_file $HOME/.$filename;
    done

    # Copy zsh config files to $HOME
    for sh_file in $HOME/Jazzian/cfg_files/shell/zsh/*; do
        filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
        ln -sf $sh_file $HOME/.$filename;
    done

    # Linking scripts 
    for script in $HOME/Jazzian/bin/*; do
        ln -sf $script $HOME/.local/bin/;
    done

    # Linking vim config
    ln -s $HOME/Jazzian/cfg_files/vim $HOME/.vim
}

case $1 in 
    "link")
        link_files;
        ;;
    "copy")
        copy_files;
        ;;
esac




