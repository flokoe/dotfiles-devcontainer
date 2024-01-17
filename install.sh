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

# Enable dotfiles for the following packages
PACKAGES=(fish starship)

# Remove existing default configs so stow does not fail
for p in "${PACKAGES[@]}"; do
    # Get list of all files within packages
    files="$(find "$p" -mindepth 1)"

    # Remove leading package name from all files
    files="${files//${p}\//}"

    # Replace dot- syntax with actual dot in file path
    files="${files//dot-/.}"

    for f in $files; do
        # Construct full file path
        f="${HOME}/${f}"

        if [[ $f == *"$p"* ]]; then
            # Remove existing config
            echo "Remove the following path: ${f}"
            rm -rf "$f"

            break
        fi
    done
done

# Link dotfiles aka install packages via stow
stow "${PACKAGES[@]}"

# Install fisher plugin manager
fish -c "curl -sL https://git.io/fisher | source && fisher update"

# Set fish as default shell
FISH="$(which fish)"
CURRENT_USER="$(whoami)"

sudo chsh --shell "$FISH" "$CURRENT_USER"

exit 0
