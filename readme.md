# Dotfiles

Ansible-managed Fedora dotfiles and system setup.

## install ansible + galaxy collections
```
make install-ansible install-roles
```

## dry-run (check mode)
```
make run-playbook
```

## apply
```
make apply-playbook
```

Apply only the backed-up GNOME keyboard shortcuts:
```
ansible-playbook -i localhost, setup.yaml --connection=local --tags gnome-keybindings
```

Roles: `common` (shell, editor, terminal dotfiles + base packages), `docker`,
`containers`, `gnome` (GNOME fallback + Nordic theme), and `sway` (primary
Nord-themed Wayland desktop with Waybar, Wofi, MPD/RMPC, KDE Connect, and
fingerprint-aware locking).

Enroll a fingerprint once with `fprintd-enroll`. The playbook enables Fedora's
PAM fingerprint feature so supported authentication prompts, including
`swaylock`, can use it.
