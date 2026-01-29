[![MacOS Environment Setup CI](https://github.com/klaytonfaria/my-environment/workflows/MacOS%20Environment%20Setup%20CI/badge.svg?branch=master)](https://github.com/klaytonfaria/my-environment/actions)

# MacOS Development Environment Setup

Automated setup for a complete macOS development environment using Ansible. Configure your Mac in 20-30 minutes with all your favorite tools, applications, and configurations.

## Features

- **Automated Installation**: One command to set up everything
- **Apple Silicon & Intel Support**: Works on M1/M2/M3 and Intel Macs
- **Idempotent**: Safe to run multiple times
- **Customizable**: Easy to add/remove packages
- **Backup System**: Automatically backs up existing configurations
- **Validation**: Post-install health checks and reporting
- **Modern Tools**: Includes latest CLI tools and applications

## Quick Start

### Option 1: Direct Install (Recommended)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/klaytonfaria/my-environment/HEAD/scripts/install.sh)"
```

### Option 2: Clone and Run Locally
```bash
git clone https://github.com/klaytonfaria/my-environment.git
cd my-environment
make setup
```

## Prerequisites

- macOS 12.0 (Monterey) or later
- Admin/sudo access
- Active internet connection
- At least 10GB free disk space

## What Gets Installed

<details>
<summary><strong>Homebrew Packages (CLI Tools)</strong> - Click to expand</summary>

- **Development Tools**: git, node, python3, yarn, asdf, gh (GitHub CLI)
- **Modern CLI Tools**: bat, eza, fd, ripgrep, delta, fzf, zoxide
- **Container/Cloud**: docker (via cask), kubectl, terraform, awscli
- **Utilities**: jq, tree, tmux, vim, translate-shell, tokei
- **Monitoring**: bpytop, ctop
- **And more**: See [roles/setup/vars/homebrew.yml](roles/setup/vars/homebrew.yml)

</details>

<details>
<summary><strong>GUI Applications (Casks)</strong> - Click to expand</summary>

- **Browsers**: google-chrome
- **Development**: visual-studio-code, iterm2, fork, docker, figma, insomnia
- **Productivity**: alfred, 1password, notion, obsidian, rectangle
- **Communication**: slack, discord, telegram, zoom, skype
- **Media**: spotify, pocket-casts
- **Tools**: jetbrains-toolbox, setapp
- **And more**: See [roles/setup/vars/homebrew.yml](roles/setup/vars/homebrew.yml)

</details>

<details>
<summary><strong>Global Node.js Packages</strong> - Click to expand</summary>

- typescript, eslint, prettier
- webpack-cli, lerna
- commitizen, @commitlint/cli
- nodemon, npm-check-updates
- See [roles/setup/vars/node.yml](roles/setup/vars/node.yml)

</details>

<details>
<summary><strong>Python Packages</strong> - Click to expand</summary>

- ansible-lint, pre-commit
- black, flake8, pylint
- pytest, ipython
- poetry, pipenv
- See [roles/setup/vars/python.yml](roles/setup/vars/python.yml)

</details>

<details>
<summary><strong>Shell & Development Environment</strong> - Click to expand</summary>

- **Shell**: zsh with oh-my-zsh
- **Version Manager**: asdf (replaces nvm, rbenv, etc.)
- **Dotfiles**: Custom configurations for zsh, vim, tmux
- **Plugins**: tmux plugin manager, vim plugins
- **Optional**: macOS system preferences automation

</details>

## Usage

### Basic Commands

```bash
# Full setup
make setup

# Dry-run (check what would change)
make check

# Install only applications
make apps

# Setup only dotfiles
make dotfiles

# Apply system preferences (optional)
make system

# Lint Ansible playbooks
make lint

# Run all tests
make test
```

### Running with Ansible Directly

```bash
# Full setup
ansible-playbook -i ./hosts playbook.yml

# Only install apps
ansible-playbook -i ./hosts playbook.yml --tags apps

# Skip dotfiles
ansible-playbook -i ./hosts playbook.yml --skip-tags dotfiles

# Check mode (dry-run)
ansible-playbook -i ./hosts playbook.yml --check
```

## Customization

### Method 1: Using Local Overrides (Recommended)

Create a `roles/setup/vars/local.yml` file (it's gitignored):

```yaml
---
# Override Homebrew packages
homebrew_packages:
  - git
  - node
  - docker

# Override cask applications
homebrew_casks:
  - visual-studio-code
  - google-chrome
  - slack

# Disable features
features:
  configure_system_preferences: true
  install_python_packages: false
```

### Method 2: Edit Variable Files Directly

Edit files in `roles/setup/vars/`:
- `homebrew.yml` - Homebrew packages and casks
- `node.yml` - Node.js packages
- `python.yml` - Python packages
- `paths.yml` - Directory paths

### Method 3: Fork and Customize

1. Fork this repository
2. Modify the variable files
3. Update the install URL in your fork

## System Preferences (Optional)

The playbook can optionally configure macOS system preferences:

```bash
ansible-playbook -i ./hosts playbook.yml --tags system
```

This configures:
- Dock settings (size, autohide)
- Finder preferences (show hidden files, extensions)
- Keyboard settings (fast key repeat)
- Screenshot settings (location, format)
- Trackpad settings (tap to click)

## Backup & Restore

### Automatic Backup

Before modifying dotfiles, the playbook automatically backs up existing configurations to:
```
~/.mac-setup-backup/[timestamp]/
```

### Manual Restore

```bash
# List backups
ls -la ~/.mac-setup-backup/

# Restore from specific backup
cp ~/.mac-setup-backup/[timestamp]/.zshrc ~/
```

## Uninstall

To remove installed configurations:

```bash
bash scripts/uninstall.sh
```

This will:
- Remove symlinked dotfiles
- Optionally restore from backup
- Optionally remove installed packages
- Optionally uninstall Homebrew

## Troubleshooting

### Homebrew Installation Issues

```bash
# Manually install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# For Apple Silicon, add to PATH:
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
```

### Ansible Not Found

```bash
brew install ansible
```

### Permission Errors

Some installations may require sudo access. Run:
```bash
ansible-playbook -i ./hosts playbook.yml --ask-become-pass
```

### Package Installation Fails

Some packages might fail due to:
- Already installed manually
- Architecture incompatibility
- Network issues

The playbook continues on non-critical failures. Check the installation report:
```bash
cat ~/mac-setup/INSTALL_REPORT.txt
```

### Apple Silicon Specific Issues

Ensure Homebrew is installed in the correct location:
- **Apple Silicon**: `/opt/homebrew`
- **Intel**: `/usr/local`

The scripts automatically detect and handle this.

For more troubleshooting, see [docs/TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md)

## Architecture

```
my-environment/
├── scripts/          # Installation and utility scripts
├── roles/
│   └── setup/
│       ├── defaults/ # Default variables
│       ├── handlers/ # Event handlers
│       ├── tasks/    # Ansible tasks
│       └── vars/     # Configuration variables
├── playbook.yml      # Main Ansible playbook
├── hosts             # Inventory file
└── Makefile          # Convenience commands
```

## CI/CD

The repository uses GitHub Actions to:
- Lint Ansible playbooks with ansible-lint
- Check shell scripts with shellcheck
- Test on multiple macOS versions (12, 13, 14)
- Test on both Intel and Apple Silicon

## Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests: `make test`
5. Submit a pull request

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.

## License

MIT License - see [LICENSE](LICENSE) for details

## Author

**Klayton Faria**
- GitHub: [@klaytonfaria](https://github.com/klaytonfaria)

## Acknowledgments

- [Ansible](https://www.ansible.com/) for automation framework
- [Homebrew](https://brew.sh/) for package management
- [oh-my-zsh](https://ohmyz.sh/) for zsh configuration
- Community contributors

---

**Note**: This setup takes approximately 20-30 minutes depending on your internet connection and number of packages selected. Grab a coffee and let the automation do its magic!
