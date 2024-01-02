#!/bin/sh


#shell configuration
echo 'exec sway' >> .profile
echo 'alias "ll"="ls -la"' >> .bashrc
echo 'alias "sn"="sudo nala"' >> ~/.bashrc 
echo 'alias "n"="nala"' >> ~/.bashrc 

#shell configuration
echo 'exec sway' >> .profile
echo 'alias "ll"="ls -la"' >> ~/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "sn"="sudo nala"' >> ~/.$(echo $SHELL | awk -F '/' '{print $3}')rc
echo 'alias "n"="nala"' >> ~/.$(echo $SHELL | awk -F '/' '{print $3}')rc
