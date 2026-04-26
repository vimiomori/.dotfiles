# ── Powerlevel10k instant prompt (must stay at the top) ───────────────────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Locale ────────────────────────────────────────────────────────────────────
export LC_ALL=en_US.UTF-8

# ── Dircolors ─────────────────────────────────────────────────────────────────
if [[ -f ~/.dir_colors ]] && command -v dircolors &>/dev/null; then
  eval "$(dircolors ~/.dir_colors)"
fi

# ── Homebrew (must run before modules that depend on HOMEBREW_PREFIX) ─────────
if command -v brew &>/dev/null; then
  eval "$(brew shellenv)"
  export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"
fi

# ── Source modular config files ───────────────────────────────────────────────
for f in path plugins aliases functions cgo; do
  [[ -f "$HOME/.zsh/${f}.zsh" ]] && source "$HOME/.zsh/${f}.zsh"
done
# aws.zsh is optional (gitignored, contains credentials)
[[ -f "$HOME/.zsh/aws.zsh" ]] && source "$HOME/.zsh/aws.zsh"

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

# ── direnv ────────────────────────────────────────────────────────────────────
command -v direnv &>/dev/null && eval "$(direnv hook zsh)"

# ── nvm ───────────────────────────────────────────────────────────────────────
export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.nvm}"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
fi

# ── fnm ───────────────────────────────────────────────────────────────────────
_fnm_dir=""
if [[ -d "$HOME/Library/Application Support/fnm" ]]; then
  _fnm_dir="$HOME/Library/Application Support/fnm"
elif [[ -d "$HOME/.local/share/fnm" ]]; then
  _fnm_dir="$HOME/.local/share/fnm"
fi
if [[ -n "$_fnm_dir" ]]; then
  export PATH="$_fnm_dir:$PATH"
  eval "$(fnm env)"
fi
unset _fnm_dir

# ── pnpm ──────────────────────────────────────────────────────────────────────
if [[ "$OSTYPE" == darwin* ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
