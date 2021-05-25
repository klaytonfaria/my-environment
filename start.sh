#!/usr/bin/env bash

echo "Starting the mac setup"
echo "==========================================="

sudo easy_install pip
python -m pip install --user ansible
ansible-playbook -i ./hosts playbook.yml

echo "Done!"
