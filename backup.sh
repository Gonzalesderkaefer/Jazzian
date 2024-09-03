#!/bin/sh

######################## Variables ########################
backup_dir="$HOME/devicespecific_backup";


######################## DEFIING FUNCTIONS ########################

apply_backup()
{
    if ! [ -e $backup_dir ]; then
        echo "It seems you do not have created a backup yet."
        echo "Please create one."
        exit; 
    fi


    ## i3 config 
    cp -r $backup_dir/i3devicespecific $HOME/.config/i3/devicespecific 

    ## awesome config
    cp -r  $backup_dir/devicespecific.lua $HOME/.config/awesome/devicespecific.lua
    cp -r  $backup_dir/devicespecific_theme.lua $HOME/.config/awesome/devicespecific_theme.lua

    ## bspwm config
    cp -r  $backup_dir/bspwmdevicespecific $HOME/.config/bspwm/devicespecific

    ## Hyprland config
    cp -r $backup_dir/hyprdevicespecific $HOME/.config/hypr/devicespecific 

    ## sway config
    cp -r $backup_dir/swaydevicespecific $HOME/.config/sway/devicespecific 

    ## river config
    cp -r $backup_dir/riverdevicespecific $HOME/.config/river/devicespecific 

    ## nvim config
    cp -r  $backup_dir/nvimdevicespecific $HOME/.config/nvim/lua/devicespecific.lua

    ## profile
    cp -r $backup_dir/devicespecific.sh $HOME/.devicespecific.sh 

    ## shellrc
    cp -r $backup_dir/devicerc $HOME/.devicerc
}

create_backup()
{

    if [ -e $backup_dir ]; then
        mv  "$backup_dir" "$backup_dir.tmp";
    fi
    mkdir $backup_dir;

    ## Create directory
    mkdir -p $backup_dir;

    ## i3 config 
    cp -r $HOME/.config/i3/devicespecific $backup_dir/i3devicespecific

    ## awesome config
    cp -r $HOME/.config/awesome/devicespecific.lua $backup_dir/devicespecific.lua
    cp -r $HOME/.config/awesome/devicespecific_theme.lua $backup_dir/devicespecific_theme.lua

    ## bspwm config
    cp -r $HOME/.config/bspwm/devicespecific $backup_dir/bspwmdevicespecific

    ## Hyprland config
    cp -r $HOME/.config/hypr/devicespecific $backup_dir/hyprdevicespecific

    ## sway config
    cp -r $HOME/.config/sway/devicespecific $backup_dir/swaydevicespecific

    ## river config
    cp -r $HOME/.config/river/devicespecific $backup_dir/riverdevicespecific

    ## nvim config 
    cp -r $HOME/.config/nvim/lua/devicespecific.lua $backup_dir/nvimdevicespecific

    ## profile
    cp -r $HOME/.devicespecific.sh $backup_dir/devicespecific.sh

    ## shellrc
    cp -r $HOME/.devicerc $backup_dir/devicerc


    if [ -e "$backup_dir.tmp" ]; then
        rm -rf "$backup_dir.tmp";
    fi
}




######################## HERE THE SCRIPT STARTS ########################
echo "This is a backup utility for your devicespecific configurations which are stored in $backup_dir."
echo


echo "Do you want to create a backup or apply it?";
echo;
echo "[A]pply (only if you already created one!)";
echo "[C]reate (default)";

read argument;

case $argument in 
    "a"* | "A"* )
        apply_backup;
        ;;
    "c"* | "C"* )
        create_backup;
        ;;
esac

