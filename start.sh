#!/usr/bin/env bash

echo "Starting the mac setup"
echo "==========================================="

sudo easy_install pip
sudo pip install ansible
ansible-playbook -i ./hosts playbook.yml

echo "Done!"
