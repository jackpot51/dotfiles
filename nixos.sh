#!/usr/bin/env bash

set -ex

NIXPKGS=(
nixos.alacritty
nixos.atom
nixos.cifs-utils
nixos.firefox
nixos.git
nixos.gnome.meld
nixos.gnupg
nixos.ibm-plex
nixos.ripgrep
nixos.stow
nixos.vimHugeX
)

nix-env --install --attr "${NIXPKGS[@]}"

ATOMPKGS=(
auto-dark-mode
ex-mode
vim-mode-plus
)

apm install "${ATOMPKGS[@]}"

if [ ! -d "${HOME}/Projects/pop" ]
then
	mkdir -p "${HOME}/Projects"
	git clone https://github.com/pop-os/pop.git "${HOME}/Projects/pop"
fi
pushd "${HOME}/Projects/pop"
	./scripts/clone cosmic
	pushd cosmic
		nix-shell \
			--packages glib.dev \
			--run "make && make install"
	popd

	./scripts/clone cosmic-workspaces
	pushd cosmic-workspaces
		nix-shell \
			--packages glib.dev \
			--run "make && make install"
	popd

	./scripts/clone gtk-theme
	pushd gtk-theme
		rm -rf build
		nix-shell \
			--packages glib.dev meson ninja sassc \
			--run "meson build --prefix=${HOME}/.local && ninja -C build install"
	popd

	./scripts/clone icon-theme
	pushd icon-theme
		rm -rf build
		nix-shell \
			--packages meson ninja \
			--run "meson build --prefix=${HOME}/.local && ninja -C build install"
	popd

	./scripts/clone launcher
	pushd launcher
		nix-shell \
			--packages cargo pkgconfig gtk3 openssl.dev \
			--run "make && make install"
	popd

	./scripts/clone shell
	pushd shell
		nix-shell \
			--packages glib.dev nodePackages.typescript \
			--run "make && make install"
	popd
popd

stow alacritty
stow atom
stow bash
#stow emulation
#stow feh
stow git
#stow gtk
#stow gnome
#stow i3
stow ion
#stow kde
stow neovim
stow scripts
#stow vifm
stow vim
#stow x

dconf load / < dconf-nixos
