#!/bin/sh

df -H | awk '{print $3}' | sed -n 4p
