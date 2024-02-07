#!/bin/sh

df -H | awk '{print $3}' | sed -n 2p
