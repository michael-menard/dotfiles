#!/bin/bash
# modules/create_brewfile.sh
# Creates the comprehensive Brewfile for package management

cat > Brewfile << 'EOF'
# Tap for fonts
tap "homebrew/cask-fonts"

# Command Line Tools
brew "tree"                # Display directory structure in a tree format
brew "git"                 # Distributed version control system (latest version)
brew "gh"                  # GitHub CLI for managing repos, PRs, and issues from terminal
brew "jq"                  # Lightweight JSON processor for parsing and manipulating JSON data
brew "curl"                # Command line tool for transferring data with URL syntax
brew "wget"                # Internet file retriever and downloader
brew "htop"                # Interactive process viewer and system monitor
brew "fzf"                 # Fuzzy finder for command line search and filtering
brew "bat"                 # Cat clone with syntax highlighting and Git integration
brew "exa"                 # Modern replacement for ls with better formatting and colors
brew "mas"                 # Mac App Store command line interface
brew "trash"               # Move files to trash instead of permanent deletion
brew "stow"                # Symlink farm manager for dotfiles
brew "zsh"                 # Modern shell with powerful features

# Development Package Managers
brew "yarn"                # Fast, reliable, and secure dependency management for JavaScript
brew "pnpm"                # Fast, disk space efficient package manager for Node.js
brew "asdf"                # Universal version manager for multiple languages

# Languages and Runtimes (managed via asdf)
# Node.js and Python will be installed via asdf in bootstrap script

# Browsers
cask "brave-browser"        # Privacy-focused browser with built-in ad blocker
cask "google-chrome"        # Google's web browser for development and general use

# Development Tools
cask "visual-studio-code"   # Microsoft's lightweight code editor with extensive extensions
cask "webstorm"            # JetBrains IDE for JavaScript and TypeScript development
cask "jetbrains-toolbox"   # JetBrains Toolbox for managing all JetBrains IDEs and updates
cask "iterm2"              # Advanced terminal replacement for macOS with split panes and customization
cask "warp"                # Modern terminal with AI-powered command suggestions and collaboration
cask "docker"              # Containerization platform for developing and deploying applications
cask "postman"             # API development and testing tool for REST/GraphQL endpoints
cask "ngrok"               # Secure tunneling tool to expose local servers to the internet
cask "burp-suite"          # Web application security testing and penetration testing tool
cask "wireshark"           # Network protocol analyzer for troubleshooting and security analysis
cask "windsurf"            # AI-powered code editor with collaborative features

# AI & Development Assistance
cask "claude"              # Anthropic's AI assistant desktop app for conversations and coding help
cask "chatgpt"             # OpenAI's ChatGPT desktop application
cask "taskmaster"          # Task and project management application
cask "roocode"             # Code review and collaboration tool

# Fonts for Development
cask "font-fantasque-sans-mono"  # Quirky monospace font with programming ligatures
cask "font-fira-code"           # Popular monospace font with programming ligatures
cask "font-hack"                # Typeface designed specifically for source code
cask "font-jetbrains-mono"      # JetBrains' monospace font optimized for developers
cask "font-meslo-lg-nerd-font"  # Meslo font patched with developer icons and symbols

# Productivity & Window Management
cask "rectangle"           # Window management tool for snapping and organizing windows
cask "maccy"              # Lightweight clipboard manager for macOS
cask "keka"               # File archiver and unarchiver supporting multiple formats
cask "little-snitch"      # Network monitor and firewall for controlling app internet access
cask "coteditor"          # Lightweight text editor for quick edits and coding
cask "boop"               # Text transformation utility for developers (JSON formatting, encoding, etc.)
cask "slack"              # Team communication and collaboration platform
cask "zap"                # App uninstaller that removes all associated files

# QuickLook Plugins (Preview files in Finder)
cask "qlcolorcode"        # Syntax highlighting for source code files in QuickLook
cask "qlimagesize"        # Display image dimensions and file size in QuickLook
cask "qlmarkdown"         # Preview Markdown files with formatting in QuickLook
cask "qlprettypatch"      # Preview .patch files with syntax highlighting
cask "qlstephen"          # Preview plain text files without extensions
cask "qlvideo"            # Preview video files and show metadata in QuickLook
cask "quicklook-csv"      # Preview CSV files in a formatted table view
cask "quicklook-json"     # Preview JSON files with syntax highlighting and formatting
cask "quicklookapk"       # Preview Android APK files and show app information
cask "webpquicklook"      # Preview WebP image format files in QuickLook

# Media & Design
cask "figma"              # Collaborative interface design and prototyping tool
cask "obs"                # Open source software for video recording and live streaming
cask "vlc"                # Versatile media player supporting virtually all video/audio formats
cask "calibre"            # E-book management and conversion tool

# Security & System Tools
cask "veracrypt"          # Disk encryption software for securing sensitive data
cask "gpg-suite"          # Complete OpenPGP email security solution for macOS
cask "macfuse"            # File system extension allowing third-party file systems
EOF

echo -e "${GREEN}  ✓${NC} Created Brewfile"
