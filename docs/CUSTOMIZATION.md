# Customization Guide

This guide explains how to customize the MacOS environment setup to fit your needs.

## Table of Contents

1. [Quick Customization](#quick-customization)
2. [Variable Files](#variable-files)
3. [Adding/Removing Packages](#addingremoving-packages)
4. [Custom Dotfiles](#custom-dotfiles)
5. [System Preferences](#system-preferences)
6. [Advanced Customization](#advanced-customization)

## Quick Customization

### Using Local Overrides (Recommended)

The easiest way to customize without modifying tracked files:

1. Copy the example file:
   ```bash
   cp roles/setup/vars/local.yml.example roles/setup/vars/local.yml
   ```

2. Edit `roles/setup/vars/local.yml`:
   ```yaml
   ---
   # Your custom packages
   homebrew_packages:
     - git
     - docker
     - node
   
   homebrew_casks:
     - visual-studio-code
     - google-chrome
   ```

3. Run the setup:
   ```bash
   make setup
   ```

**Note**: `local.yml` is gitignored and won't be committed.

## Variable Files

Configuration is split into logical files in `roles/setup/vars/`:

### `homebrew.yml`

Controls Homebrew packages and casks:

```yaml
---
homebrew_packages:
  - git
  - node
  - python3
  # Add your packages here

homebrew_casks:
  - visual-studio-code
  - google-chrome
  # Add your applications here
```

### `node.yml`

Node.js configuration and global packages:

```yaml
---
node_packages:
  - typescript
  - eslint
  - prettier
  # Add your npm packages here

node_version: "lts"  # or specific version like "20.10.0"
```

### `python.yml`

Python packages and configuration:

```yaml
---
python_packages:
  - ansible-lint
  - black
  - pytest
  # Add your pip packages here

python_version: "3.11"  # or "latest"
```

### `paths.yml`

Directory paths and repository URLs:

```yaml
---
general:
  local_home: "{{ lookup('env','HOME') }}"
  setup_dir: "{{ lookup('env','HOME') }}/mac-setup"
  backup_dir: "{{ lookup('env','HOME') }}/.mac-setup-backup"

repositories:
  dotfiles: "https://github.com/YOUR-USERNAME/dotfiles.git"
  # Update with your repos
```

## Adding/Removing Packages

### Add a Homebrew Package

1. Edit `roles/setup/vars/homebrew.yml`
2. Add to `homebrew_packages` list:
   ```yaml
   homebrew_packages:
     - git
     - neovim  # New package
   ```
3. Run: `make apps`

### Add a Cask Application

1. Search for the cask name:
   ```bash
   brew search app-name
   ```
2. Add to `homebrew_casks` in `homebrew.yml`:
   ```yaml
   homebrew_casks:
     - visual-studio-code
     - notion  # New application
   ```
3. Run: `make apps`

### Remove a Package

Simply remove the line from the appropriate variable file and run the playbook again. Note: This won't uninstall existing packages, only prevents future installation.

To actually uninstall:
```bash
brew uninstall package-name
brew uninstall --cask application-name
```

### Add Global npm Package

Edit `roles/setup/vars/node.yml`:
```yaml
node_packages:
  - typescript
  - your-package-name
```

### Add Python Package

Edit `roles/setup/vars/python.yml`:
```yaml
python_packages:
  - pytest
  - your-package-name
```

## Custom Dotfiles

### Using Your Own Dotfiles Repository

1. Create or fork a dotfiles repository
2. Update `roles/setup/vars/paths.yml`:
   ```yaml
   repositories:
     dotfiles: "https://github.com/YOUR-USERNAME/your-dotfiles.git"
   ```
3. Ensure your dotfiles structure matches:
   ```
   dotfiles/
   ├── zsh/.zshrc
   ├── vim/.vimrc
   ├── tmux/.tmux.conf
   └── thyme/.thymerc
   ```

### Customize Dotfile Paths

Edit `roles/setup/tasks/dotfiles.yml` to change symlink sources:

```yaml
- name: Create symlink for zsh configuration
  ansible.builtin.file:
    src: "{{ general.setup_dir }}/dotfiles/custom/path/.zshrc"
    dest: "{{ general.local_home }}/.zshrc"
    state: link
    force: true
```

### Add Additional Dotfiles

Add new tasks to `roles/setup/tasks/dotfiles.yml`:

```yaml
- name: Create symlink for custom config
  ansible.builtin.file:
    src: "{{ general.setup_dir }}/dotfiles/path/to/.customrc"
    dest: "{{ general.local_home }}/.customrc"
    state: link
    force: true
```

## System Preferences

### Enable System Preferences Configuration

By default, system preferences automation is disabled. To enable:

1. Edit `roles/setup/defaults/main.yml`:
   ```yaml
   features:
     configure_system_preferences: true
   ```

2. Or use local overrides in `local.yml`:
   ```yaml
   features:
     configure_system_preferences: true
   ```

3. Run with system tag:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --tags system
   ```

### Customize System Preferences

Edit `roles/setup/tasks/system-preferences.yml`:

```yaml
# Change Dock size
- name: Set Dock icon size
  community.general.osx_defaults:
    domain: com.apple.dock
    key: tilesize
    type: int
    value: 64  # Change this value
  notify: restart dock
```

### Add New System Preferences

```yaml
# Example: Disable Dashboard
- name: Disable Dashboard
  community.general.osx_defaults:
    domain: com.apple.dashboard
    key: mcx-disabled
    type: bool
    value: true
```

Find available defaults:
```bash
# List all defaults for a domain
defaults read com.apple.dock

# Search for specific setting
defaults find keyword
```

## Advanced Customization

### Feature Flags

Control which components get installed via `roles/setup/defaults/main.yml`:

```yaml
features:
  install_apps: true
  install_node_modules: true
  install_python_packages: true
  setup_dotfiles: true
  setup_configuration: true
  configure_system_preferences: false
```

### Installation Behavior

Control how installations behave:

```yaml
install_behavior:
  state: present  # or 'latest' to always upgrade
  allow_upgrade: false  # Set true to upgrade existing
  ignore_errors: false  # Set true for non-critical failures
  create_backup: true  # Backup before overwriting
```

### Conditional Installation

Install packages only on specific conditions:

```yaml
# In a custom task file
- name: Install package only on Apple Silicon
  community.general.homebrew:
    name: package-name
    state: present
  when: ansible_machine == "arm64"

- name: Install package only on Intel
  community.general.homebrew:
    name: package-name
    state: present
  when: ansible_machine == "x86_64"
```

### Custom Tasks

Add your own task files:

1. Create `roles/setup/tasks/custom.yml`:
   ```yaml
   ---
   - name: Your custom task
     ansible.builtin.debug:
       msg: "Running custom tasks"
   ```

2. Include in `roles/setup/tasks/main.yml`:
   ```yaml
   - name: Custom tasks
     tags: [custom]
     ansible.builtin.include_tasks: custom.yml
   ```

3. Run with tag:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --tags custom
   ```

### Environment-Specific Configuration

Create different configurations for work/personal:

1. Create `roles/setup/vars/work.yml`:
   ```yaml
   ---
   homebrew_packages:
     - docker
     - kubectl
     - aws-cli
   ```

2. Load conditionally in `roles/setup/tasks/main.yml`:
   ```yaml
   - name: Load work configuration
     ansible.builtin.include_vars: work.yml
     when: setup_profile == "work"
   ```

3. Run with extra vars:
   ```bash
   ansible-playbook -i ./hosts playbook.yml -e "setup_profile=work"
   ```

### Version Pinning

Pin specific versions for reproducibility:

```yaml
# In homebrew.yml
homebrew_packages:
  - name: node
    version: "20.10.0"
  - name: python
    version: "3.11.5"
```

### Custom Validation

Add custom validation checks to `roles/setup/tasks/validation.yml`:

```yaml
- name: Check custom requirement
  ansible.builtin.command: your-command --version
  register: result
  changed_when: false
  failed_when: result.rc != 0
```

## Testing Your Customizations

### Check Mode (Dry Run)

Test without making changes:
```bash
make check
# or
ansible-playbook -i ./hosts playbook.yml --check --diff
```

### Run Specific Tags

Test individual components:
```bash
# Test only apps
ansible-playbook -i ./hosts playbook.yml --tags apps --check

# Test only dotfiles
ansible-playbook -i ./hosts playbook.yml --tags dotfiles --check
```

### Verbose Output

Debug your customizations:
```bash
ansible-playbook -i ./hosts playbook.yml -vvv
```

## Best Practices

1. **Use Local Overrides**: Keep your changes in `local.yml` for easy updates
2. **Test First**: Always run in check mode before applying
3. **Backup**: Keep backups of important configurations
4. **Version Control**: Track your customizations in a fork
5. **Incremental Changes**: Test one change at a time
6. **Document**: Comment your customizations for future reference

## Examples

### Minimal Setup

`local.yml` for minimal installation:
```yaml
---
homebrew_packages:
  - git
  - vim
  - tmux

homebrew_casks:
  - iterm2
  - visual-studio-code

features:
  install_node_modules: false
  install_python_packages: false
  configure_system_preferences: false
```

### Full Stack Developer Setup

```yaml
---
homebrew_packages:
  - git
  - node
  - python3
  - docker
  - kubectl
  - postgresql
  - redis

homebrew_casks:
  - visual-studio-code
  - docker
  - postman
  - iterm2
  - tableplus

node_packages:
  - typescript
  - @nestjs/cli
  - prisma
  - eslint
```

### Data Science Setup

```yaml
---
homebrew_packages:
  - python3
  - jupyter
  - r

homebrew_casks:
  - rstudio
  - visual-studio-code
  - tableau

python_packages:
  - numpy
  - pandas
  - scikit-learn
  - matplotlib
  - jupyter
```

## Getting Help

- Review existing configurations in `roles/setup/vars/`
- Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
- Open an issue on GitHub
- Refer to [Ansible documentation](https://docs.ansible.com/)
