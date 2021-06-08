[![Virtual environment](https://github.com/klaytonfaria/my-environment/workflows/Virtual%20environment/badge.svg?branch=master)](https://github.com/klaytonfaria/my-environment/actions)

# My MacOS setup

We can agree that it is a bit boring every time we make that picking of tools and downloads to prepare our MacOS with all tools that we love. Sometimes we spend the whole day doing that, right? But with this [Ansible](https://www.ansible.com/) playbook, I can quickly set up my MacOS environment with my favorite tools and be happy.

### Running

To start just run:
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/klaytonfaria/my-environment/HEAD/install.sh)"
```
or...

After cloning the repository, go to the folder and run:
```sh
sh ./start.sh
```

### Using Vagrant to run and test the setup in a virtual environment:
```
vagrant up --provision
```

### Running by Ansible:
☕️ 🍪 This playbook spend 20-30 min in average... Let's drink a coffee and eat a cookie.

**By Shell script:**
This [script](https://github.com/klaytonfaria/my-environment/blob/master/start.sh) install Ansible and runs the playbook.
```
sh ./start.sh
```

**By Ansible:**
(With Brew installed)
```
ansible-playbook -i ./hosts playbook.yml --verbose
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
  - moro
  - nodemon
  - npm-check-updates
  - spaceship-prompt
  - typescript


#### Homebrew Formulae

  - ack
  - apktool
  - bat
  - ccat
  - ctop
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
  - yarn
  - yarn-completion
  - zplug
  - zsh
  - zsh-completions

#### Cask applications

  - 1password
  - alfred
  - caffeine
  - discord
  - docker
  - figma
  - flutter
  - evernote
  - fork
  - grammarly
  - google-chrome
  - imageoptim
  - insomnia
  - iterm2
  - jetbrains-toolbox
  - miro
  - nmap
  - obsidian
  - pocket-casts
  - setapp
  - skype
  - slack
  - spectacle
  - spotify
  - telegram
  - ticktick
  - visual-studio-code-insiders
  - zoom

</details>
