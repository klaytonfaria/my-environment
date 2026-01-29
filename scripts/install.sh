#!/usr/bin/env bash
set -e

echo "╔╦╗┌─┐┌─┐  ╔═╗┌─┐┌┬┐┬ ┬┌─┐"
echo "║║║├─┤│    ╚═╗├┤  │ │ │├─┘"
echo "╩ ╩┴ ┴└─┘  ╚═╝└─┘ ┴ └─┘┴"
echo "-----------------------------------------------------------------------------------------"
echo "☕️ Starting MacOS environment setup..."
echo "-----------------------------------------------------------------------------------------"

# Detect architecture
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    echo "Detected Apple Silicon (M1/M2/M3)"
    HOMEBREW_PREFIX="/opt/homebrew"
else
    echo "Detected Intel Mac"
    HOMEBREW_PREFIX="/usr/local"
fi

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "-----------------------------------------------------------------------------------------"
    echo "Installing Homebrew..."
    echo "-----------------------------------------------------------------------------------------"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for this session
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
else
    echo "Homebrew already installed"
fi

# Check if Ansible is installed
if ! command -v ansible &> /dev/null; then
    echo "-----------------------------------------------------------------------------------------"
    echo "Installing Ansible..."
    echo "-----------------------------------------------------------------------------------------"
    brew install ansible
else
    echo "Ansible already installed"
fi

echo "-----------------------------------------------------------------------------------------"
echo "Cloning my-environment repository..."
echo "-----------------------------------------------------------------------------------------"
SETUP_DIR="$HOME/mac-setup/my-environment"
if [ -d "$SETUP_DIR" ]; then
    echo "Directory $SETUP_DIR already exists, pulling latest changes..."
    cd "$SETUP_DIR" && git pull
else
    echo "Cloning to $SETUP_DIR"
    git clone https://github.com/klaytonfaria/my-environment "$SETUP_DIR"
    cd "$SETUP_DIR" || exit
fi

echo "-----------------------------------------------------------------------------------------"
echo "Starting Mac setup... (this may take 20-30 minutes)"
echo "-----------------------------------------------------------------------------------------"
ansible-playbook -i ./hosts playbook.yml

echo "-----------------------------------------------------------------------------------------"
echo "Done! Please restart your terminal to apply all changes."
echo "-----------------------------------------------------------------------------------------"
