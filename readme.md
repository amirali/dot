# Dotfiles

Ansible-managed dotfiles and system setup for Fedora, Pop!_OS/Debian, Arch and macOS.

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

Roles: `common` (shell, editor, terminal dotfiles + base packages), `docker`,
`containers`, `gnome` (GNOME desktop + Nordic theme), `niri` (niri compositor +
waybar + ghostty, Nord-themed).
