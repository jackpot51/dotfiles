#!/bin/sh

set -x

if [ ! -d /usr/share/fonts/truetype/ibm-plex/ ]
then
	sudo apt-get install fonts-ibm-plex
fi

if [ ! -f /usr/bin/stow ]
then
	sudo apt-get install stow
fi

if [ ! -f /usr/bin/vim.gtk3 ]
then
	sudo apt-get install vim-gtk3
fi

stow alacritty
stow atom
stow bash
stow emulation
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

dconf load / < dconf-pop
