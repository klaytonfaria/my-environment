# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-01-29

### Major Overhaul 🚀

This is a complete modernization of the project with breaking changes for better architecture and maintainability.

### Added

- **Apple Silicon Support**: Full support for M1/M2/M3 Macs with automatic architecture detection
- **Backup System**: Automatic backup of existing configurations before overwriting
- **Validation**: Post-installation health checks and reporting
- **System Preferences**: Optional macOS system preferences automation
- **Modern CLI Tools**: Added ripgrep, fd, eza, delta, bat, gh, zoxide, and more
- **Python Support**: Added Python package management via pip
- **asdf Version Manager**: Replaced nvm with unified version manager
- **Uninstall Script**: Added comprehensive uninstall functionality
- **Local Overrides**: Support for user-specific configuration via local.yml
- **Makefile**: Convenient commands for common operations
- **Comprehensive Documentation**: 
  - Detailed README with examples
  - Troubleshooting guide
  - Customization guide
  - Contributing guidelines
- **CI/CD Improvements**:
  - ansible-lint validation
  - shellcheck for scripts
  - Multi-version macOS testing (12, 13, 14)
  - Proper caching strategies
- **Pre-commit Hooks**: Code quality checks before commit
- **Role Structure**: Proper Ansible role with defaults, handlers, and meta

### Changed

- **BREAKING**: Moved scripts to `scripts/` directory
- **BREAKING**: Split variables into multiple files (homebrew.yml, node.yml, python.yml, paths.yml)
- **BREAKING**: Changed variable names for clarity (applications → homebrew_packages, etc.)
- **BREAKING**: Updated oh-my-zsh repository URL to new official location
- **BREAKING**: Replaced `spectacle` with `rectangle` (deprecated)
- **BREAKING**: Changed from `state: latest` to `state: present` for stability
- Updated all Ansible syntax to FQCN (Fully Qualified Collection Names)
- Improved error handling with retries and better failure conditions
- Enhanced task naming for better readability
- Added tags for selective execution
- Improved idempotency checks
- Better documentation and inline comments

### Removed

- **BREAKING**: Removed Travis CI configuration (replaced by GitHub Actions)
- **BREAKING**: Removed hardcoded NVM installation (replaced by asdf)
- Removed `ignore_errors: True` blanket statements
- Removed deprecated packages and outdated configurations
- Removed `playbook.retry` from version control
- Removed legacy GitHub Actions workflow format

### Fixed

- Fixed iTerm2 detection path
- Fixed Homebrew path handling for Apple Silicon
- Fixed backup directory creation with timestamps
- Fixed npm and pip installation error handling
- Improved network operation reliability with retries
- Fixed symlink creation with proper force flags

### Security

- Removed `state: latest` to prevent unexpected updates
- Added better error handling instead of ignoring errors
- Improved validation of installations
- Added checksum validation for downloaded scripts
- Better permission handling

### Documentation

- Complete README rewrite with examples
- Added troubleshooting guide
- Added customization guide
- Added contributing guidelines
- Improved inline documentation
- Added architecture overview

## [1.x] - Previous Versions

### Earlier Versions

Previous versions focused on basic automation without comprehensive documentation or modern best practices. See git history for details.

---

## Upgrade Guide

### From 1.x to 2.0.0

**⚠️ Breaking Changes - Read Carefully**

1. **Backup Your Configuration**:
   ```bash
   cp ~/.zshrc ~/.zshrc.backup
   cp ~/.vimrc ~/.vimrc.backup
   ```

2. **Update Repository**:
   ```bash
   git pull origin main
   ```

3. **Review New Structure**:
   - Scripts moved to `scripts/` directory
   - Variables split into multiple files in `roles/setup/vars/`
   - Check `local.yml.example` for customization options

4. **Update Custom Configurations**:
   If you forked and customized:
   - Variable names changed (see CHANGELOG)
   - Update `vars/main.yml` references
   - Create `local.yml` for overrides

5. **Run Setup**:
   ```bash
   make setup
   ```

6. **Verify Installation**:
   ```bash
   cat ~/mac-setup/INSTALL_REPORT.txt
   ```

---

## Future Roadmap

- [ ] GUI configuration tool
- [ ] Multiple profile support (work, personal, etc.)
- [ ] Cloud sync for configurations
- [ ] Automated updates check
- [ ] Integration with dotfiles managers
- [ ] Support for additional package managers

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to contribute to this changelog.
