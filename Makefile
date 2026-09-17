.PHONY: install-ansible install-roles run-playbook apply-playbook

install-ansible:
	@command -v dnf >/dev/null 2>&1 || { echo "Fedora with dnf is required."; exit 1; }
	sudo dnf -y install ansible

install-roles:
	@echo "Installing Ansible Galaxy collections from requirements.yaml (if present)"
	@if [ -f requirements.yaml ]; then \
		ansible-galaxy collection install -r requirements.yaml; \
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
