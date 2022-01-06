#!/usr/bin/env bash

NIXPKGS=(
nixpkgs.atom
nixpkgs.glibcLocales
nixpkgs.gnome.ghex
nixpkgs.ripgrep
nixpkgs.stow
)

ATOMPKGS=(
auto-dark-mode
ex-mode
vim-mode-plus
)

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

for pkg in "${ATOMPKGS[@]}"
do
	if [ ! -d "$HOME/.atom/packages/$pkg" ]
	then
		apm install "$pkg"
	fi
done

stow --no-folding --verbose files
