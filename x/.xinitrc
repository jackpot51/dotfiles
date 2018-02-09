#!/bin/sh

set -ex

# Set layout if found
if [ -e "${HOME}/.screenlayout/$(hostname).sh" ]
then
    "${HOME}/.screenlayout/$(hostname).sh"
fi

# Load keyboard mapping
if [ -e "${HOME}/.Xmodmap" ]
then
    xmodmap "${HOME}/.Xmodmap"
fi

# Randomize background
if [ -e "${HOME}/.fehbg" ]
then
    "${HOME}/.fehbg"
fi

if [ -n "$(which compton)" -a -e "${HOME}/.config/compton.conf" ]
then
    nohup compton --config "${HOME}/.config/compton.conf" &
fi
