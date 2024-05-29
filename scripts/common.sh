#!/usr/bin/env bash

NIXPKGS=()

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

GPG_KEY="EF25594D4777F2365A526ED7D02FD439211AF56F"

set -e

source /etc/os-release

if [ "${ID}" == "nixos" ]
then
	echo "Using NixOS, skipping rustup and Nix installation"
else
	if [ ! -f "$HOME/.cargo/env" ]
	then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
			--default-toolchain stable \
			--no-modify-path \
			-y
	fi
	. "$HOME/.cargo/env"

	if [ ! -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]
	then
		curl -L https://nixos.org/nix/install | sh -s -- \
			--no-daemon \
			--no-modify-profile
	fi
	. "$HOME/.nix-profile/etc/profile.d/nix.sh"
	export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"

	nix-env --install --attr "${NIXPKGS[@]}"
fi

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
