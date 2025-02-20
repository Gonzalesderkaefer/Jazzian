#!/bin/sh
f=$2/

nohup alacritty --working-directory "$f" &
sleep 2;
rm nohup.out
