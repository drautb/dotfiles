#!/usr/bin/env bash

if grep -q "chezmoi" "$HOME/.ssh/authorized_keys"; then
  echo "authorized_keys already contains public key."
else
  echo "Adding public key to authorized_keys"
  cat "$HOME/.ssh/id_rsa.pub" >> "$HOME/.ssh/authorized_keys"
fi
