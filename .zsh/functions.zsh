# ── Git worktrees (from omarchy) ─────────────────────────────────────────────
# Create a new worktree and branch from within current git directory.
unalias ga 2>/dev/null
ga() {
  if [[ -z "$1" ]]; then
    echo "Usage: ga <branch-name>"
    return 1
  fi

  local branch="$1"
  local base="$(basename "$PWD")"
  local wt_path="../${base}--${branch}"

  git worktree add -b "$branch" "$wt_path"
  cd "$wt_path"
}

# Remove worktree and branch from within active worktree directory.
gd() {
  local cwd worktree root branch

  cwd="$(pwd)"
  worktree="$(basename "$cwd")"

  # split on first --
  root="${worktree%%--*}"
  branch="${worktree#*--}"

  if [[ "$root" == "$worktree" ]]; then
    echo "Not inside a worktree (expected dirname like repo--branch)"
    return 1
  fi

  echo -n "Remove worktree and branch '$branch'? [y/N] "
  read -r confirm
  [[ "$confirm" =~ ^[Yy]$ ]] || return

  cd "../$root"
  git worktree remove "$cwd" --force || return 1
  git branch -D "$branch"
}

# ── xdg-open wrapper (Linux) ────────────────────────────────────────────────
if [[ "$OSTYPE" != darwin* ]]; then
  open() {
    xdg-open "$@" >/dev/null 2>&1 &
  }
fi

# ── Tmux dev layouts (from omarchy) ──────────────────────────────────────────
# Create a dev layout: editor (left), AI CLI (right 30%), terminal (bottom 15%)
# Usage: tdl <ai-command> [<second-ai>]
#   e.g. tdl claude, tdl opencode claude
tdl() {
  [[ -z $1 ]] && { echo "Usage: tdl <c|claude|opencode|other_ai> [<second_ai>]"; return 1; }
  [[ -z $TMUX ]] && { echo "You must start tmux to use tdl."; return 1; }

  local current_dir="${PWD}"
  local editor_pane ai_pane ai2_pane
  local ai="$1"
  local ai2="$2"

  editor_pane="$TMUX_PANE"

  # Name the window after the current directory
  tmux rename-window -t "$editor_pane" "$(basename "$current_dir")"

  # Bottom strip (15%)
  tmux split-window -v -p 15 -t "$editor_pane" -c "$current_dir"

  # AI pane on right (30% of editor area)
  ai_pane=$(tmux split-window -h -p 30 -t "$editor_pane" -c "$current_dir" -P -F '#{pane_id}')

  # Optional second AI pane below the first
  if [[ -n $ai2 ]]; then
    ai2_pane=$(tmux split-window -v -t "$ai_pane" -c "$current_dir" -P -F '#{pane_id}')
    tmux send-keys -t "$ai2_pane" "$ai2" C-m
  fi

  tmux send-keys -t "$ai_pane" "$ai" C-m
  tmux send-keys -t "$editor_pane" "${EDITOR:-nvim} ." C-m
  tmux select-pane -t "$editor_pane"
}

# Create one tdl window per subdirectory (great for monorepos)
# Usage: tdlm <ai-command> [<second-ai>]
tdlm() {
  [[ -z $1 ]] && { echo "Usage: tdlm <ai-command> [<second_ai>]"; return 1; }
  [[ -z $TMUX ]] && { echo "You must start tmux to use tdlm."; return 1; }

  local ai="$1"
  local ai2="$2"
  local base_dir="$PWD"
  local first=true

  tmux rename-session "$(basename "$base_dir" | tr '.:' '--')"

  for dir in "$base_dir"/*/; do
    [[ -d $dir ]] || continue
    local dirpath="${dir%/}"

    if $first; then
      tmux send-keys -t "$TMUX_PANE" "cd '$dirpath' && tdl $ai $ai2" C-m
      first=false
    else
      local pane_id=$(tmux new-window -c "$dirpath" -P -F '#{pane_id}')
      tmux send-keys -t "$pane_id" "tdl $ai $ai2" C-m
    fi
  done
}

# Multi-pane swarm: same command in N panes (great for parallel AI sessions)
# Usage: tsl <pane-count> <command>
tsl() {
  [[ -z $1 || -z $2 ]] && { echo "Usage: tsl <pane_count> <command>"; return 1; }
  [[ -z $TMUX ]] && { echo "You must start tmux to use tsl."; return 1; }

  local count="$1"
  local cmd="$2"
  local current_dir="${PWD}"
  local -a panes

  tmux rename-window -t "$TMUX_PANE" "$(basename "$current_dir")"

  panes+=("$TMUX_PANE")

  while (( ${#panes[@]} < count )); do
    local new_pane
    local split_target="${panes[-1]}"
    new_pane=$(tmux split-window -h -t "$split_target" -c "$current_dir" -P -F '#{pane_id}')
    panes+=("$new_pane")
    tmux select-layout -t "${panes[1]}" tiled
  done

  for pane in "${panes[@]}"; do
    tmux send-keys -t "$pane" "$cmd" C-m
  done

  tmux select-pane -t "${panes[1]}"
}

# ── Peco widgets ──────────────────────────────────────────────────────────────
# Interactive fuzzy finders bound to key combos via ZLE.

# Ctrl+G D  -  jump to a ghq-managed repo
peco-src() {
  local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
  if [[ -n "$selected_dir" ]]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey 'gd' peco-src

# Ctrl+O  -  checkout a recent branch (or cd into its worktree)
peco-git-checkout() {
  local branch selected
  selected=$(git branch --sort=-committerdate | grep -v 'HEAD' | peco)
  [[ -z "$selected" ]] && zle clear-screen && return

  branch=$(echo "$selected" | sed 's/^[+* ]*//')

  local worktree_path
  worktree_path=$(git worktree list --porcelain | awk -v b="$branch" '
    /^worktree / { wt=$2 }
    /^branch /   { br=$2; sub("refs/heads/", "", br); if (br == b) print wt }
  ')

  if [[ -n "$worktree_path" ]]; then
    BUFFER="cd ${worktree_path}"
  else
    BUFFER="git checkout ${branch}"
  fi
  zle accept-line
}
zle -N peco-git-checkout
bindkey '^o' peco-git-checkout

# Ctrl+D D  -  delete a branch interactively
peco-git-delete-branch() {
  git branch --sort=-committerdate | peco | xargs git branch -d
  zle accept-line
}
zle -N peco-git-delete-branch
bindkey '^dd' peco-git-delete-branch
