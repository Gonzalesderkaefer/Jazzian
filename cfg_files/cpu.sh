#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "Be ROOT!"
	exit 1 
fi


cpupower frequency-set -g powersave -d 0.4G -u 1.0G

