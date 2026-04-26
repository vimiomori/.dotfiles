#!/bin/bash
set -e

DOTFILES_REPO="git@github.com:vimiomori/.dotfiles.git"
CFG_DIR="$HOME/.cfg"
OS="$(uname -s)"

# ── Xcode (macOS only) ───────────────────────────────────────────────────────
if [[ "$OS" == "Darwin" ]]; then
  echo "==> Installing Xcode command line tools"
  xcode-select --install 2>/dev/null || true
fi

# ── Homebrew ──────────────────────────────────────────────────────────────────
echo "==> Installing Homebrew"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ "$OS" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
fi

# ── Dotfiles bare repo ───────────────────────────────────────────────────────
echo "==> Cloning dotfiles bare repo"
if [ -d "$CFG_DIR" ]; then
  echo "    $CFG_DIR already exists, skipping clone"
else
  git clone --bare "$DOTFILES_REPO" "$CFG_DIR"
fi

config() {
  command git --git-dir="$CFG_DIR" --work-tree="$HOME" "$@"
}

echo "==> Checking out dotfiles"
if ! config checkout 2>/dev/null; then
  echo "    Backing up conflicting files to ~/.dotfiles-backup"
  mkdir -p "$HOME/.dotfiles-backup"
  config checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | while read -r f; do
    mkdir -p "$HOME/.dotfiles-backup/$(dirname "$f")"
    mv "$HOME/$f" "$HOME/.dotfiles-backup/$f"
  done
  config checkout
fi

config config --local status.showUntrackedFiles no

# ── Packages ──────────────────────────────────────────────────────────────────
echo "==> Installing Brewfile packages"
brew bundle --file="$HOME/Brewfile"

if [[ "$OS" == "Darwin" ]]; then
  echo "==> Installing Nerd Fonts"
  brew install $(brew search font | grep nerd | tr '\n' ' ') 2>/dev/null || true
fi

# ── Local config ──────────────────────────────────────────────────────────────
echo "==> Setting up local config files"
if [ ! -f "$HOME/.zsh/aws.zsh" ]; then
  cp "$HOME/.zsh/aws.zsh.example" "$HOME/.zsh/aws.zsh"
  echo "    Created ~/.zsh/aws.zsh from template - edit it with your credentials"
fi

# ── Repos ─────────────────────────────────────────────────────────────────────
echo "==> Cloning repos"
if command -v ghq &>/dev/null && [ -f "$HOME/repos.txt" ]; then
  bash "$HOME/clone-repos.sh"
fi

echo "==> Done! Open a new terminal to load your config."
echo "    Remember to edit ~/.zsh/aws.zsh with your real values."
