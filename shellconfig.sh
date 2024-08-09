#!/bin/sh


    echo -e "\033[0;32m Do you want to [C]opy or [L]ink the files? (Default Copy) \033[0m ";
    read mov_choice; 

    case $mov_choice in
        "L"* | "l"*)
            echo You want to link;
                ### Copy bash config files to $HOME
                for sh_file in $HOME/Jazzian/cfg_files/shell/bash/*; do
                    filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
                    ln -sf $sh_file $HOME/.$filename;
                done

                ### Copy zsh config files to $HOME
                for sh_file in $HOME/Jazzian/cfg_files/shell/zsh/*; do
                    filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
                    ln -sf $sh_file $HOME/.$filename;
                done

                ### Linking scripts 
                for script in $HOME/Jazzian/bin/*; do
                    ln -sf $script $HOME/.local/bin/;
                done

                ### Config files for nnn
                mkdir -p $HOME/.config/nnn/;

                if [ -z "$(ls $HOME/.config/nnn/)" ]; then
                    ln -s "$HOME/Jazzian/cfg_files/nnn_plugins" $HOME/.config/nnn/plugins;
                fi

                ### nvim
                ln -s $HOME/Jazzian/cfg_files/nvim $HOME/.config/nvim
            ;;
        *)
            echo You want to copy;
                ### Copy bash config files to $HOME
                for sh_file in $HOME/Jazzian/cfg_files/shell/bash/*; do
                    filename="$(echo $sh_file | grep -E -oi "[^\/]*$*$")"
                    cp -f $sh_file $HOME/.$filename;
                done

                ### Copy zsh config files to $HOME
                for sh_file in $HOME/Jazzian/cfg_files/shell/zsh/*; do
                    filename="$(echo $sh_file | grep -E -oi "[^\/]*$")"
                    cp $sh_file $HOME/.$filename;
                done

                ### Copying scripts 
                for script in $HOME/Jazzian/bin/*; do
                    cp $script $HOME/.local/bin/;
                done

                ### nvim
                cp -r $HOME/Jazzian/cfg_files/nvim $HOME/.config/

                ### nnn
                mkdir -p $HOME/.config/nnn/
                ln cp -r $HOME/Jazzian/cfg_files/nnn_plugins $HOME/.config/nnn/plugins


            ;;
    esac


    ### Devicespecific files
    touch $HOME/.devicerc
    touch $HOME/.devicespecific.sh

