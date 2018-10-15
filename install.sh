#!/bin/sh

set -x

stow bash
stow feh
#stow git
stow gnome
stow i3
stow ion
stow scripts
stow x

dconf load / < dconf
