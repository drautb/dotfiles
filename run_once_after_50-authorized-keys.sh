#!/usr/bin/env bash
set -euo pipefail

authorized="$HOME/.ssh/authorized_keys"
touch "$authorized"
chmod 600 "$authorized"

for pub in "$HOME/.ssh/id_rsa.pub" "$HOME/.ssh/id_ecdsa.pub" "$HOME/.ssh/id_ed25519.pub"; do
  [ -f "$pub" ] || continue
  key_body=$(awk '{print $2}' "$pub")
  if grep -qF "$key_body" "$authorized"; then
    echo "authorized_keys already contains $(basename "$pub")"
  else
    echo "Appending $(basename "$pub") to authorized_keys"
    cat "$pub" >> "$authorized"
  fi
done
