# Zsh Configuration Package

This package contains modular zsh configuration managed by stow.

## Structure

```
zsh/
├── .zsh/
│   ├── loader.zsh          # Main loader that sources all configs
│   └── aliases/
│       └── eza.zsh         # Eza (modern ls) aliases
```

## Installation

1. Stow this package:
   ```bash
   cd ~/dotfiles
   stow zsh
   ```

2. Add this line to your `~/.zshrc`:
   ```bash
   # Load modular zsh config
   [[ -f ~/.zsh/loader.zsh ]] && source ~/.zsh/loader.zsh
   ```

3. Reload your shell:
   ```bash
   source ~/.zshrc
   ```

## Available Aliases

### Eza Aliases

After installation, you'll have these eza aliases:

### Basic
- `ls` - basic listing with icons and directories first
- `ll` - long listing with git status
- `la` - all files (including hidden) with git status
- `l` - long listing with all files and git status

### Tree Views
- `lt` - tree view (2 levels)
- `lt3` - tree view (3 levels)
- `lta` - tree view with hidden files

### Filtered Views
- `ld` - only directories
- `lf` - only files
- `lh` - only hidden files

### Sorted Views
- `lS` - sort by size
- `lm` - sort by modified time
- `lc` - sort by created time

### Git-Focused
- `lg` - git status, respecting .gitignore
- `lgi` - git status
- `lla` - long listing with all details, git, extended attributes

### Mactop Aliases

After installation, you'll have these mactop (macOS system monitor) aliases:

#### Basic
- `mt` - shortcut for mactop
- `mactop-fast` - update every 500ms
- `mactop-slow` - update every 2s

#### Themed Variants
- `mt-purple` - purple/dark theme
- `mt-green` - green/black theme
- `mt-blue` - blue theme
- `mt-cyber` - cyberpunk green theme

#### Temperature Units
- `mt-f` - use Fahrenheit
- `mt-c` - use Celsius

#### Monitoring/Headless
- `mt-json` - JSON output (pretty printed)
- `mt-monitor` - take 10 samples and output JSON
- `mt-sample` - take 5 samples and exit
- `mt-prometheus` - run Prometheus metrics server on port 9090
- `mt-menubar` - run as menu bar status item

### Ranger Aliases

After installation, you'll have these ranger (terminal file manager) aliases and functions:

#### Basic
- `r`, `ra` - shortcut for ranger
- `rh` - start in home directory
- `rd` - start in Downloads
- `rp` - start in Projects
- `rdt` - start in dotfiles
- `ranger-clean` - run without config files

#### Special Functions
- `rcd`, `rc`, `ranger-cd` - **Change directory to where you exit ranger** (very useful!)
  - Usage: `rcd` to browse and cd to selected directory
- `ranger-choose`, `rchoose` - Select a file and return its path
  - Usage: `file=$(rchoose)` to select a file
- `ranger-edit`, `re` - Browse with ranger and edit selected file
  - Usage: `re` to browse and edit a file

#### Pro Tips
- Use `ranger-cd` (or `rcd`) to navigate your filesystem and have your shell cd to that location when you quit
- Use `re` to quickly browse and open files in your editor
- Inside ranger:
  - `h/j/k/l` - navigate (vim-style)
  - `Space` - select files
  - `yy` - copy, `dd` - cut, `pp` - paste
  - `q` - quit

### Lazygit Aliases

After installation, you'll have these lazygit (terminal UI for git) aliases and functions:

#### Basic
- `lg`, `lzg` - launch lazygit

#### Start in Specific Panels
- `lgs` - start in status panel
- `lgb` - start in branch panel
- `lgl` - start in log panel
- `lgst` - start in stash panel

#### Screen Modes
- `lg-half` - half screen mode
- `lg-full` - full screen mode

#### Special Functions
- `lg-path <path>` - open lazygit for a specific repository path
  - Usage: `lg-path ~/my-project`
- `lg-filter <file-or-path>` - filter commits/history for specific file or path
  - Usage: `lg-filter src/App.tsx`

#### Shortcuts for Common Locations
- `lg-home` - lazygit in home directory
- `lg-dot` - lazygit in dotfiles directory
- `lg-dotfiles` - lazygit for dotfiles (bare repo setup)

#### Debug & Config
- `lg-debug` - run in debug mode
- `lg-logs` - tail lazygit logs
- `lg-config` - print default config
- `lg-configdir` - print config directory

#### Pro Tips
- Inside lazygit:
  - `?` - show keybindings help
  - `x` - open menu for current item
  - `@` - open command log
  - Press `1-5` to switch between panels
  - `q` - quit

## Adding More Configs

To add more modular configs:

1. Create new files in the appropriate directory:
   - `aliases/` for aliases
   - `functions/` for functions
   - `env/` for environment variables

2. They'll be automatically loaded by `loader.zsh`
