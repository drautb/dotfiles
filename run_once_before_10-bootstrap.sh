#!/usr/bin/env bash

# Universal setup, runs after platform-specific setup.

set -eux

# Install oh-my-zsh in unattended mode
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  set +x
  ZSH="" sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  set -x
else
  echo "$HOME/.oh-my-zsh already exists, skipping installation."
fi

if [ -e ~/.zshrc.pre-oh-my-zsh ]; then
	mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
fi

# Install oh-my-zsh plugins
ZSH_PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"
if [ ! -d "$ZSH_PLUGIN_DIR/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGIN_DIR/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
fi

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Fix remote URL for dotfiles
pushd "$(~/bin/chezmoi source-path)" || exit
git remote set-url origin git@github.com:drautb/dotfiles.git
popd || exit

# Install Rust + utilities
if ! command -v cargo; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

function cargo_install {
  if ! command -v $1; then
    cargo install $1
  fi
}

cargo_install atuin # Shared shell history
cargo_install bat # cat replacement
cargo_install dust # du replacement
cargo_install ripgrep
cargo_install tokei
cargo_install bandwhich
cargo_install grex
