#!/bin/sh

df -H | awk '{print $4 "/" $2}' | sed -n 4p
