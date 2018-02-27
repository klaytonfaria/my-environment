### My mac environment setup

[Ansible](https://www.ansible.com/) playbook to quickly setup my Mac dev environment.

Running with Vagrant to test:
```
vagrant up --provision
```

Running ansible directly:
```
ansible-playbook -i ./hosts playbook.yml --verbose
```

List of applications at [here](https://raw.githubusercontent.com/klaytonfaria/my-environment/master/roles/setup/vars/main.yml). 
