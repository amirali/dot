# Dotfiles

Ansible-managed GNOME dotfiles and system setup for Fedora and Arch Linux family.

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
`containers`, and `gnome` (GNOME desktop, extensions, shortcuts, and Nordic
theme).
