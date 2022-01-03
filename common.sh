#!/usr/bin/env bash

NIXPKGS=(
nixpkgs.atom
nixpkgs.glibcLocales
nixpkgs.gnome.meld
nixpkgs.ripgrep
nixpkgs.stow
)

ATOMPKGS=(
auto-dark-mode
ex-mode
vim-mode-plus
)

set -e

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

for pkg in "${ATOMPKGS[@]}"
do
	if [ ! -d "$HOME/.atom/packages/$pkg" ]
	then
		apm install "$pkg"
	fi
done

stow --verbose files
