#!/usr/bin/env bash

echo "Starting the mac setup"
echo "==========================================="

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install ansible
ansible-playbook -i ./hosts playbook.yml

echo "Done!"
