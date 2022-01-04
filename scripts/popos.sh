#!/usr/bin/env bash

set -ex

APTPKGS=(
cifs-utils
fonts-ibm-plex
git-lfs
iotop
kpartx
kpartx-boot
nethogs
pop-desktop
software-properties-common
steam
system76-driver
vim-gtk3
)

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
