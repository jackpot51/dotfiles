#!/bin/sh

set -ex

# Run xinitrc
if [ -e "${HOME}/.xinitrc" ]
then
    "${HOME}/.xinitrc"
fi

exec i3
