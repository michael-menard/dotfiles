# Dotfiles

Stow-managed dotfiles configuration.

## Packages

- **git** - Git configuration (.gitconfig, .gitignore_global)
- **ssh** - SSH configuration
- **zsh** - Modular zsh configuration (eza, mactop, ranger, lazygit aliases)

## Additional Configs (in ~/.dotfiles/.config/)

- **lazygit** - Lazygit configuration with custom theme and keybindings (see `~/.config/lazygit/README.md`)

## Installation

Install individual packages with stow:

```bash
cd ~/dotfiles
stow git
stow ssh
stow zsh
```

Or install all packages:

```bash
cd ~/dotfiles
stow */
```

## Zsh Configuration

The zsh package uses a modular approach. After stowing, add this to your `~/.zshrc`:

```bash
# Load modular zsh config
[[ -f ~/.zsh/loader.zsh ]] && source ~/.zsh/loader.zsh
```

See `zsh/README.md` for details on available aliases and configuration.
