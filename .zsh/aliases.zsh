# ── General ───────────────────────────────────────────────────────────────────
alias vim='nvim'
alias c='clear'
alias python='python3'
alias pip='pip3'

# ── Directories ──────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ── eza (ls replacement) ─────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza --icons --group-directories-first -la'
  alias lt='eza --icons --group-directories-first --tree --level=2'
  alias lta='eza --icons --group-directories-first --tree --level=2 -a'
else
  alias ls='ls --color'
  alias ll='ls -la'
fi

# ── bat (cat replacement) ────────────────────────────────────────────────────
command -v bat &>/dev/null && alias cat='bat --paging=never'

# ── fzf ──────────────────────────────────────────────────────────────────────
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='${EDITOR:-nvim} "$(ff)"'

# ── Git ───────────────────────────────────────────────────────────────────────
alias gc='git commit'
alias gac='git commit -a'
alias gp='git push'
alias commit='git add . && git commit'
alias gignore='git update-index --assume-unchanged'
alias pb='git fetch --prune && git branch -r | awk "{print \$1}" | grep -Ev -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -D'

# ── Dotfile management (bare-repo) ───────────────────────────────────────────
alias config='command git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias ca='config add -u'
alias cc='config commit -m'
alias cac='config commit -am'
alias cs='config status'
alias ccp='config push'

# ── Docker ────────────────────────────────────────────────────────────────────
alias rm-untagged="docker images --no-trunc | grep '<none>' | awk '{ print \$3 }' | xargs docker rmi"
alias clean="docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v"
alias docker-db='docker run -e POSTGRES_PASSWORD=password -d -p 54321:5432 postgres:latest'

# ── Utilities ─────────────────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias tree='eza --icons --tree --group-directories-first -I "*pycache*"'
else
  alias tree='tree -I "*pycache*" --dirsfirst'
fi
alias check-port='lsof -i -P -n | grep LISTEN'
alias git-submodule-update='git submodule update --remote'
alias gget='ghq get'
alias sshd='ssh -D 8080'
if [[ "$OSTYPE" == darwin* ]]; then
  alias start-db='pg_ctl -D /usr/local/pgsql/data -l logfile start'
else
  alias start-db='pg_ctl -D /var/lib/postgres/data -l logfile start'
fi

# ── Network ───────────────────────────────────────────────────────────────────
if [[ "$OSTYPE" == darwin* ]]; then
  alias public-ip="ifconfig -u | grep 'inet ' | grep -v 127.0.0.1 | cut -d' ' -f2 | head -1"
else
  alias public-ip="ip -4 addr show scope global | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | head -1"
fi

# ── macOS only ────────────────────────────────────────────────────────────────
if [[ "$OSTYPE" == darwin* ]]; then
  alias macos-update='sudo softwareupdate --install --all'
  alias mouse-left='defaults -currentHost write .GlobalPreferences com.apple.mouse.swapLeftRightButton -bool true'
  alias mouse-right='defaults -currentHost write .GlobalPreferences com.apple.mouse.swapLeftRightButton -bool false'
fi

# ── Project-specific ─────────────────────────────────────────────────────────
alias kill-rails='kill -9 $(cat tmp/pids/server.pid)'
alias mux='pgrep -vx tmux > /dev/null && tmux new -d -s delete-me && tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && tmux kill-session -t delete-me && tmux attach || tmux attach'
