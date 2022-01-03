#!/usr/bin/env bash

set -ex

tar \
	--extract \
	--verbose \
	--file "secret/${HOSTNAME}.tar" \
	--directory="$HOME"
