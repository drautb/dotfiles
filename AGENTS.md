# Agents

Guidelines for AI agents working on this dotfiles repo.

## Config file validation

When editing config files (TOML, YAML, JSON), always verify that the output parses correctly. Common pitfalls:

- **Escape sequences**: Don't embed raw control characters (e.g., literal ESC bytes). Use the format's proper escape syntax (e.g., `\x1b` in TOML, `\e` in YAML).
- **Template rendering**: After editing a `.tmpl` file, run `chezmoi cat <target-path>` to verify the rendered output is valid.
- **Format migrations**: When converting between formats (e.g., YAML to TOML), verify the new file parses — field names, nesting, and escape rules differ between formats.

## Chezmoi conventions

See `CLAUDE.md` for full guidelines. Key points:

- Prefer runtime existence checks over chezmoi template conditionals
- No private keys or secrets in this repo
- Use `$HOME` instead of hardcoded absolute paths
- `run_once_before_*` for one-time bootstrap; `run_after_*` for idempotent per-apply tasks

## Expected `chezmoi status` output

The following scripts are `run_after_*` (not `run_once_after_*`) by design, so `chezmoi status` will always report them as `R` (needs re-run). This is normal — they execute on every apply and have no "done" state to track:

- `40-install-vim-plugins.sh`
- `41-install-tmux-plugins.sh`

Do not treat these `R` entries as drift or attempt to "fix" them.
