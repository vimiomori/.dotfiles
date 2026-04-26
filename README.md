# .dotfiles

Managed with a [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles) at `~/.cfg`.

## Fresh machine setup

```bash
curl -Lks https://raw.githubusercontent.com/vimiomori/.dotfiles/main/setup.sh | /bin/bash
```

## Manual setup

```bash
git clone --bare git@github.com:vimiomori/.dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
config config --local status.showUntrackedFiles no
cp ~/.zsh/aws.zsh.example ~/.zsh/aws.zsh  # then fill in your values
```

## Day-to-day usage

```bash
config add -u            # stage all tracked changes
config commit -m "msg"   # commit
config push              # push to remote
```

## Structure

Shell config is split into modules under `~/.zsh/`:

- `path.zsh` - PATH setup with existence checks
- `plugins.zsh` - Zinit, completions, prompt
- `aliases.zsh` - general, git, docker, utility aliases
- `aws.zsh` - AWS roles, bastion, DB tunnels (gitignored, local only)
- `aws.zsh.example` - template for aws.zsh
- `functions.zsh` - peco interactive widgets
- `cgo.zsh` - CGO compiler/linker flags
