#!/usr/bin/env bash

NIXPKGS=(
nixpkgs.atom
nixpkgs.glibcLocales
nixpkgs.gnome.ghex
nixpkgs.ripgrep
nixpkgs.stow
)

FLATPAKS=(
com.dosbox_x.DOSBox-X
com.github.tchx84.Flatseal
org.libretro.RetroArch
org.DolphinEmu.dolphin-emu
org.flycast.Flycast
org.yuzu_emu.yuzu
)

ATOMPKGS=(
auto-dark-mode
ex-mode
vim-mode-plus
)

STOWFORCE=(
.bashrc
.config/pop-shell/config.json
.profile
)

GPG_KEY="87F211AF2BE4C2FE"

set -e

source /etc/os-release

if [ "${ID}" == "nixos" ]
then
	echo "Using NixOS, skipping rustup and Nix installation"
else
	if [ ! -f "$HOME/.cargo/env" ]
	then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
			--default-toolchain none \
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

for pkg in "${ATOMPKGS[@]}"
do
	if [ ! -d "$HOME/.atom/packages/$pkg" ]
	then
		apm install "$pkg"
	fi
done

for file in "${STOWFORCE[@]}"
do
	if [ -f "${HOME}/${file}" -a ! -L "${HOME}/${file}" ]
	then
		rm -v "${HOME}/${file}"
	fi
done
stow --no-folding --verbose files

gpg --recv-key "${GPG_KEY}"
