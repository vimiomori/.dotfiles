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
