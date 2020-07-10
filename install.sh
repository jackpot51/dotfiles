#!/bin/sh

set -x

stow alacritty
stow atom
stow bash
stow feh
stow git
stow gtk
stow gnome
stow i3
stow ion
stow kde
stow neovim
stow scripts
stow vifm
stow vim
stow x

dconf reset -f /
dconf load / < dconf
