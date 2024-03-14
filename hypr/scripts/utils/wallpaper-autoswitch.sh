#!/usr/bin/env sh

# Change wallpaper at random interval

ScrDir=`dirname "$(realpath "$0")"`

# This controls (in seconds) when to switch to the next image
INTERVAL=1800

while true; do
    $ScrDir/wallpaper-switch.sh -n
    sleep $INTERVAL
done

