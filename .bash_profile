# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

## REMOVED: deploy key export

# added by Anaconda3 5.1.0 installer
export PATH="/anaconda3/bin:$PATH"

# added by Anaconda3 5.1.0 installer
export PATH="/Users/vi/anaconda3/bin:$PATH"

# add powerline command
export POWERLINE_CONFIG_COMMAND="/Users/vi/Library/Python/3.6/bin"
export PATH="Users/vi/Library/Python/3.6/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

export PATH="$HOME/.cargo/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="/usr/local/opt/ruby/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
