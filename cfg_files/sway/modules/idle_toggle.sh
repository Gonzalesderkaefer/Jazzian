#!/bin/sh


start_idle()
{
    swayidle -w \
    timeout 300 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
    timeout 600 'swaylock -f -c 000000' \
    before-sleep 'swaylock -f -c 000000' &
}


[ -z "$(pgrep swayidle)" ] && start_idle  || pkill swayidle

pkill -SIGRTMIN+4 i3blocks

