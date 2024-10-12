#!/usr/bin/env bash

set -ex

sudo rm -rfv /nix
rm -rfv \
    "${HOME}/.nix-channels" \
    "${HOME}/.nix-defexpr" \
    "${HOME}/.nix-profile" \
    "${HOME}/.local/state/nix"
