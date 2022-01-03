#!/usr/bin/env bash

set -ex

gpg --import secret/gpg.asc
tar \
	--extract \
	--verbose \
	--file "secret/${HOSTNAME}.tar" \
	--directory="$HOME"

rm -f secret/gpg.asc
rm -f "secret/${HOSTNAME}.tar"
