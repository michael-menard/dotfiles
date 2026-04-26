# Dotfiles

Clean Stow-managed dotfiles configuration for macOS.

## 📦 What's Included

- **git** - Git configuration and global gitignore
- **ssh** - SSH configuration
- **zsh** - Modular zsh with custom aliases (eza, lazygit, mactop, ranger)
- **asdf** - Tool version manager configuration
- **brew** - Homebrew package list (Brewfile)
- **lazygit** - Terminal git UI with custom theme and keybindings
- **gh** - GitHub CLI configuration
- **tmuxinator** - Tmux layouts (3-column claude workspace)
- **starship** - Shell prompt configuration
- **cmux** - AI agent terminal settings
- **ghostty** - Terminal emulator config
- **micro** - Terminal text editor configuration
- **opencode** - AI code editor with OpenAI, Anthropic, OpenRouter, and Ollama support

## 🚀 Fresh Machine Setup

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Stow
```bash
brew install stow
```

### 3. Clone dotfiles
```bash
git clone git@github.com:michael-menard/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 4. Stow all packages

**Personal machine:**
```bash
cd ~/dotfiles
stow */
```

**Work machine** (skip AI tool configs):
```bash
cd ~/dotfiles
stow brew gh ghostty git helix lazygit ssh starship tmuxinator zsh
# Omit: asdf, cmux, opencode (mise replaces asdf on work)
```

This creates symlinks from your home directory to the dotfiles repo:
- `~/.zshrc` → `~/dotfiles/zsh/.zshrc`
- `~/.config/lazygit` → `~/dotfiles/lazygit/.config/lazygit`
- etc.

### 5. Install Homebrew packages

**Personal machine:**
```bash
brew bundle --file ~/Brewfile
```

**Work machine** (no AI tools):
```bash
brew bundle --file ~/dotfiles/brew/Brewfile.work
```

### 6. Install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 7. Install asdf plugins and tool versions
```bash
# Add plugins
asdf plugin add nodejs
asdf plugin add golang
asdf plugin add python

# Install versions from .tool-versions
asdf install
```

### 8. Setup environment variables
```bash
cp ~/dotfiles/.env.example ~/.env
```

Edit `~/.env` and add your API keys:
```bash
# ~/.env
BRAVE_API_KEY=your_actual_api_key_here
OPENAI_API_KEY=sk-your_openai_key_here
ANTHROPIC_API_KEY=sk-ant-your_anthropic_key_here
OPENROUTER_API_KEY=sk-or-your_openrouter_key_here
```

Set secure permissions:
```bash
chmod 600 ~/.env
```

### 9. Install OpenCode dependencies (optional)
If you use OpenCode:
```bash
cd ~/.config/opencode
bun install  # or npm install
```

This installs the AI SDK packages for OpenAI, Anthropic, and Ollama support.

See [opencode/README.md](opencode/README.md) for detailed setup.

### 10. Install Ollama models (optional)
For local AI models via Ollama:
```bash
ollama pull qwen2.5-coder:7b
ollama pull qwen2.5-coder:14b
ollama pull deepseek-coder-v2:16b
ollama pull codellama:13b
```

### 11. Reload shell
```bash
exec zsh
```

## ⚠️ Manual Steps (Not Automated)

These must be done by hand on a new machine — not covered by Brewfile or stow.

### Machine-Specific Shell Config
Create `~/.zshrc.local` for anything specific to that machine (not tracked in git):
```bash
touch ~/.zshrc.local
```

### Git Identity (Work Machine)
Override the global gitconfig with your work email:
```bash
git config --global user.email "you@work.com"
git config --global user.name "Your Name"
```

### SSH Keys
Copy private keys from old machine or generate new ones:
```bash
ssh-keygen -t ed25519 -C "your@email.com"
# Then add public key to GitHub, etc.
```

### SOPS / age Key
Copy `~/.config/sops/age/keys.txt` from old machine (back this up separately — losing it means losing access to encrypted secrets).

### `.env` File
Copy `~/.env` from old machine or recreate from `~/dotfiles/.env.example`.
Contains: `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `OPENROUTER_API_KEY`, `BRAVE_API_KEY`, etc.

### Rectangle
Window layout preferences are not stowed (stored in `~/Library/Preferences/com.knollsoft.Rectangle.plist`).
Reconfigure manually after install — settings are minimal.

