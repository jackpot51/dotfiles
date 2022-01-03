#!/usr/bin/env bash

set -ex

rm -f secret/gpg.asc
rm -f "secret/${HOSTNAME}.tar"

gpg --output secret/gpg.asc --export-secret-keys --armor

touch "secret/${HOSTNAME}.tar"
chmod 600 "secret/${HOSTNAME}.tar"
tar \
	--create \
	--verbose \
	--file "secret/${HOSTNAME}.tar" \
	--directory="$HOME" \
	.git-credentials \
	.ssh
