# ── PATH ──────────────────────────────────────────────────────────────────────
# Only adds directories that actually exist on this machine.

export GOPATH="$HOME/code"
export GOBIN="$GOPATH/bin"

# Resolve JAVA_HOME dynamically if possible
if [[ -d "$HOME/OpenJDK" ]]; then
  export JAVA_HOME=$(find "$HOME/OpenJDK" -maxdepth 1 -name 'jdk-*.jdk' | sort -V | tail -1)/Contents/Home
fi

typeset -U path  # deduplicate PATH entries automatically

_maybe_path() {
  [[ -d "$1" ]] && path+=("$1")
}

_maybe_path "$GOPATH/bin"
_maybe_path "$JAVA_HOME"
_maybe_path "$HOME/src/bin"
_maybe_path /usr/local/go/bin
_maybe_path /opt/homebrew/opt/go@1.24/bin
_maybe_path "$HOME/nvim/bin"
_maybe_path "$HOME/.cargo/bin"
_maybe_path "$HOME/.pyenv/bin"
_maybe_path "$HOME/.krew/bin"
_maybe_path "$HOME/.local/bin"
_maybe_path "$HOME/bin"
_maybe_path /usr/local/opt/ruby/bin
_maybe_path /usr/local/bin
_maybe_path /usr/local/sbin
_maybe_path /usr/local/lib
_maybe_path /usr/local/mysql/bin
_maybe_path /Applications/Postgres.app/Contents/Versions/latest/bin

unfunction _maybe_path
