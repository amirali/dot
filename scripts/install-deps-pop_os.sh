#!/usr/bin/env bash
set -euo pipefail
sudo apt update && sudo apt -y upgrade
sudo xargs -a "$(dirname "$0")/../deps/popos-sway-waybar-deps.txt" sudo apt -y install
