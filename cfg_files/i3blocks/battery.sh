#!/bin/sh

BAT_PERCENTAGE="$(acpi | grep -E -o "[0-9]%|[0-9][0-9]%|[0-9][0-9][0-9]%")"
BAT_STATUS="$(acpi | grep -E -o "Discharging|Charging")"
BAT_TIME="$(acpi | grep -E -o "[0-9][0-9]:[0-5][0-9]")"


get_level()
{
    level="$(acpi | grep -E -o "[0-9]%|[0-9][0-9]%|[0-9][0-9][0-9]%" | tr -d "%")"
    ([ $level -lt 100 ] && [ $level -ge 90 ] && echo  "$BAT_PERCENTAGE  ")|| 
    ([ $level -lt 90 ] && [ $level -ge 65 ] && echo   "$BAT_PERCENTAGE  ")|| 
    ([ $level -lt  65 ] && [ $level -ge 40 ] && echo  "$BAT_PERCENTAGE  ")|| 
    ([ $level -lt  40 ] && [ $level -ge 20 ] && echo  "$BAT_PERCENTAGE  ")|| 
    ([ $level -lt  40 ] && [ $level -ge 20 ] && echo  "$BAT_PERCENTAGE  ")|| 
    ([ $level -le  20 ] && echo  "$level  ")
}

case $BLOCK_BUTTON in
    1)
        echo $BAT_TIME
        ;;
    *)
        case $BAT_STATUS in 
            "Discharging") 
                get_level
                ;;
            "Charging")
                echo "$BAT_PERCENTAGE  "
                ;;
            *)
        esac
        ;;

esac
