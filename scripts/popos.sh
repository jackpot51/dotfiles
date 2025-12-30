#!/usr/bin/env bash

set -ex

# Required packages
APTPKGS=(
cifs-utils
cosmic-session
fonts-firacode
fonts-ibm-plex
kpartx
kpartx-boot
pop-desktop
stow
system76-driver
)

# NVIDIA driver, if required
if [ -d /sys/module/nvidia ]
then
	APTPKGS+=(system76-driver-nvidia)
fi

# Applications
APTPKGS+=(
ghex
gimp
htop
inkscape
iotop
kicad
lutris
mednaffe
meld
neovim
nethogs
powertop
qemu-system-x86
ripgrep
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
d52
debhelper
devmem2
devscripts
git-lfs
gnat
just
kernel-wedge
libclang-dev
libgtk-3-dev
libgtk-4-dev
libpam-dev
libsdl2-dev
libwayland-dev
libxkbcommon-dev
msr-tools
ostree
ppa-purge
python3-pip
rust-all
sassc
sbuild
software-properties-common
syslinux-utils
systemd-container
texinfo
ubuntu-dev-tools
wl-clipboard
xorg-dev
)

# Packages for redox
APTPKGS+=(
ant
autoconf
automake
autopoint
bison
build-essential
clang
cmake
curl
dos2unix
doxygen
file
flex
fuse3
g++
genisoimage
git
gperf
intltool
libexpat-dev
libfuse-dev
libgmp-dev
libhtml-parser-perl
libjpeg-dev
libmpfr-dev
libpng-dev
libsdl1.2-dev
libsdl2-ttf-dev
libtool
llvm
lua5.4
m4
make
meson
nasm
ninja-build
patch
perl
pkg-config
po4a
protobuf-compiler
python3
python3-mako
rsync
scons
texinfo
unzip
wget
xdg-utils
xxd
zip
zstd
)

# Packages for pop-os/iso
APTPKGS+=(
debootstrap
germinate
grub-efi-amd64-signed
grub-pc-bin
isolinux
mtools
ovmf
qemu-kvm
qemu-user-static
squashfs-tools
xorriso
zsync
)

# Packages for system76/ec
APTPKGS+=(
avr-libc
avrdude
clang-format
curl
gcc
gcc-avr
libc-dev
libhidapi-dev
libudev-dev
make
sdcc
shellcheck
xxd
)

# Packages for system76/firmware-open
APTPKGS+=(
build-essential
ccache
cmake
curl
dosfstools
flashrom
git-lfs
libncurses-dev
libssl-dev
libudev-dev
mtools
parted
python-is-python3
uuid-dev
zlib1g-dev
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

cat dconf/common dconf/popos | dconf load /

. scripts/common.sh

echo "Setup complete. Reboot if this is the first time."
