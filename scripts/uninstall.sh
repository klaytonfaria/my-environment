#!/usr/bin/env bash
set -e

echo "=========================================="
echo "MacOS Environment Setup - Uninstall"
echo "=========================================="
echo ""
echo "This will remove symlinked dotfiles and optionally remove installed packages."
echo ""

# Function to prompt user
prompt_yes_no() {
    while true; do
        read -r -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Remove symlinked dotfiles
if prompt_yes_no "Remove symlinked dotfiles (.zshrc, .vimrc, .tmux.conf, etc.)?"; then
    echo "Removing dotfiles..."
    rm -f "$HOME/.zshrc" "$HOME/.vimrc" "$HOME/.tmux.conf" "$HOME/.thymerc" "$HOME/h.sh"
    echo "Dotfiles removed"
fi

# Restore from backup
LATEST_BACKUP=$(find "$HOME/.mac-setup-backup" -maxdepth 1 -type d 2>/dev/null | sort -r | head -n 2 | tail -n 1)
if [ -n "$LATEST_BACKUP" ] && [ -d "$LATEST_BACKUP" ]; then
    if prompt_yes_no "Restore configurations from backup ($LATEST_BACKUP)?"; then
        echo "Restoring from backup..."
        cp -f "$LATEST_BACKUP"/.zshrc "$HOME/.zshrc" 2>/dev/null || true
        cp -f "$LATEST_BACKUP"/.vimrc "$HOME/.vimrc" 2>/dev/null || true
        cp -f "$LATEST_BACKUP"/.tmux.conf "$HOME/.tmux.conf" 2>/dev/null || true
        echo "Configurations restored from backup"
    fi
fi

# Remove cloned repositories
if prompt_yes_no "Remove cloned repositories (oh-my-zsh, dotfiles, etc.)?"; then
    echo "Removing repositories..."
    rm -rf "$HOME/.oh-my-zsh"
    rm -rf "$HOME/.tmux/plugins/tpm"
    rm -rf "$HOME/mac-setup"
    echo "Repositories removed"
fi

# Remove asdf
if prompt_yes_no "Remove asdf version manager?"; then
    echo "Removing asdf..."
    rm -rf "$HOME/.asdf"
    echo "asdf removed"
fi

# Uninstall applications
if prompt_yes_no "Uninstall Homebrew packages? (This will remove ALL Homebrew packages)"; then
    echo "WARNING: This will uninstall all Homebrew packages!"
    if prompt_yes_no "Are you SURE you want to continue?"; then
        if command -v brew &> /dev/null; then
            echo "Uninstalling Homebrew packages..."
            brew list --formula | xargs brew uninstall --force
            brew list --cask | xargs brew uninstall --force
            echo "Homebrew packages uninstalled"
        fi
    fi
fi

# Uninstall Homebrew itself
if prompt_yes_no "Uninstall Homebrew completely?"; then
    echo "Uninstalling Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    echo "Homebrew uninstalled"
fi

# Clean up temporary files
if prompt_yes_no "Remove temporary files and backups?"; then
    echo "Cleaning up..."
    rm -rf "$HOME/.mac-setup-backup"
    rm -rf "$HOME/.mac-setup"
    echo "Cleanup complete"
fi

echo ""
echo "=========================================="
echo "Uninstall complete!"
echo "=========================================="
echo "You may want to restart your terminal."
