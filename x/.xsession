#!/bin/sh

set -x

# Run xinitrc
if [ -e "${HOME}/.xinitrc" ]
then
    "${HOME}/.xinitrc"
fi

exec i3
