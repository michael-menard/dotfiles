#!/bin/bash
# modules/create_brewfile.sh
# Creates the comprehensive Brewfile for package management

cat > Brewfile << 'EOF'
# Tap for fonts
tap "homebrew/cask-fonts"

# Command Line Tools
brew "tree"
brew "git"
brew "gh"
brew "jq"
brew "curl"
brew "wget"
brew "htop"
brew "fzf"
brew "bat"
brew "exa"
brew "mas"
brew "trash"
brew "stow"
brew "zsh"

# Development Package Managers
brew "aws-sam-cli"  # AWS Serverless Application Model CLI
brew "serverless"    # Serverless Framework CLI
brew "yarn"
brew "pnpm"
brew "asdf"

# Browsers
cask "brave-browser"
cask "google-chrome"

# Development Tools
cask "visual-studio-code"
cask "webstorm"
cask "jetbrains-toolbox"
cask "iterm2"
cask "warp"
cask "docker"
cask "postman"
cask "ngrok"
cask "burp-suite"
cask "wireshark"
cask "windsurf"

# AI & Development Assistance
cask "claude"
cask "chatgpt"
cask "taskmaster"
cask "roocode"

# Fonts for Development
cask "font-fantasque-sans-mono"
cask "font-fira-code"
cask "font-hack"
cask "font-jetbrains-mono"
cask "font-meslo-lg-nerd-font"

# Productivity & Window Management
cask "rectangle"
cask "maccy"
cask "keka"
cask "little-snitch"
cask "coteditor"
cask "boop"
cask "slack"
cask "zap"

# QuickLook Plugins
cask "qlcolorcode"
cask "qlimagesize"
cask "qlmarkdown"
cask "qlprettypatch"
cask "qlstephen"
cask "qlvideo"
cask "quicklook-csv"
cask "quicklook-json"
cask "quicklookapk"
cask "webpquicklook"

# Media & Design
cask "figma"
cask "obs"
cask "vlc"
cask "calibre"

# Security & System Tools
cask "veracrypt"
cask "gpg-suite"
cask "macfuse"
EOF

echo -e "${GREEN}  ✓${NC} Created Brewfile"
