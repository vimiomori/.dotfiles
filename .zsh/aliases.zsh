# ── General ───────────────────────────────────────────────────────────────────
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias python='python3'
alias pip='pip3'

# ── Git ───────────────────────────────────────────────────────────────────────
alias ga='git add .'
alias gc='git commit'
alias gac='git commit -a'
alias gp='git push'
alias commit='git add . && git commit'
alias gignore='git update-index --assume-unchanged'
alias pb='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -D'

# ── Dotfile management (bare-repo) ───────────────────────────────────────────
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
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
alias tree='tree -I "*pycache*" --dirsfirst'
alias check-port='lsof -i -P -n | grep LISTEN'
alias public-ip="ifconfig -u | grep 'inet ' | grep -v 127.0.0.1 | cut -d' ' -f2 | head -1"
alias macos-update='sudo softwareupdate --install --all'
alias git-submodule-update='git submodule update --remote'
alias gget='ghq get'
alias sshd='ssh -D 8080'
alias start-db='pg_ctl -D /usr/local/pgsql/data -l logfile start'

# ── Mouse button swap (macOS) ────────────────────────────────────────────────
alias mouse-left='defaults -currentHost write .GlobalPreferences com.apple.mouse.swapLeftRightButton -bool true'
alias mouse-right='defaults -currentHost write .GlobalPreferences com.apple.mouse.swapLeftRightButton -bool false'

# ── Project-specific ─────────────────────────────────────────────────────────
alias kill-rails='kill -9 $(cat tmp/pids/server.pid)'
alias mux='pgrep -vx tmux > /dev/null && tmux new -d -s delete-me && tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && tmux kill-session -t delete-me && tmux attach || tmux attach'
