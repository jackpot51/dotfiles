#!/bin/sh

set -x

stow alacritty
stow bash
stow feh
stow git
stow gtk
stow gnome
stow i3
stow ion
stow neovim
stow scripts
stow vim
stow x

dconf load / < dconf
