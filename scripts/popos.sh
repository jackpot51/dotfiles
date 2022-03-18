#!/usr/bin/env bash

set -ex

# Required packages
APTPKGS=(
cifs-utils
fonts-ibm-plex
kpartx
kpartx-boot
pop-desktop
system76-driver
)

# NVIDIA driver, if required
if [ -d /sys/module/nvidia ]
then
	APTPKGS+=(system76-driver-nvidia)
fi

# Applications
APTPKGS+=(
gimp
inkscape
iotop
kicad
lutris
mednafe
meld
nethogs
powertop
qemu-system-x86
scdaemon
steam
stress-ng
system76-keyboard-configurator
tio
transmission-gtk
vim-gtk3
virt-manager
yubikey-manager
)

# Keep zoom if it is installed
if dpkg-query -s zoom &> /dev/null
then
	APTPKGS+=(zoom)
fi

# Development tools
APTPKGS+=(
apt-file
apt-show-versions
automake
autopoint
avr-libc
avrdude
ccache
clang
cmake
d52
debhelper
debootstrap
devmem2
devscripts
flashrom
genisoimage
git-lfs
gnat
gperf
kernel-wedge
libfuse-dev
libgmp-dev
libgtk-3-dev
libgtk-4-dev
libhidapi-dev
libsdl2-dev
libssl-dev
msr-tools
mtools
nasm
ostree
po4a
ppa-purge
python-is-python3
python2
sassc
sbuild
sdcc
software-properties-common
syslinux-utils
systemd-container
texinfo
ubuntu-dev-tools
)

LANGUAGES=(
en_US
zh_CN
)

# Mark all packages as automatically installed
manual="$(apt-mark showmanual)"
if [ -n "${manual}" ]
then
	sudo apt-mark auto $manual
fi

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

echo "Setup complete. Reboot if this is the first time."
