#!/usr/bin/env bash
set -euo pipefail
sudo pacman -Syu --noconfirm
xargs -a "$(dirname "$0")/../deps/arch-sway-waybar-deps.txt" sudo pacman -S --needed --noconfirm
