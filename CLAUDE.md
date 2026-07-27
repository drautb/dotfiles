# Dotfiles (chezmoi)

This repo manages dotfiles across multiple machines using [chezmoi](https://www.chezmoi.io/).

## Machines

- **Work dev desktops**: Amazon Linux 2023 (`osid = "linux-amzn"`)
- **Work laptop**: macOS (`osid = "darwin"`)
- **Personal laptop**: macOS (`osid = "darwin"`)
- **Raspberry Pi's**: Debian-based Linux (`osid = "linux-debian"` or similar)

There is no `is_work` flag — work vs personal is not distinguished in chezmoi data.

## Guidelines

### Prefer runtime guards over chezmoi templates

Do NOT use chezmoi template conditionals (`{{ if ... }}`) to gate features by OS or machine type. Instead, use shell runtime checks that key off the presence of the actual target:

```bash
# Good: check if the tool/directory exists
if command -v brazil-build > /dev/null 2>&1; then
  alias bb=brazil-build
fi

if [ -d "$HOME/.toolbox/bin" ]; then
  export PATH="$HOME/.toolbox/bin:$PATH"
fi

# Bad: gate by OS
{{ if eq .osid "linux-amzn" }}
alias bb=brazil-build
{{ end }}
```

Only use chezmoi templates when the content itself differs per machine (e.g., font sizes, email addresses).

### No credentials or private keys

Do not store private keys, tokens, passwords, or other secrets in this repo. Public keys are fine.

### Avoid hardcoded paths

Use `$HOME` instead of `/home/drautb` or `/local/home/drautb` in shell configs. When a path is truly machine-specific (like the gordian-knot LD_LIBRARY_PATH), guard it with a runtime existence check.

### Avoid duplication

Check for duplicate PATH entries or redundant config before adding new lines. Several tools (AIM CLI, toolbox, etc.) tend to append lines on install — consolidate them.

### run_once vs run_after scripts

- `run_once_before_*` — bootstrap/setup that only needs to happen once per machine (installing packages, cloning repos)
- `run_after_*` — idempotent tasks that should run on every `chezmoi apply` (plugin installs/updates)

### Alacritty

Config lives at `~/.config/alacritty/alacritty.toml` (TOML format, not the legacy YAML).

### tmux

Uses TPM (tmux plugin manager). Plugins are auto-installed via `run_after_41-install-tmux-plugins.sh`.
