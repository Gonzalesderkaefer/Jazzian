#!/bin/sh


# loading .selection into a varaible
selection="$(cat $HOME/.config/nnn/.selection | tr '\0' '\n')"

# iterate through $selection and move the files to .trash
for i in $selection
do
    mv -f $i $HOME/.trash/
done
