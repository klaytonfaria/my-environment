#!/bin/bash

echo "==========================================="
echo "Setting up your mac using daemonza/setupmac"
echo "==========================================="

sudo easy_install pip
sudo easy_install ansible
ansible-playbook -i ./hosts playbook.yml --verbose

echo "and we are done! Enjoy!"

exit 0