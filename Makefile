.PHONY: install-ansible install-roles run-playbook apply-playbook

install-ansible:
	@echo "Installing Ansible (detected distro)..."
	@if command -v pacman >/dev/null 2>&1; then \
		sudo pacman -S --needed --noconfirm ansible; \
	elif command -v dnf >/dev/null 2>&1; then \
		sudo dnf -y install ansible; \
	elif command -v apt >/dev/null 2>&1; then \
		sudo apt update && sudo apt -y install ansible; \
	else \
		echo "Unsupported distro; install Ansible manually."; exit 1; \
	fi

install-roles:
	@echo "Installing Ansible Galaxy collections from requirements.yaml (if present)"
	@if [ -f requirements.yaml ]; then \
		ansible-galaxy collection install -r requirements.yaml || true; \
	else \
		echo "requirements.yaml not found; skipping"; \
	fi

# run-playbook does a safe dry-run (--check)
run-playbook: install-roles
	@echo "Running ansible playbook in check (dry-run) mode"
	ansible-playbook -i localhost, setup.yaml --connection=local --check

# apply-playbook runs for real
apply-playbook: install-roles
	@echo "Running ansible playbook (real)"
	ansible-playbook -i localhost, setup.yaml --connection=local
