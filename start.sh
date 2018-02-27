#!/usr/bin/env bash

echo "Starting mac setup"
echo "==========================================="

sudo easy_install pip
sudo pip install ansible ansible
ansible-playbook -i ./hosts playbook.yml --verbose

echo "Done!"

exit 0
