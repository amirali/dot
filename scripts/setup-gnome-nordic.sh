#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Copy Ghostty config from repo to user config
if [ -f "$REPO_ROOT/roles/common/files/dotfiles/.config/ghostty/config" ]; then
  mkdir -p "$HOME/.config/ghostty"
  cp -a "$REPO_ROOT/roles/common/files/dotfiles/.config/ghostty/"* "$HOME/.config/ghostty/"
  echo "Ghostty config copied to $HOME/.config/ghostty"
else
  echo "No ghostty config found in repo; skipping copy"
fi

# Set GTK/Shell theme to Nordic (user must have theme installed)
echo "Applying Nordic theme gsettings (no package install)."
if command -v gsettings >/dev/null 2>&1; then
  gsettings set org.gnome.desktop.interface gtk-theme "Nordic" || true
  gsettings set org.gnome.desktop.interface icon-theme "Papirus" || true
  # enable User Themes extension if installed
  gsettings set org.gnome.shell.extensions.user-theme name "Nordic" 2>/dev/null || true
else
  echo "gsettings not available; skipping theme settings"
fi

# Add custom keybinding Ctrl+Alt+T -> ghostty
BIND_NAME="custom-ghostty"
BIND_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$BIND_NAME/"

# read current list
current=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings || "[]")
# ensure path format
cb_path="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$BIND_NAME/"
if ! echo "$current" | grep -q "$cb_path"; then
  # append to list
  new=$(echo "$current" | sed "s/]$/, '$cb_path']/; t; s/\[\]/['$cb_path']/")
  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new" || true
fi
# set the keybinding values
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$BIND_PATH name "Ghostty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$BIND_PATH command "ghostty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$BIND_PATH binding "<Control><Alt>t"

echo "Custom keybinding Ctrl+Alt+T -> ghostty set."

# Try to install common GNOME extensions for tactile, GSConnect and clipboard indicator
# Use distro package manager if available, else attempt to enable existing extensions
install_exts() {
  if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm gsconnect gnome-shell-extension-clipboard gnome-shell-extension-tactile || true
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf -y install gsconnect gnome-extensions-app gnome-shell-extension-clipboard gnome-shell-extension-user-theme || true
  elif command -v apt >/dev/null 2>&1; then
    sudo apt -y install gsconnect gnome-shell-extensions || true
  else
    echo "No known package manager; skip automatic extension install."
  fi
}

install_exts || true

# Enable extensions if present in ~/.local/share/gnome-shell/extensions
EXTS=("tactile@github.com" "gsconnect@andyholmes.github.io" "clipboard-indicator@tudmotu.com")
for ex in "${EXTS[@]}"; do
  if [ -d "$HOME/.local/share/gnome-shell/extensions/$ex" ] || [ -d "/usr/share/gnome-shell/extensions/$ex" ]; then
    if command -v gnome-extensions >/dev/null 2>&1; then
      gnome-extensions enable "$ex" || true
      echo "Enabled extension $ex"
    fi
  else
    echo "Extension $ex not found locally; you may need to install it from https://extensions.gnome.org/"
  fi
done

# If any extensions were installed or enabled, restart shell (gnome-shell restart for X11; on Wayland recommend logout)
if command -v gnome-extensions >/dev/null 2>&1; then
  echo "Reloading GNOME Shell extensions"
  # try to restart gnome-shell if possible
  if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    echo "Restarting gnome-shell (X11)"
    busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s "'Main.reloadExtensions()'" || true
  else
    echo "Wayland session detected; please log out and back in to apply shell extension changes."
  fi
fi

echo "GNOME Nordic vibe setup complete."
