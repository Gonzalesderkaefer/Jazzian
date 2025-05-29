#!/bin/sh

SPEAKER_VOLUME="$(wpctl get-volume @DEFAULT_SINK@ | tr -d "[a-zA-z] \. :")";

get_output()
{
    ismuted="$(wpctl get-volume @DEFAULT_SINK@ | grep -o "MUTED")";
    volume="$(wpctl get-volume @DEFAULT_SINK@ | tr -d "[a-zA-z] \. :")";
    ([ "$(wpctl get-volume @DEFAULT_SINK@ | grep -o "MUTED")" = "MUTED" ] && echo "  󰝟   ") ||
    ([ $volume -ge 100 ]  && echo  "$volume  " )||
    ([ $volume -le 100 ] && [ $volume -ge 65 ] && echo  "$volume  " )||
    ([ $volume -le 65 ] && [ $volume -ge 35 ] && echo  "$volume  " )||
    ([ $volume -le 35 ]  && echo  "$volume  " )
}

case $BLOCK_BUTTON in
    1)
        wpctl set-mute @DEFAULT_SINK@ toggle;
        get_output;
        [ "$(wpctl get-volume @DEFAULT_SINK@ | grep -o "MUTED")" ] && (echo; echo \#FF6666) || (echo; echo \#987ae6)
        ;;
    4) 
        wpctl set-volume @DEFAULT_SINK@ 5%+;
        get_output;
        [ "$(wpctl get-volume @DEFAULT_SINK@ | grep -o "MUTED")" ] && (echo; echo \#FF6666) || (echo; echo \#987ae6)
        ;;
    5)
        wpctl set-volume @DEFAULT_SINK@ 5%-;
        get_output;
        [ "$(wpctl get-volume @DEFAULT_SINK@ | grep -o "MUTED")" ] && (echo; echo \#FF6666) || (echo; echo \#987ae6)
        ;;
    *)
        get_output;
        [ "$(wpctl get-volume @DEFAULT_SINK@ | grep -o "MUTED")" ] && (echo; echo \#FF6666) || (echo; echo \#987ae6)
        ;;
esac
# "", "", ""
