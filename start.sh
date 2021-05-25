#!/usr/bin/env bash

echo "Starting the mac setup"
echo "==========================================="

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
sudo python3 get-pip.py --user
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install --user ansible paramiko
ansible-playbook -i ./hosts playbook.yml

echo "Done!"
