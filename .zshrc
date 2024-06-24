# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LC_ALL=en_US.UTF-8
# export ZSH=/Users/vivian.hsieh/.oh-my-zsh
export GOPATH=$HOME/code
export GOBIN=$GOPATH/bin
export JAVA_HOME=$HOME/OpenJDK/jdk-21.0.2.jdk/Contents/Home

path=(
	$path
	$GOPATH/bin
	$JAVA_HOME
  ~/src/bin
	/usr/local/go/bin
	~/Library/Python/3.9/bin
	/bin
	/sbin
	/usr/bin
	/usr/local/opt/ruby/bin
	/usr/local/bin
	/usr/local/sbin
	~/bin
	~/.local/bin
	/usr/local/opt/python@2/libexec/bin
	/usr/local/opt/gettext/bin
	/usr/local/mysql/bin
	/Applications/Postgres.app/Contents/Versions/latest/bin
	/usr/local/php5/bin
	~/.cargo/bin
	~/.gem/ruby/2.0.0/bin
	~/.pyenv/bin
)
if [ -d "/usr/local/lib" ]; then
	path+=/usr/local/lib
fi

if [ -f ~/.dir_colors ]; then  
  eval `dircolors ~/.dir_colors`
fi  
if [ -t 1 ]; then
  cd ~
fi 

# ZSH_THEME="mortalscumbag"
#================================================================================================
#	                                   Plugins
#================================================================================================
# plugins=(
# 	colorize
# )

# source $ZSH/oh-my-zsh.sh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi


### End of Zinit's installer chunk
source "${ZINIT_HOME}/zinit.zsh"


# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
# zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=cyan,italic"
# bindkey '^I' autosuggest-accept
# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'

# Shell integrations
# eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"

#================================================================================================
#	                                   Aliases
#================================================================================================

alias python='python3'
alias pip='pip3'
alias ga='git add .'
alias gc='git commit'
alias commit='git add . && git commit'
alias gp='git push'
alias gignore='git update-index --assume-unchanged'
alias update='git submodule update --remote'
alias sshd='ssh -D 8080'
alias mvim='mvim -v'
alias update='sudo softwareupdate --install --all'
alias rm-untagged="docker images --no-trunc | grep '<none>' | awk '{ print $3 }' \
          | xargs docker rmi"
alias clean="docker ps --filter status=dead --filter status=exited -aq \
          | xargs docker rm -v"
alias tree='tree -I "*pycache*" --dirsfirst'
alias prd-db='~/scripts/prod_db.sh'
alias gget="ghq get"
alias test='cd ~/src/github.com/REDACTED_ORG/REDACTED_REPO_3/service/octopus-api && test-env-exec grc go test ./...'

# for managing dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# bug with python3.7 support for system vim
# alias vim='/usr/local/Cellar/macvim/8.1-153/MacVim.app/Contents/MacOS/Vim'
alias check-port='lsof -i -P -n | grep LISTEN'
alias kill-rails='kill -9 $(cat tmp/pids/server.pid)'
alias pb='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -D'
alias start-db='pg_ctl -D /usr/local/pgsql/data -l logfile start'
alias public-ip='ifconfig -u | grep 'inet ' | grep -v 127.0.0.1 | cut -d\  -f2 | head -1'
alias docker-db='docker run -e POSTGRES_PASSWORD=password -d -p 54321:5432 postgres:latest'
alias assume-dev='eval "$(shobo-aws-sts-cli -keyring -role-to-switch arn:aws:iam::REDACTED_AWS_ACCOUNT_DEV:role/switch-role-dev -user vivian.hsieh)"'
alias assume-stg='eval "$(shobo-aws-sts-cli -keyring -role-to-switch arn:aws:iam::REDACTED_AWS_ACCOUNT_STG:role/saascore-stg-ops -user vivian.hsieh)"'
alias assume-prd='eval "$(shobo-aws-sts-cli -keyring -role-to-switch arn:aws:iam::REDACTED_AWS_ACCOUNT_PRD:role/saascore-prd-ops -user vivian.hsieh)"'
alias assume-system='aws sts assume-role --role-arn arn:aws:iam::REDACTED_AWS_ACCOUNT_STG:role/saascore-stg-system-api --role-session-name api-gateway-test --region ap-northeast-1'
alias assume-system-prd='aws sts assume-role --role-arn arn:aws:iam::REDACTED_AWS_ACCOUNT_PRD:role/saascore-prd-system-api --role-session-name api-use --region ap-northeast-1'

function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey 'gd' peco-src

function peco-git-checkout {
    git branch --sort=-committerdate | peco | xargs git checkout
		zle accept-line
}
zle -N peco-git-checkout
bindkey '^o' peco-git-checkout

function peco-git-delete-branch {
    git branch --sort=-committerdate | peco | xargs git branch -d
		zle accept-line
}
zle -N peco-git-delete-branch
bindkey '^dd' peco-git-delete-branch

export PATH="${HOMEBREW_PREFIX}/opt/openssl/bin:$PATH"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

eval "$(direnv hook zsh)"
eval "$(brew shellenv)"

export CGO_CFLAGS="${CGO_CFLAGS} -I${HOME}/tmp/dtflib/include"
export CGO_CFLAGS="${CGO_CFLAGS} -I${HOMEBREW_PREFIX}/include"
export CGO_CFLAGS="${CGO_CFLAGS} -I${HOMEBREW_PREFIX}/opt/libarchive/include"
export CGO_CFLAGS="${CGO_CFLAGS} -I${HOMEBREW_PREFIX}/opt/libmagic/include"
export CGO_CFLAGS="${CGO_CFLAGS} -I${HOMEBREW_PREFIX}/opt/libiconv/include"
export CGO_CFLAGS="${CGO_CFLAGS} -I${HOMEBREW_PREFIX}/opt/uchardet/include"

export CGO_LDFLAGS="${CGO_LDFLAGS} -L${HOMEBREW_PREFIX}/lib"
export CGO_LDFLAGS="${CGO_LDFLAGS} -L${HOMEBREW_PREFIX}/opt/libarchive/lib"
export CGO_LDFLAGS="${CGO_LDFLAGS} -L${HOMEBREW_PREFIX}/opt/libmagic/lib"
export CGO_LDFLAGS="${CGO_LDFLAGS} -L${HOMEBREW_PREFIX}/opt/libiconv/lib"

# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# # The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/vivian.hsieh/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/vivian.hsieh/google-cloud-sdk/path.zsh.inc'; fi
#
# # The next line enables shell command completion for gcloud.
# if [ -f '/Users/vivian.hsieh/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/vivian.hsieh/google-cloud-sdk/completion.zsh.inc'; fi
# export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
#
#
export AWS_DEFAULT_REGION=ap-northeast-1
