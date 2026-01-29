#!/usr/bin/env bash
set -e

echo "Starting Mac setup from local repository"
echo "==========================================="

# Detect architecture
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    HOMEBREW_PREFIX="/opt/homebrew"
else
    HOMEBREW_PREFIX="/usr/local"
fi

# Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

# Ensure Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "Installing Ansible..."
    brew install ansible
fi

# Run playbook from current directory
echo "Running Ansible playbook..."
ansible-playbook -i ./hosts playbook.yml "$@"

echo "Done! Please restart your terminal to apply all changes."
