#!/usr/bin/env bash

set -ex

# Required packages
APTPKGS=(
cifs-utils
fonts-ibm-plex
git-lfs
kpartx
kpartx-boot
pop-desktop
system76-driver
)

# Applications
APTPKGS+=(
iotop
kicad
nethogs
powertop
steam
stress-ng
system76-keyboard-configurator
vim-gtk3
)

# Development tools
APTPKGS+=(
apt-file
apt-show-versions
avr-libc
avrdude
ccache
clang
cmake
devmem2
devscripts
flashrom
gnat
libgtk-3-dev
libsdl2-dev
libssl-dev
msr-tools
mtools
nasm
ppa-purge
python-is-python3
python2
sassc
sdcc
software-properties-common
)

# NVIDIA driver, if required
if [ -d /sys/module/nvidia ]
then
	APTPKGS+=(system76-driver-nvidia)
fi

LANGUAGES=(
en_US
zh_CN
)

# Mark all packages as automatically installed
sudo apt-mark auto $(apt-mark showmanual)

# Mark desired packages as manually installed
sudo apt-get install "${APTPKGS[@]}"

# Install language packages
for language in "${LANGUAGES[@]}"
do
	sudo apt-get install \
		$(check-language-support --show-installed --language="$language")
done

. scripts/common.sh

cat dconf/common dconf/popos | dconf load /
