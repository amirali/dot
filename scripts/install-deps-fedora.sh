#!/usr/bin/env bash
set -euo pipefail
sudo dnf -y update
sudo xargs -a "$(dirname "$0")/../deps/fedora-sway-waybar-deps.txt" dnf -y install
