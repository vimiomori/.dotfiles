# ── Powerlevel10k instant prompt (must stay at the top) ───────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Locale ────────────────────────────────────────────────────────────────────
export LC_ALL=en_US.UTF-8

# ── Dircolors ─────────────────────────────────────────────────────────────────
[[ -f ~/.dir_colors ]] && eval "$(dircolors ~/.dir_colors)"

# ── Source modular config files ───────────────────────────────────────────────
for f in path plugins aliases aws functions cgo; do
  source "$HOME/.zsh/${f}.zsh"
done

# ── Powerlevel10k theme ───────────────────────────────────────────────────────
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ── Keybindings ───────────────────────────────────────────────────────────────
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory sharehistory \
       hist_ignore_space hist_ignore_all_dups \
       hist_save_no_dups hist_ignore_dups hist_find_no_dups

# ── Tool integrations ────────────────────────────────────────────────────────
# Homebrew (install if missing)
command -v brew >/dev/null 2>&1 || {
  echo >&2 "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}
eval "$(brew shellenv)"

# OpenSSL via Homebrew
export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# nvm
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.nvm}"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
else
  echo >&2 "nvm not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh)" \
    && source "$NVM_DIR/nvm.sh" \
    && nvm install node
fi

# fnm
if [[ -d "$HOME/Library/Application Support/fnm" ]]; then
  export PATH="$HOME/Library/Application Support/fnm:$PATH"
  eval "$(fnm env)"
fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
