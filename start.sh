#!/usr/bin/env bash

echo "Starting the mac setup"
echo "==========================================="

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py --user
python -m pip install --user ansible
ansible-playbook -i ./hosts playbook.yml

echo "Done!"
