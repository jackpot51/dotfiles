#!/usr/bin/env bash

set -ex

if [ ! -d /usr/share/fonts/truetype/ibm-plex/ ]
then
	sudo apt-get install fonts-ibm-plex
fi

if [ ! -f /usr/bin/vim.gtk3 ]
then
	sudo apt-get install vim-gtk3
fi

. scripts/common.sh

cat dconf/common dconf/popos | dconf load /