### lazygit
Config was lost during dotfiles migration (was in old `~/.dotfiles`). No stow package yet.
After install, configure manually at `~/.config/lazygit/config.yml`, then add to stow package.

### macOS System Preferences
- Dock, Mission Control, keyboard repeat rate, trackpad settings, etc.
- Not tracked anywhere — configure manually.

### App Store Apps
Apps installed via Mac App Store are not in the Brewfile. Reinstall manually.

---

## 🔧 Managing Packages

### Install a package
```bash
cd ~/dotfiles
stow <package-name>
```

Example:
```bash
cd ~/dotfiles
stow zsh
```

### Remove a package
```bash
cd ~/dotfiles
stow -D <package-name>
```

### Reinstall all packages
```bash
cd ~/dotfiles
stow -R */
```

### Check what would be stowed (dry run)
```bash
cd ~/dotfiles
stow -nv <package-name>
```

## 📝 Making Changes

### Edit a config file
Just edit the file in the `~/dotfiles` directory. Changes are immediately reflected in your home directory because of the symlinks.

```bash
# Edit zsh config
vim ~/dotfiles/zsh/.zshrc

# Changes are immediately live because ~/.zshrc is a symlink
```

### Add a new config file
1. Add the file to the appropriate package directory in `~/dotfiles`
2. Restow the package: `cd ~/dotfiles && stow -R <package-name>`

### Commit your changes
```bash
cd ~/dotfiles
git add .
git commit -m "feat: add new config"
git push
```

## 🔒 Security Notes

### Secrets Management
- **Never** commit `.env` file to git
- API keys and secrets go in `~/.env` (not tracked)
- Use `.env.example` as a template
- SOPS/age private keys should be backed up separately

### SOPS Keys
SOPS private keys are stored in `~/.config/sops/age/keys.txt` and are NOT tracked in this repo.

On a new machine, either:
- Copy your existing SOPS private key to the new machine
- Generate a new age key: `age-keygen -o ~/.config/sops/age/keys.txt`

### SSH Keys
SSH keys in `~/.ssh/` are NOT included in this dotfiles repo. Only the SSH config is tracked.

## 🛠️ Troubleshooting

### Shell doesn't load
```bash
# Check for errors
zsh -c "source ~/.zshrc"

# Verify symlinks
ls -la ~/.zshrc
ls -la ~/.config
```

### Stow conflicts
If stow complains about existing files:
```bash
# Remove conflicting file
rm ~/.conflicting-file

# Try stowing again
cd ~/dotfiles && stow <package>
```

### Oh-my-zsh not found
Install oh-my-zsh:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### asdf not found
Install asdf via Homebrew:
```bash
brew install asdf
```

## 📂 Package Structure

Each package follows this structure:
```
<package-name>/
  <file-or-dir>     # Will be symlinked to ~/<file-or-dir>
  .config/          # Will create ~/.config/<package-name>
    <package-name>/
      config-files
```

Example for lazygit:
```
lazygit/
  .config/
    lazygit/
      config.yml
```

Results in: `~/.config/lazygit/config.yml` → `~/dotfiles/lazygit/.config/lazygit/config.yml`

## 🎨 Customization

### ZSH Aliases
Custom aliases are in modular files under `zsh/.zsh/aliases/`:
- `eza.zsh` - Enhanced ls replacement
- `lazygit.zsh` - Git UI launcher
- `mactop.zsh` - System monitor
- `ranger.zsh` - File manager

Add new alias files there and they'll be auto-loaded by `zsh/.zsh/loader.zsh`.

### Starship Prompt
Edit `starship/.config/starship.toml` to customize your shell prompt.

### Lazygit Theme
Edit `lazygit/.config/lazygit/config.yml` to customize lazygit appearance and keybindings.

### OpenCode
Edit `opencode/.config/opencode/opencode.json` to:
- Add/remove AI providers (OpenAI, Anthropic, Ollama)
- Configure models
- Adjust API endpoints

See [opencode/README.md](opencode/README.md) for detailed configuration options.

## 🔗 Links

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Managing Dotfiles with Stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/)
- [Oh My Zsh](https://ohmyz.sh/)
- [asdf Version Manager](https://asdf-vm.com/)

## 📜 License

MIT
