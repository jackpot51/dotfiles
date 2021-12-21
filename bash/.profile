# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# Only run if not loaded
if [ "${DOTFILES_PROFILE_LOADED}" == "1" ]
then
	return
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add cargo binaries to path if it exits
if [ -e "$HOME/.cargo/env" ] ; then
	. "$HOME/.cargo/env"
fi

# Set default editor
export EDITOR=vim

# Set debian maintainer stuff
export DEBEMAIL="jeremy@system76.com"
export DEBFULLNAME="Jeremy Soller"
export QUILT_PATCHES="debian/patches"

# Fix for alacritty scaling
export WINIT_HIDPI_FACTOR=1.0

# Set QT theme, requires qt5-style-plugins
export QT_QPA_PLATFORMTHEME=gtk2

# Start gnome-keyring-daemon if installed
if [ -x /usr/bin/gnome-keyring-daemon ]
then
    export $(/usr/bin/gnome-keyring-daemon --start)
fi

# Add nix to path if installed
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then
	. "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Mark as loaded
export DOTFILES_PROFILE_LOADED=1
