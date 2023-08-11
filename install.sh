#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update os
sudo apt-get update
sudo apt-get upgrade -y

# Ensure all requirements are installed
sudo apt-get install -y git curl stow vim fish neovim

# Install starship
curl -sS https://starship.rs/install.sh | sh

# Enable dotfiles
stow fish starship

# Install fisher plugin manager
fish -c "curl -sL https://git.io/fisher | source && fisher update"

# Set fish as default shell
FISH="$(which fish)"
sudo chsh --shell "$FISH" "$USER"
