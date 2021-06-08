#!/usr/bin/env bash
printf "╔╦╗┌─┐┌─┐  ╔═╗┌─┐┌┬┐┬ ┬┌─┐"
printf "║║║├─┤│    ╚═╗├┤  │ │ │├─┘"
printf "╩ ╩┴ ┴└─┘  ╚═╝└─┘ ┴ └─┘┴"
printf "-----------------------------------------------------------------------------------------\n\n"
printf "☕️ 🍪️ Starting...️"
printf "-----------------------------------------------------------------------------------------"
printf "Install Homebrew"
printf "-----------------------------------------------------------------------------------------"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
printf "-----------------------------------------------------------------------------------------"
printf "Install Ansible"
printf "-----------------------------------------------------------------------------------------"
brew install ansible
printf "-----------------------------------------------------------------------------------------"
printf "Clone my-environment repository"
printf "-----------------------------------------------------------------------------------------"
printf "using $HOME/mac-setup/my-environment"
git clone https://github.com/klaytonfaria/my-environment "$HOME"/mac-setup/my-environment
cd "$HOME"/mac-setup/my-environment || exit
printf "-----------------------------------------------------------------------------------------"
printf "Starting Mac setup..."
printf "-----------------------------------------------------------------------------------------"
ansible-playbook -i ./hosts playbook.yml
printf "-----------------------------------------------------------------------------------------\n"
printf "🥳 Done!"
