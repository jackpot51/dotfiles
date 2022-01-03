#!/usr/bin/env bash

if [ ! -b "$1" ]
then
	echo "$0 [disk]"
	exit 1
fi
DISK="$1"

echo "Do you want to create an LVM on LUKS install on disk ${DISK} (y/N)?"
read answer
if [ "$answer" != "y" ]
then
	echo "Answered '$answer' instead of 'y'"
	exit 1
fi

set -ex

# Create partitions
parted "${DISK}" mklabel gpt
parted "${DISK}" mkpart primary fat32 0% 512MiB
parted "${DISK}" set 1 esp on
parted "${DISK}" mkpart primary 512MiB 100%

# Format LUKS partition
cryptsetup luksFormat "${DISK}p2"

# Open LUKS partition
cryptsetup luksOpen "${DISK}p2" "cryptdata"

# Create volumes
pvcreate "/dev/mapper/cryptdata"
vgcreate "data" "/dev/mapper/cryptdata"
lvcreate -n "root" -l "100%FREE" "data"

# Close LUKS partitions
cryptsetup luksClose "/dev/mapper/data-root"
cryptsetup luksClose "/dev/mapper/cryptdata"

echo "Ready to install OS on ${DISK}"
