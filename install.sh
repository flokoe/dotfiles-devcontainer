#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update os
sudo apt-get update
sudo apt-get upgrade -y

# Ensure all requirements are installed
sudo apt-get install -y git curl stow vim fish neovim kitty

# Enable automatic pre-commit hooks
# git config --global init.templateDir ~/.git-template
# pre-commit init-templatedir ~/.git-template

# Install starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Enable dotfiles
stow fish starship

# Install fisher plugin manager
fish -c "curl -sL https://git.io/fisher | source && fisher update"

# Set fish as default shell
FISH="$(which fish)"
CURRENT_USER="$(whoami)"

sudo chsh --shell "$FISH" "$CURRENT_USER"

exit 0
