#!/usr/bin/env bash

echo "Starting mac setup"
echo "==========================================="

sudo easy_install pip
sudo pip install ansible
ansible-playbook playbook.yml --verbose

echo "Done!"
