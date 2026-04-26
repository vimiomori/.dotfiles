# ── Zinit plugin manager ──────────────────────────────────────────────────────
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -d "$ZINIT_HOME" ]]; then
  print -P "%F{33}Installing %F{220}Zinit%f..."
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" \
    && print -P "%F{34}Done.%f" \
    || print -P "%F{160}Clone failed.%f"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Annexes
zinit light-mode for \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-bin-gem-node \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-rust

# Prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Syntax, completions, suggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# OMZ snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Autosuggestion styling
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,italic"

# Completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Menu-complete cycling (tab / shift-tab)
zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete

# fzf shell integration (history search, file finder, cd)
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh 2>/dev/null)" || {
    # Fallback for older fzf without --zsh
    [[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
    [[ -f /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
  }
fi
