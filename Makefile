.PHONY: help install setup check lint test clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install dependencies (Homebrew, Ansible)
	@bash scripts/install.sh

setup: ## Run the full setup playbook
	@bash scripts/start.sh

check: ## Run Ansible playbook in check mode (dry-run)
	@ansible-playbook -i ./hosts playbook.yml --check

lint: ## Lint Ansible playbooks
	@ansible-lint playbook.yml roles/

syntax: ## Check Ansible syntax
	@ansible-playbook -i ./hosts playbook.yml --syntax-check

test: syntax lint check ## Run all tests (syntax, lint, check mode)

clean: ## Clean temporary files
	@rm -rf tmp/ .ansible/ *.retry *.log
	@echo "Cleaned temporary files"

minimal: ## Run minimal setup (apps only)
	@ansible-playbook -i ./hosts playbook.yml --tags "apps"

apps: ## Install only applications
	@ansible-playbook -i ./hosts playbook.yml --tags "apps"

config: ## Apply only configurations
	@ansible-playbook -i ./hosts playbook.yml --tags "config"

dotfiles: ## Setup only dotfiles
	@ansible-playbook -i ./hosts playbook.yml --tags "dotfiles"
