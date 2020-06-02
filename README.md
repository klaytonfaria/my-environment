![Virtual environment](https://github.com/klaytonfaria/my-environment/workflows/Virtual%20environment/badge.svg?branch=master)  [![Build Status](https://travis-ci.org/klaytonfaria/my-environment.svg?branch=master)](https://travis-ci.org/klaytonfaria/my-environment)

# My MacOS setup

We can agree that it is a bit boring every time we make that picking of tools and downloads to prepare our MacOS with all tools that we love. Sometimes we spend the whole day doing that, right? But with this [Ansible](https://www.ansible.com/) playbook, I can quickly set up my MacOS environment with my favorite tools and be happy.

### Using Vagrant to run and test the setup in a virtual environment:
```
vagrant up --provision
```

### Running Ansible:
☕️ 🍪 This playbook spend 20-30 min in average... Let's drink a coffee and eat a cookie.

**By Ansible:**
```
ansible-playbook -i ./hosts playbook.yml --verbose
```


**By Shell script:**
This [script](https://github.com/klaytonfaria/my-environment/blob/master/start.sh) install Ansible and runs the playbook.
```
sh ./start.sh
```


### 📜 The list
This is the list of some of the main apps and modules that I use. But could be changed [here](https://raw.githubusercontent.com/klaytonfaria/my-environment/master/roles/setup/vars/main.yml).

<details>
  <summary>Click to expand the list.</summary>

#### Global Node modules

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


#### Homebrew Formulae

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

#### Cask applications

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

</details>
