# Troubleshooting Guide

## Common Issues and Solutions

### Installation Issues

#### Homebrew Installation Fails

**Problem**: Homebrew installation script fails or hangs

**Solutions**:
1. Check your internet connection
2. Ensure you have Xcode Command Line Tools:
   ```bash
   xcode-select --install
   ```
3. Manually install Homebrew:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
4. For Apple Silicon, ensure Homebrew is added to PATH:
   ```bash
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
   source ~/.zshrc
   ```

#### Ansible Command Not Found

**Problem**: `ansible-playbook: command not found`

**Solutions**:
1. Install Ansible via Homebrew:
   ```bash
   brew install ansible
   ```
2. Ensure Homebrew bin is in your PATH:
   ```bash
   echo $PATH | grep homebrew
   ```
3. If not, add to your shell config:
   ```bash
   # For Apple Silicon
   eval "$(/opt/homebrew/bin/brew shellenv)"
   
   # For Intel
   eval "$(/usr/local/bin/brew shellenv)"
   ```

#### Permission Denied Errors

**Problem**: Permission denied when creating directories or symlinking files

**Solutions**:
1. Ensure you have write permissions to your home directory:
   ```bash
   ls -la ~ | grep $(whoami)
   ```
2. Run with become (sudo) for system-level changes:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --ask-become-pass
   ```
3. Fix home directory permissions:
   ```bash
   sudo chown -R $(whoami):staff ~
   ```

### Package Installation Issues

#### Cask Already Installed

**Problem**: `Error: Cask 'app-name' is already installed`

**Solution**: This is expected if you manually installed apps. The playbook will skip them. Not an error.

#### Package Not Found

**Problem**: `Error: No available formula with the name "package-name"`

**Solutions**:
1. Update Homebrew:
   ```bash
   brew update
   ```
2. Search for the correct package name:
   ```bash
   brew search package-name
   ```
3. Remove the package from your configuration if no longer available

#### Installation Hangs

**Problem**: Installation hangs on a specific package

**Solutions**:
1. Press Ctrl+C and try again
2. Skip the problematic package temporarily:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --skip-tags apps
   ```
3. Install the problematic package manually:
   ```bash
   brew install package-name
   ```

### Git and Repository Issues

#### Cannot Clone Repository

**Problem**: `fatal: unable to access repository`

**Solutions**:
1. Check SSH keys are set up:
   ```bash
   ssh -T git@github.com
   ```
2. Use HTTPS instead of SSH in `roles/setup/vars/paths.yml`
3. Check internet connection and GitHub status

#### Dotfiles Repository Not Found

**Problem**: Cannot clone dotfiles repository

**Solutions**:
1. Fork and update the repository URL in `roles/setup/vars/paths.yml`
2. Create your own dotfiles repository
3. Skip dotfiles setup:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --skip-tags dotfiles
   ```

### Node.js and npm Issues

#### npm Packages Fail to Install

**Problem**: Global npm packages fail to install

**Solutions**:
1. Ensure Node.js is installed:
   ```bash
   node --version
   ```
2. Fix npm permissions:
   ```bash
   mkdir -p ~/.npm-global
   npm config set prefix '~/.npm-global'
   echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
   ```
3. Clear npm cache:
   ```bash
   npm cache clean --force
   ```

#### Node Version Issues

**Problem**: Wrong Node.js version installed

**Solutions**:
1. Use asdf to manage Node versions:
   ```bash
   asdf install nodejs lts
   asdf global nodejs lts
   ```
2. Update version in `roles/setup/vars/node.yml`

### Python Issues

#### pip Installation Fails

**Problem**: Python packages fail to install with pip

**Solutions**:
1. Ensure Python3 is installed:
   ```bash
   python3 --version
   ```
2. Upgrade pip:
   ```bash
   python3 -m pip install --upgrade pip
   ```
3. Use virtual environment:
   ```bash
   python3 -m venv ~/venv
   source ~/venv/bin/activate
   ```

### Shell Configuration Issues

#### Zsh Not Default Shell

**Problem**: Terminal still using bash after setup

**Solutions**:
1. Set zsh as default shell:
   ```bash
   chsh -s $(which zsh)
   ```
2. Restart your terminal
3. If it persists, set in Terminal.app preferences

#### Configuration Not Loading

**Problem**: `.zshrc` changes not taking effect

**Solutions**:
1. Restart your terminal
2. Manually source the file:
   ```bash
   source ~/.zshrc
   ```
3. Check for syntax errors:
   ```bash
   zsh -n ~/.zshrc
   ```

#### oh-my-zsh Installation Failed

**Problem**: oh-my-zsh not installed properly

**Solutions**:
1. Remove and reinstall:
   ```bash
   rm -rf ~/.oh-my-zsh
   git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
   ```
2. Check symlink:
   ```bash
   ls -la ~/.zshrc
   ```

### Apple Silicon Specific Issues

#### Rosetta 2 Required

**Problem**: Some packages require Rosetta 2 on Apple Silicon

**Solutions**:
1. Install Rosetta 2:
   ```bash
   softwareupdate --install-rosetta --agree-to-license
   ```

#### Wrong Homebrew Path

**Problem**: Packages installed but not found in PATH

**Solutions**:
1. Verify Homebrew location:
   ```bash
   which brew
   ```
2. Should be `/opt/homebrew/bin/brew` on Apple Silicon
3. Add to PATH:
   ```bash
   echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
   source ~/.zshrc
   ```

### Ansible-Specific Issues

#### Ansible-lint Errors

**Problem**: Linting fails with errors

**Solutions**:
1. Install ansible-lint:
   ```bash
   pip3 install ansible-lint
   ```
2. Check specific errors and fix syntax
3. Skip linting temporarily if needed

#### Tasks Fail Silently

**Problem**: Tasks marked as changed but nothing happens

**Solutions**:
1. Run in verbose mode:
   ```bash
   ansible-playbook -i ./hosts playbook.yml -vvv
   ```
2. Check task output for actual errors
3. Run in check mode to see what would change:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --check --diff
   ```

## Getting More Help

### Check Installation Report

After running the playbook, check the installation report:
```bash
cat ~/mac-setup/INSTALL_REPORT.txt
```

### Run in Verbose Mode

For detailed output:
```bash
ansible-playbook -i ./hosts playbook.yml -vvv
```

### Check Logs

Look for Ansible logs in:
```bash
cat ~/.ansible/ansible.log
```

### Validation

Run the validation tasks manually:
```bash
ansible-playbook -i ./hosts playbook.yml --tags validate
```

### Community Support

- Open an issue: [GitHub Issues](https://github.com/klaytonfaria/my-environment/issues)
- Check existing issues for solutions
- Contribute fixes via pull requests

## Prevention

### Before Running Setup

1. **Backup important files**:
   ```bash
   cp ~/.zshrc ~/.zshrc.backup
   cp ~/.vimrc ~/.vimrc.backup
   ```

2. **Run in check mode first**:
   ```bash
   make check
   ```

3. **Review what will be installed**:
   - Check `roles/setup/vars/*.yml` files
   - Customize as needed

### During Setup

1. Monitor the output for errors
2. Don't interrupt the process unless critical
3. Note any warnings or failures

### After Setup

1. Review installation report
2. Test critical tools:
   ```bash
   git --version
   node --version
   python3 --version
   ```
3. Restart terminal to apply all changes
