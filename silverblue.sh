#!/bin/sh

set -x

if ! command -v alacritty
then
	rpm-ostree install alacritty
fi

if [ ! -d /usr/share/fonts/ibm-plex-mono-fonts/ ]
then
	rpm-ostree install ibm-plex-mono-fonts
fi

if ! command -v xprop
then
	rpm-ostree install xprop
fi

toolbox run stow bash
toolbox run stow git
toolbox run stow scripts
toolbox run stow vim

cat dconf/common dconf/silverblue | dconf load /
