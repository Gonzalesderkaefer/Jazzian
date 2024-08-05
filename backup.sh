#!/bin/sh

######################## DEFIING FUNCTIONS ########################

apply_backup()
{
    if ! [ -f $HOME/devicesecific_backup ]; then
        echo "It seems you do not have created a backup yet."
        echo "Please create one."
        exit; 
    fi


    ## i3 config 
    cp -r $HOME/devicesecific_backup/i3devicespecific $HOME/.config/i3/devicespecific 

    ## awesome config
    cp -r  $HOME/devicesecific_backup/devicespecific.lua $HOME/.config/awesome/devicespecific.lua
    cp -r  $HOME/devicesecific_backup/devicespecific_theme.lua $HOME/.config/awesome/devicespecific_theme.lua

    ## bspwm config
    cp -r  $HOME/devicesecific_backup/bspwmdevicespecific $HOME/.config/bspwm/devicespecific

    ## Hyprland config
    cp -r $HOME/devicesecific_backup/hyprdevicespecific $HOME/.config/hypr/devicespecific 

    ## sway config
    cp -r $HOME/devicesecific_backup/swaydevicespecific $HOME/.config/sway/devicespecific 

    ## river config
    cp -r $HOME/devicesecific_backup/riverdevicespecific $HOME/.config/river/devicespecific 

    ## profile
    cp -r $HOME/devicesecific_backup/devicesepcific.sh $HOME/.devicespecific.sh 

    ## shellrc
    cp -r $HOME/devicesecific_backup/devicerc $HOME/.devicerc
}

create_backup()
{
    if ! [ -f $HOME/devicesecific_backup ]; then
        mkdir -p $HOME/devicesecific_backup;
    fi
    ## i3 config 
    cp -r $HOME/.config/i3/devicespecific $HOME/devicesecific_backup/i3devicespecific

    ## awesome config
    cp -r $HOME/.config/awesome/devicespecific.lua $HOME/devicesecific_backup/devicespecific.lua
    cp -r $HOME/.config/awesome/devicespecific_theme.lua $HOME/devicesecific_backup/devicespecific_theme.lua

    ## bspwm config
    cp -r $HOME/.config/bspwm/devicespecific $HOME/devicesecific_backup/bspwmdevicespecific

    ## Hyprland config
    cp -r $HOME/.config/hypr/devicespecific $HOME/devicesecific_backup/hyprdevicespecific

    ## sway config
    cp -r $HOME/.config/sway/devicespecific $HOME/devicesecific_backup/swaydevicespecific

    ## river config
    cp -r $HOME/.config/river/devicespecific $HOME/devicesecific_backup/riverdevicespecific

    ## profile
    cp -r $HOME/.devicespecific.sh $HOME/devicesecific_backup/devicesepcific.sh

    ## shellrc
    cp -r $HOME/.devicerc $HOME/devicesecific_backup/devicerc
}




######################## HERE THE SCRIPT STARTS ########################
echo "This is a backup utility for your devicesepcific configurations which are stored in $HOME/devicesecific_backup."
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

