#!/usr/bin/env bash

set -ex

gpg --import secrets/gpg.asc
tar \
	--extract \
	--verbose \
	--file "secrets/${HOSTNAME}.tar" \
	--directory="$HOME"

rm -f secrets/gpg.asc
rm -f "secrets/${HOSTNAME}.tar"
