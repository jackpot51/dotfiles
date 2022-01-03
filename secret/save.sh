#!/usr/bin/env bash

set -ex

tar \
	--create \
	--verbose \
	--file "secret/${HOSTNAME}.tar" \
	--directory="$HOME" \
	.git-credentials \
	.ssh
