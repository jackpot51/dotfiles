#!/usr/bin/env bash

FLATPAKS=(
app.xemu.xemu
com.dosbox_x.DOSBox-X
com.github.tchx84.Flatseal
org.DolphinEmu.dolphin-emu
org.flycast.Flycast
org.yuzu_emu.yuzu
)

STOWFORCE=(
.bashrc
.config/pop-shell/config.json
.gitconfig
.profile
)

pushd files
    for file in $(find .config/cosmic -type f)
    do
        STOWFORCE+=("$file")
    done
popd

GPG_KEY="6965D85741D5160B616F7C3B670FDFB5428E05CA"

set -e

source /etc/os-release

flatpak install flathub "${FLATPAKS[@]}"

for file in "${STOWFORCE[@]}"
do
	if [ -f "${HOME}/${file}" -a ! -L "${HOME}/${file}" ]
	then
		rm -v "${HOME}/${file}"
	fi
done
stow --no-folding --verbose files

gpg --recv-key "${GPG_KEY}"
