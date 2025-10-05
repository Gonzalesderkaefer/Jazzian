#!/bin/sh

SPEAKER_VOLUME="$(wpctl get-volume @DEFAULT_SINK@ | tr -d "[a-zA-z] \. :")";

get_output()
{
    ismuted="$(wpctl get-volume @DEFAULT_SINK@ | grep -o "MUTED")"
    volume="$(wpctl get-volume @DEFAULT_SINK@ | tr -d "[a-zA-z] \. :")"
    ([ "$(wpctl get-volume @DEFAULT_SINK@ | grep -o "MUTED")" = "MUTED" ] && echo "    󰝟 ") ||
    ([ $volume -ge 100 ]  && echo  "$volume  " )||
    ([ $volume -le 100 ] && [ $volume -ge 65 ] && echo  "$volume  " )||
    ([ $volume -le 65 ] && [ $volume -ge 35 ] && echo  "$volume  " )||
    ([ $volume -le 35 ]  && echo  "$volume  " )
}

get_output;

# case $1 in
#     1)
#         wpctl set-mute @DEFAULT_SINK@ toggle
#         get_output
#         ;;
#     2) 
#         wpctl set-volume @DEFAULT_SINK@ 5%+
#         get_output
#         ;;
#     3)
#         wpctl set-volume @DEFAULT_SINK@ 5%-
#         get_output
#         ;;
#     *)
#         get_output
#         ;;
# esac

