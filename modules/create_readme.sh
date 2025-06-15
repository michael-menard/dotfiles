#!/bin/bash
# modules/create_readme.sh
# Creates comprehensive documentation for the dotfiles system

cat > README.md << 'EOF'
# Michael's Dotfiles 🛠️

A comprehensive macOS development environment setup using dotfiles, GNU Stow, Homebrew, AI integration, AWS configuration, and MCP (Model Context Protocol) for Claude Desktop.

## 🚀 Quick Start

### Client-Specific Development Setup (Recommended)

1. **Run the generator:**
```bash
# This creates the entire dotfiles structure
curl -fsSL https://raw.githubusercontent.com/michael-menard/dotfiles/main/create-dotfiles.sh | bash
```

2. **Create client configuration:**
```bash
cd ~/.dotfiles
cp configs/client-template.env configs/client-acme.env
# Edit with client-specific values
```

3. **Run bootstrap:**
```bash
source configs/client-acme.env && ./bootstrap.sh
```

## 🎯 Features

- **🏢 Client Isolation**: Separate user accounts, SSH keys, AWS profiles per client
- **🤖 AI Integration**: Cursor rules, Claude MCP, reusable prompts
- **☁️ AWS Ready**: Client-specific profiles, regions, and CLI configuration
- **🔌 MCP Enabled**: Claude Desktop integration with secure file/repo access
- **🐚 Shell Optimized**: Zsh with Oh My Zsh, custom themes, and aliases
- **📦 Package Management**: Homebrew + Stow for clean configuration management
- **🔐 Security First**: Isolated environments, secure boundaries, no credential leakage
- **🔧 Version Management**: asdf for Node.js, Python, and other language runtimes

## 📁 Directory Structure

```
~/.dotfiles/
├── configs/                 # Client-specific configurations
│   ├── client-template.env   # Template for new clients
│   ├── client-personal.env  # Personal development config
│   └── client-acme-example.env
├── ai/                      # AI integration files
│   ├── prompts/             # Reusable AI prompts
│   ├── cursor/              # Cursor AI rules
│   └── templates/           # Client-specific AI templates
├── scripts/                 # Utility scripts
│   ├── setup-mcp.sh        # MCP server setup
│   ├── init-project.sh     # Project initialization
│   ├── switch-client.sh    # Client configuration switcher
│   └── health-check.sh     # Environment health check
├── git/                     # Git configuration templates
├── ssh/                     # SSH configuration templates
├── aws/                     # AWS CLI configuration
├── zsh/                     # Zsh and Oh My Zsh configuration
├── vscode/                  # VS Code settings and snippets
├── .tool-versions           # Runtime version definitions
├── Brewfile                 # Homebrew package definitions
├── Brewfile.lock.json       # Locked versions of brew dependencies
├── bootstrap.sh             # Main setup script
└── README.md                # This file
```

## 📦 Included Packages

### Version Management
- asdf (universal version manager)
- `.tool-versions` for consistent runtime versions

### Serverless Tools
- AWS SAM CLI
- Serverless Framework CLI

### Development Tools
- Visual Studio Code, WebStorm, JetBrains Toolbox
- iTerm2, Warp terminal
- Docker, Postman, ngrok
- Git, GitHub CLI, tree, fzf

### AI Tools
- Claude Desktop, ChatGPT
- Cursor, Windsurf
- AI-powered development assistants

### Productivity
- Rectangle (window management)
- Maccy (clipboard manager)
- Little Snitch (firewall)
- QuickLook plugins

### Security & Fonts
- VeraCrypt, GPG Suite
- JetBrains Mono, Fira Code
- Nerd Fonts with icons

*See `Brewfile` and `Brewfile.lock.json` for complete list*
EOF

echo -e "${GREEN}  ✓${NC} Created comprehensive README.md"
