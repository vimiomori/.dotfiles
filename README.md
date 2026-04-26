# .dotfiles

Managed with a [bare git repo](https://www.atlassian.com/git/tutorials/dotfiles) at `~/.cfg`.

Works on macOS and Linux (tested with Arch/Omarchy).

## Fresh machine setup

```bash
curl -Lks https://raw.githubusercontent.com/vimiomori/.dotfiles/main/setup.sh | /bin/bash
```

The script auto-detects your OS and uses the right package manager:

- **macOS**: Homebrew + Brewfile
- **Arch/Omarchy**: pacman + yay (reads `pacman-pkgs.txt` and `aur-pkgs.txt`)

## Manual setup

```bash
git clone --bare git@github.com:vimiomori/.dotfiles.git $HOME/.cfg
alias config='command git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
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

- `path.zsh` -- PATH setup with existence checks
- `plugins.zsh` -- Zinit, completions, prompt
- `aliases.zsh` -- general, git, docker, utility aliases
- `aws.zsh` -- AWS roles, bastion, DB tunnels (gitignored, local only)
- `aws.zsh.example` -- template for aws.zsh
- `functions.zsh` -- peco interactive widgets
- `cgo.zsh` -- CGO compiler/linker flags

Terminal configs:

- `.config/ghostty/config` -- Ghostty (Omarchy default), sets zsh as shell
- `.config/alacritty/alacritty.toml` -- shared Alacritty config (colors, font, keybindings)
- `.config/alacritty/os-macos.toml` -- macOS overrides (SimpleFullscreen, Cmd hints)
- `.config/alacritty/os-linux.toml` -- Linux overrides (zsh shell, xdg-open hints)

`setup.sh` creates a symlink `os.toml` pointing to the right Alacritty override for your platform.

## Omarchy notes

Omarchy uses bash as the login shell. Don't `chsh` to zsh -- instead, the terminal
config tells your emulator (Ghostty or Alacritty) to launch `/usr/bin/zsh` directly.
This keeps Omarchy's system init scripts happy while giving you the full zsh setup.

On a fresh machine, `setup.sh` clones over HTTPS (no SSH key needed), then switches
the remote to SSH so pushes work after you add your key.
