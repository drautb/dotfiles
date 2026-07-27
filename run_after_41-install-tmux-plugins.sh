#!/usr/bin/env bash

if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
  echo "Installing and updating tmux plugins..."
  "$HOME/.tmux/plugins/tpm/bin/install_plugins"
  "$HOME/.tmux/plugins/tpm/bin/update_plugins" all
fi
