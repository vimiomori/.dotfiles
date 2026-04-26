#!/bin/bash
set -e

DOTFILES_REPO="https://github.com/vimiomori/.dotfiles.git"
DOTFILES_SSH="git@github.com:vimiomori/.dotfiles.git"
CFG_DIR="$HOME/.cfg"
OS="$(uname -s)"

# ── Detect distro ────────────────────────────────────────────────────────────
DISTRO="unknown"
if [[ "$OS" == "Darwin" ]]; then
  DISTRO="macos"
elif [[ -f /etc/os-release ]]; then
  . /etc/os-release
  case "$ID" in
    arch|endeavouros|manjaro) DISTRO="arch" ;;
    ubuntu|debian|pop)        DISTRO="debian" ;;
    fedora)                   DISTRO="fedora" ;;
    *)                        DISTRO="$ID" ;;
  esac
fi

# ── Xcode (macOS only) ───────────────────────────────────────────────────────
if [[ "$DISTRO" == "macos" ]]; then
  echo "==> Installing Xcode command line tools"
  xcode-select --install 2>/dev/null || true
fi

# ── Package manager bootstrap ────────────────────────────────────────────────
if [[ "$DISTRO" == "arch" ]]; then
  echo "==> Syncing pacman"
  sudo pacman -Syu --noconfirm

  if ! command -v yay &>/dev/null; then
    echo "==> Installing yay (AUR helper)"
    sudo pacman -S --needed --noconfirm base-devel git
    _yay_tmp="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$_yay_tmp/yay"
    (cd "$_yay_tmp/yay" && makepkg -si --noconfirm)
    rm -rf "$_yay_tmp"
  fi
else
  echo "==> Installing Homebrew"
  if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ "$OS" == "Darwin" ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    fi
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
config remote set-url origin "$DOTFILES_SSH"

# ── Packages ──────────────────────────────────────────────────────────────────
if [[ "$DISTRO" == "arch" ]]; then
  echo "==> Installing pacman packages"
  if [[ -f "$HOME/pacman-pkgs.txt" ]]; then
    sudo pacman -S --needed --noconfirm - < "$HOME/pacman-pkgs.txt"
  fi
  echo "==> Installing AUR packages"
  if [[ -f "$HOME/aur-pkgs.txt" ]] && command -v yay &>/dev/null; then
    yay -S --needed --noconfirm - < "$HOME/aur-pkgs.txt"
  fi
else
  echo "==> Installing Brewfile packages"
  brew bundle --file="$HOME/Brewfile"

  if [[ "$DISTRO" == "macos" ]]; then
    echo "==> Installing Nerd Fonts"
    brew install $(brew search font | grep nerd | tr '\n' ' ') 2>/dev/null || true
  fi
fi

# ── Local config ──────────────────────────────────────────────────────────────
echo "==> Setting up local config files"
if [ ! -f "$HOME/.zsh/aws.zsh" ]; then
  cp "$HOME/.zsh/aws.zsh.example" "$HOME/.zsh/aws.zsh"
  echo "    Created ~/.zsh/aws.zsh from template - edit it with your credentials"
fi

# ── Terminal platform config ─────────────────────────────────────────────────
echo "==> Linking terminal platform config"
_alacritty_dir="$HOME/.config/alacritty"
if [[ -d "$_alacritty_dir" ]]; then
  if [[ "$DISTRO" == "macos" ]]; then
    ln -sf "$_alacritty_dir/os-macos.toml" "$_alacritty_dir/os.toml"
  else
    ln -sf "$_alacritty_dir/os-linux.toml" "$_alacritty_dir/os.toml"
  fi
fi
unset _alacritty_dir

# ── Repos (optional, needs SSH key) ──────────────────────────────────────────
echo "==> Cloning repos"
if command -v ghq &>/dev/null && [ -f "$HOME/repos.txt" ]; then
  bash "$HOME/clone-repos.sh" || echo "    Repo cloning failed (SSH key missing?). Run clone-repos.sh later."
fi

echo "==> Done! Open a new terminal to load your config."
echo "    Remember to edit ~/.zsh/aws.zsh with your real values."
