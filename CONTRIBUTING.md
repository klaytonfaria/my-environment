# Contributing to MacOS Environment Setup

First off, thank you for considering contributing to this project! It's people like you that make this tool better for everyone.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Pull Request Process](#pull-request-process)
- [Style Guidelines](#style-guidelines)
- [Testing](#testing)

## Code of Conduct

### Our Standards

- Be respectful and inclusive
- Accept constructive criticism gracefully
- Focus on what is best for the community
- Show empathy towards other community members

### Our Responsibilities

Project maintainers are responsible for clarifying standards and are expected to take appropriate action in response to any unacceptable behavior.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues as you might find out that you don't need to create one. When you are creating a bug report, please include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples**
- **Describe the behavior you observed and what you expected**
- **Include system information**:
  - macOS version
  - Architecture (Intel or Apple Silicon)
  - Output from `sw_vers` command

**Example Bug Report**:
```markdown
**Title**: Installation fails on macOS 14 with Apple Silicon

**Description**: 
When running the install script, Homebrew installation fails with error...

**Steps to Reproduce**:
1. Run `bash scripts/install.sh`
2. See error at step...

**Expected**: Installation should complete successfully

**Actual**: Error message: ...

**System Info**:
- macOS: 14.0 (Sonoma)
- Arch: arm64 (Apple Silicon M2)
```

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion, please include:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List some examples of how it would be used**

### Adding New Packages

Want to add a new tool or application? Great!

1. Determine which category:
   - Homebrew formula → `roles/setup/vars/homebrew.yml` (homebrew_packages)
   - GUI application → `roles/setup/vars/homebrew.yml` (homebrew_casks)
   - Node package → `roles/setup/vars/node.yml`
   - Python package → `roles/setup/vars/python.yml`

2. Add to the appropriate list:
   ```yaml
   homebrew_packages:
     - existing-package
     - your-new-package  # Add comment explaining what it does
   ```

3. Test that it installs correctly:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --tags apps --check
   ```

4. Submit a pull request with explanation of what the package does

### Improving Documentation

Documentation improvements are always welcome!

- Fix typos or clarify existing documentation
- Add examples
- Improve explanations
- Add missing documentation

## Development Setup

### Prerequisites

- macOS 12.0 or later
- Git
- Text editor

### Setting Up Development Environment

1. **Fork the repository** on GitHub

2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR-USERNAME/my-environment.git
   cd my-environment
   ```

3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/klaytonfaria/my-environment.git
   ```

4. **Install development dependencies**:
   ```bash
   brew install ansible ansible-lint shellcheck pre-commit
   ```

5. **Install pre-commit hooks**:
   ```bash
   pre-commit install
   ```

### Making Changes

1. **Create a branch**:
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make your changes**

3. **Test your changes**:
   ```bash
   # Syntax check
   make syntax
   
   # Lint
   make lint
   
   # Dry run
   make check
   ```

4. **Commit your changes**:
   ```bash
   git add .
   git commit -m "feat: add awesome feature"
   ```

## Pull Request Process

### Before Submitting

1. **Update documentation** if you changed functionality
2. **Run all tests**:
   ```bash
   make test
   ```
3. **Ensure pre-commit hooks pass**
4. **Update CHANGELOG.md** with your changes

### Submitting

1. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Open a Pull Request** on GitHub

3. **Fill out the PR template**:
   ```markdown
   ## Description
   Brief description of what this PR does
   
   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Documentation update
   - [ ] Refactoring
   
   ## Testing
   Describe how you tested this
   
   ## Checklist
   - [ ] Tests pass
   - [ ] Linting passes
   - [ ] Documentation updated
   - [ ] CHANGELOG.md updated
   ```

4. **Wait for review** - maintainers will review and provide feedback

### After Submitting

- Respond to review comments
- Make requested changes
- Push additional commits to the same branch
- Request re-review when ready

## Style Guidelines

### Ansible Style

1. **Use FQCN** (Fully Qualified Collection Names):
   ```yaml
   # Good
   - name: Create directory
     ansible.builtin.file:
       path: /path/to/dir
       state: directory
   
   # Bad
   - name: Create directory
     file:
       path: /path/to/dir
       state: directory
   ```

2. **Task naming**:
   ```yaml
   # Good - descriptive and specific
   - name: Install Homebrew packages for development
   
   # Bad - vague
   - name: Install stuff
   ```

3. **Use tags** for organization:
   ```yaml
   - name: Install applications
     tags: [apps, install]
     ansible.builtin.include_tasks: apps.yml
   ```

4. **Error handling**:
   ```yaml
   # Good - specific error handling
   register: result
   failed_when: result.rc != 0 and 'expected error' not in result.stderr
   
   # Bad - blanket ignore
   ignore_errors: true
   ```

5. **Idempotency**: Tasks should be safe to run multiple times

### YAML Style

- Use 2 spaces for indentation
- Use `---` at start of file
- Use `key: value` format (space after colon)
- Quote strings with special characters
- Use lists for arrays:
  ```yaml
  packages:
    - package1
    - package2
  ```

### Shell Script Style

- Use `#!/usr/bin/env bash` shebang
- Use `set -e` for error handling
- Quote variables: `"$variable"`
- Use meaningful variable names
- Add comments for complex logic
- Make scripts shellcheck compliant

### Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

**Examples**:
```
feat(apps): add support for kubectl

Add kubectl to the list of Homebrew packages for Kubernetes development.

Closes #123
```

```
fix(dotfiles): correct iTerm2 detection path

The previous path check was incorrect for recent iTerm2 versions.
Now checks /Applications/iTerm.app instead.
```

## Testing

### Manual Testing

1. **Syntax check**:
   ```bash
   ansible-playbook playbook.yml --syntax-check
   ```

2. **Dry run (check mode)**:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --check --diff
   ```

3. **Run specific tags**:
   ```bash
   ansible-playbook -i ./hosts playbook.yml --tags apps --check
   ```

4. **Verbose mode** for debugging:
   ```bash
   ansible-playbook -i ./hosts playbook.yml -vvv
   ```

### Automated Testing

Tests run automatically on pull requests via GitHub Actions:

- Ansible linting
- Shell script linting
- Syntax checking
- Multi-version macOS testing

### Testing Locally

Run the full test suite:
```bash
make test
```

Individual checks:
```bash
make syntax  # Syntax check
make lint    # Ansible lint
make check   # Dry run
```

## Review Process

1. **Automated checks** must pass
2. **Maintainer review** - at least one approval required
3. **Address feedback** - make requested changes
4. **Merge** - maintainer will merge when ready

## Recognition

Contributors will be recognized in:
- README.md acknowledgments section
- GitHub contributors page
- Release notes for significant contributions

## Questions?

- Open an issue for questions
- Tag issues with `question` label
- Check existing issues and documentation first

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to making MacOS setup automation better for everyone! 🎉
