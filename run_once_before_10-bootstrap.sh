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

# Install tmux plugin manager
TMUX_PLUGIN_DIR="$HOME/.tmux/plugins"
if [ ! -d "$TMUX_PLUGIN_DIR/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
fi

# Fix remote URL for dotfiles
pushd "$(~/bin/chezmoi source-path)" || exit
git remote set-url origin git@github.com:drautb/dotfiles.git
popd || exit

# Install Rust + utilities if there is sufficient memory
function cargo_install {
  pkg="$1"
  desc="$2"
  cmd="${3:-$pkg}"
  if ! command -v "$cmd"; then
    read -r -p "Install '$pkg' ($cmd - $desc)? "
    echo
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      cargo install "$pkg"
    fi
  fi
}

if [ "$(uname -s)" == "Linux" ] && [ "$(awk '/^MemTotal:/{print $2}' /proc/meminfo)" -lt "3500000" ]; then
  echo "Not enough memory to install rust, atuin and other rust utilities will not be available"
else
  if ! command -v cargo; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi

  cargo_install atuin "Shared shell history"
  cargo_install bat "cat replacement with syntax highlighting and git integration"
  cargo_install du-dust "du replacement" dust
  cargo_install ripgrep "Faster grep" rg
  cargo_install tokei "stats about source code"
  cargo_install bandwhich "Determine which processes are hogging bandwidth"
  cargo_install grex "Generate a regular expression from target examples"
  cargo_install fd-find "find replacement" fd
fi
