#!/bin/sh

set -ex

# Set layout if found
if [ -e "${HOME}/.screenlayout/${HOSTNAME}.sh" ]
then
    "${HOME}/.screenlayout/${HOSTNAME}.sh"
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
    compton --daemon --config "${HOME}/.config/compton.conf"
fi
