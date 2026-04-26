# ── Bash login shell ─────────────────────────────────────────────────────────
# Keep this minimal. Primary shell config lives in ~/.zshrc.

if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
  . "$HOME/.bashrc"
fi

PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Cargo
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"
