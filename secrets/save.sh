#!/usr/bin/env bash

set -ex

rm -f secrets/gpg.asc
rm -f "secrets/${HOSTNAME}.tar"

gpg --output secrets/gpg.asc --export-secret-keys --armor

touch "secrets/${HOSTNAME}.tar"
chmod 600 "secrets/${HOSTNAME}.tar"
tar \
	--create \
	--verbose \
	--file "secrets/${HOSTNAME}.tar" \
	--directory="$HOME" \
	.git-credentials \
	.ssh
