![Virtual environment](https://github.com/klaytonfaria/my-environment/workflows/Virtual%20environment/badge.svg?branch=master)  [![Build Status](https://travis-ci.org/klaytonfaria/my-environment.svg?branch=master)](https://travis-ci.org/klaytonfaria/my-environment)

### Mac environment setup

[Ansible](https://www.ansible.com/) playbook to quickly setup my Mac dev environment.

Running with Vagrant to test:
```
vagrant up --provision
```

Running ansible directly:
```
ansible-playbook -i ./hosts playbook.yml --verbose
```

List of applications can be updated [here](https://raw.githubusercontent.com/klaytonfaria/my-environment/master/roles/setup/vars/main.yml).

### homebrew applications

  - ack
  - apktool
  - ccat
  - ccat
  - cmatrix
  - fzf
  - git
  - gti
  - highlight
  - jq
  - node
  - pidcat
  - pngquant
  - python3
  - reattach-to-user-namespace
  - tmux
  - tokei
  - translate-shell
  - tree
  - vim
  - watchman
  - zplug
  - zsh
  - zsh-completions

### Global node modules

  - vtop
  - webpack
  - chance-cli
  - chance
  - eslint
  - commitizen
  - gnomon
  - lerna
  - nodemon
  - react-native
  - react-native-cli
  - spaceship-prompt
  - typescript

### homebrew cask applications

  - 1password
  - alfred
  - android-studio
  - caffeine
  - charles
  - discord
  - docker
  - evernote
  - fork
  - frappe
  - gitx
  - grammarly
  - google-chrome
  - imageoptim
  - insomnia
  - iterm2
  - nmap
  - numi
  - react-native-debugger
  - rowanj-gitx
  - skype
  - slack
  - spectacle
  - spectrum
  - spotify
  - telegram
  - ticktick
  - visual-studio-code-insiders
  - xmind-zen
