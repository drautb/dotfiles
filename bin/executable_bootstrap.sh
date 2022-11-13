#!/usr/bin/env bash

# Script to bootstrap a new machine.

set -x

OS="$(uname -s)"

# Install homebrew if on a mac
if [ "$OS" == "Darwin" ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# brew install ....
fi

if command -v apt; then
  sudo apt install -y zsh \
    tmux \
    htop \
    vim \
    git \
    curl \
    wget
fi

if [ "$OS" == "Linux" ]; then
  chsh -s "$(command -v zsh)"
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
if [ -e ~/.zshrc.pre-oh-my-zsh ]; then
	mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
fi

# Install oh-my-zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Fix remote URL for dotfiles
~/bin/chezmoi cd && git remote set-url origin git@github.com:drautb/dotfiles.git && cd - || exit


