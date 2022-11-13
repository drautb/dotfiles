#!/usr/bin/env bash

# Universal setup, runs after platform-specific setup.

set -eux

# Install oh-my-zsh in unattended mode
set +x
ZSH="" sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
set -x

if [ -e ~/.zshrc.pre-oh-my-zsh ]; then
	mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
fi

# Install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Fix remote URL for dotfiles
pushd "$(~/bin/chezmoi source-path)" || exit
git remote set-url origin git@github.com:drautb/dotfiles.git
popd || exit

