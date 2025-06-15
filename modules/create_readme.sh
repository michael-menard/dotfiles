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
├── Brewfile                 # Homebrew package definitions
├── bootstrap.sh             # Main setup script
└── README.md               # This file
```

## 🔧 Core Scripts

### Bootstrap Script
```bash
# Setup with client configuration
source configs/client-personal.env && ./bootstrap.sh

# Setup with defaults
./bootstrap.sh
```

### Utility Scripts
```bash
# Check environment health
./scripts/health-check.sh

# Setup MCP for Claude Desktop
./scripts/setup-mcp.sh

# Initialize new project
source configs/client-acme.env && ./scripts/init-project.sh my-app

# Switch between client configurations
./scripts/switch-client.sh
```

## 🏢 Client Configuration System

### Creating a New Client Configuration

1. **Copy the template:**
```bash
cp configs/client-template.env configs/client-newclient.env
```

2. **Edit the configuration:**
```bash
# Essential settings to customize:
export DEV_USER="michael-newclient"
export GIT_USER_EMAIL="michael@newclient.com"
export SSH_KEY_NAME="id_ed25519_newclient"
export CLIENT_NAME="New Client Corp"
export CLIENT_SHORT="newclient"
export AWS_PROFILE="newclient"
export MCP_ALLOWED_DIRECTORIES="~/Development/newclient"
```

3. **Activate and bootstrap:**
```bash
source configs/client-newclient.env && ./bootstrap.sh
```

### Key Configuration Variables

| Variable | Purpose | Example |
|----------|---------|---------|
| `DEV_USER` | Development user account | `michael-acme` |
| `GIT_USER_EMAIL` | Git commit email | `michael@acme.com` |
| `SSH_KEY_NAME` | SSH key filename | `id_ed25519_acme` |
| `CLIENT_SHORT` | Short client name | `acme` |
| `AWS_PROFILE` | AWS CLI profile | `acme` |
| `MCP_ALLOWED_DIRECTORIES` | Claude MCP access | `~/Development/acme` |

## 🤖 AI Integration

### Cursor AI Rules
- TypeScript/React development focused
- Automatic code style enforcement
- Best practice suggestions
- Located in `ai/cursor/.cursorrules`

### AI Prompt Library
- **Code Review**: Comprehensive review templates
- **Debugging**: Systematic debugging approaches
- **Refactoring**: Modernization strategies
- Located in `ai/prompts/`

### Claude Desktop MCP
- **Filesystem access**: Secure file operations
- **GitHub integration**: Repository access
- **Web search**: Research capabilities
- Setup via `./scripts/setup-mcp.sh`

## ☁️ AWS Integration

Each client gets isolated AWS configuration:
- Separate CLI profiles
- Region-specific defaults
- Client-specific credentials
- SSO support ready

```bash
# Configure after bootstrap
aws configure --profile $AWS_PROFILE
```

## 🔧 Language Management with asdf

The bootstrap script automatically installs and configures:
- **Node.js**: Latest LTS version
- **Python**: Latest 3.x version
- **Package managers**: npm, yarn, pnpm

```bash
# Check installed versions
asdf current

# Install specific versions
asdf install nodejs 18.17.0
asdf install python 3.11.0

# Set global versions
asdf global nodejs 18.17.0
asdf global python 3.11.0
```

## 📦 Included Packages

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

*See `Brewfile` for complete list*

## 🔐 Security Features

- **Client Isolation**: Separate user accounts prevent credential mixing
- **SSH Key Management**: Client-specific SSH keys
- **Environment Boundaries**: Isolated development directories
- **Secure MCP**: Restricted filesystem access for Claude
- **Credential Separation**: No shared AWS/Git credentials

## 🧪 Testing Your Setup

```bash
# Run comprehensive health check
./scripts/health-check.sh

# Test Git configuration
git config --list

# Test Node.js setup
node --version && npm --version

# Test AWS configuration
aws sts get-caller-identity --profile $AWS_PROFILE

# Test client isolation
echo $CLIENT_NAME && echo $DEV_USER
```

## 🆘 Troubleshooting

### Common Issues

**Homebrew not in PATH (Apple Silicon):**
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

**asdf not working:**
```bash
echo '. $(brew --prefix asdf)/libexec/asdf.sh' >> ~/.zshrc
source ~/.zshrc
```

**MCP servers not connecting:**
```bash
# Restart Claude Desktop after running
./scripts/setup-mcp.sh
```

**Client config not loading:**
```bash
# Ensure you source the config before other commands
source configs/client-name.env
```

## 🔄 Updating

```bash
cd ~/.dotfiles
git pull origin main
./bootstrap.sh  # Re-run bootstrap if needed
./scripts/health-check.sh  # Verify everything works
```

## 🤝 Contributing

This is a personal dotfiles repository, but feel free to:
- Fork for your own use
- Submit issues for bugs
- Suggest improvements via PR
- Share your client configuration strategies

## 📄 License

MIT License - feel free to use and modify for your own development setup.

---

**Perfect for TypeScript/JavaScript developers working with multiple clients who want a professional, AI-enhanced development environment!**
EOF

echo -e "${GREEN}  ✓${NC} Created comprehensive README.md"
