#!/bin/bash
# Dotfiles install script for Bcomerfo/dotfiles
# Creates symlinks from ~/dotfiles into your home directory.
# Safe to re-run any time; existing files/links at the target locations are overwritten.

set -e

DOTFILES="$HOME/dotfiles"
mkdir -p ~/.config

echo "Linking dotfiles from $DOTFILES ..."

# --- Shell ---
[ -f "$DOTFILES/shell/.bashrc" ] && ln -sf "$DOTFILES/shell/.bashrc" ~/.bashrc
[ -f "$DOTFILES/shell/.zshrc" ] && ln -sf "$DOTFILES/shell/.zshrc" ~/.zshrc
[ -f "$DOTFILES/shell/.profile" ] && ln -sf "$DOTFILES/shell/.profile" ~/.profile

# --- Git ---
[ -f "$DOTFILES/git/.gitconfig" ] && ln -sf "$DOTFILES/git/.gitconfig" ~/.gitconfig

# --- Kitty ---
if [ -f "$DOTFILES/kitty/.config/kitty/kitty.conf" ]; then
  mkdir -p ~/.config/kitty
  ln -sf "$DOTFILES/kitty/.config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
fi

# --- Neovim ---
# Note: in this repo, nvim/.config/ IS the nvim config folder itself
# (contains init.lua, lua/, etc. directly) — it maps straight to ~/.config/nvim
if [ -d ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
  echo "Backing up existing ~/.config/nvim to ~/.config/nvim.bak"
  mv ~/.config/nvim ~/.config/nvim.bak
fi
ln -sfn "$DOTFILES/nvim/.config" ~/.config/nvim

# --- Tmux ---
[ -f "$DOTFILES/tmux/.tmux.conf" ] && ln -sf "$DOTFILES/tmux/.tmux.conf" ~/.tmux.conf

# --- VS Code ---
if [ -f "$DOTFILES/vscode/settings.json" ]; then
  mkdir -p ~/.config/Code/User
  ln -sf "$DOTFILES/vscode/settings.json" ~/.config/Code/User/settings.json
fi
[ -f "$DOTFILES/vscode/keybindings.json" ] && ln -sf "$DOTFILES/vscode/keybindings.json" ~/.config/Code/User/keybindings.json

echo "Done. Restart your shell (or run 'source ~/.bashrc') to pick up changes."
