#!/usr/bin/env bash

set -ex

sudo steamos-readonly disable

. scripts/common.sh

echo "Setup complete. Reboot if this is the first time."
