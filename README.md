![macOS](https://img.shields.io/badge/Platform-macOS-000?logo=apple)
![License](https://img.shields.io/github/license/michael-menard/dotfiles)
![Made With Love](https://img.shields.io/badge/Built%20with-%E2%9D%A4-red)

# Modular Dotfiles Generator 🛠️

A modular, TypeScript-focused macOS development environment generator that creates comprehensive dotfiles with client isolation, AI integration, and professional development tools.

## 🔥 TLDR

This repo sets up a complete development environment including:

- ✅ Modern Zsh shell w/ Oh My Zsh, plugins, themes
- ⚙️ Version management via [`asdf`](https://asdf-vm.com/)
- 🧠 Claude + ChatGPT AI integrations (via Claude MCP)
- 🛠 Tools for JavaScript/TypeScript, Node, AWS, Git, and more
- 🧱 Project scaffolding, prompt templates, and client-specific isolation

---

**What it does:** Generates a complete dotfiles system with client-specific configurations, AI integration (Cursor, Claude MCP), AWS profiles, and 50+ development tools.

**Key features:** Client isolation • AI-enhanced development • Multi-language support • Professional toolchain • Security-first approach

**Perfect for:** TypeScript/JavaScript developers working with multiple clients who want a professional, maintainable development environment.

```bash
# One command setup
./create-dotfiles.sh
cd ~/.dotfiles
cp configs/client-template.env configs/client-acme.env
# Edit client-acme.env with your details
source configs/client-acme.env && ./bootstrap.sh
```

## 🚀 Getting Started

### Prerequisites

- **macOS** (Intel or Apple Silicon)
- **Admin access** for user creation and Homebrew installation
- **Internet connection** for downloading packages

### Quick Start (5 minutes)

1. **Download and run the generator:**
   ```bash
   # Option A: Run directly
   curl -fsSL https://raw.githubusercontent.com/your-username/dotfiles-generator/main/create-dotfiles.sh | bash
   
   # Option B: Clone and run locally
   git clone https://github.com/your-username/dotfiles-generator.git
   cd dotfiles-generator
   chmod +x create-dotfiles.sh
   ./create-dotfiles.sh
   ```

2. **Configure for your client:**
   ```bash
   cd ~/.dotfiles
   cp configs/client-template.env configs/client-myclient.env
   ```

3. **Edit your configuration:**
   ```bash
   # Edit these key variables in configs/client-myclient.env:
   export DEV_USER="michael-myclient"
   export GIT_USER_EMAIL="michael@myclient.com"
   export CLIENT_NAME="My Client Corp"
   export CLIENT_SHORT="myclient"
   export AWS_PROFILE="myclient"
   ```

4. **Bootstrap your environment:**
   ```bash
   source configs/client-myclient.env && ./bootstrap.sh
   ```

5. **Verify everything works:**
   ```bash
   ./scripts/health-check.sh
   ```

### What Gets Installed

**Essential Development Tools:**
- Homebrew package manager
- Git, GitHub CLI, Node.js (via asdf), Python (via asdf)
- VS Code, WebStorm, JetBrains Toolbox
- iTerm2, Warp terminal
- Docker, Postman, ngrok

**AI Development Tools:**
- Claude Desktop with MCP servers
- Cursor AI editor with TypeScript rules
- AI prompt library for code review/debugging
- Windsurf collaborative editor

**Productivity & Security:**
- Rectangle (window management), Maccy (clipboard)
- Little Snitch (firewall), VeraCrypt (encryption)
- Development fonts (JetBrains Mono, Fira Code)
- QuickLook plugins for developers

*Complete list: 50+ packages in the Brewfile*

## 🏗️ Project Structure

```
dotfiles-generator/
├── create-dotfiles.sh          # Main generator script
├── modules/                    # Modular components
│   ├── utils.sh               # Utility functions
│   ├── create_directories.sh  # Directory structure
│   ├── create_gitignore.sh    # Git ignore rules
│   ├── create_brewfile.sh     # Package definitions
│   ├── create_client_configs.sh # Client templates
│   ├── create_ai_prompts.sh   # AI integration
│   ├── create_scripts.sh      # Utility scripts
│   ├── create_bootstrap.sh    # Main setup script
│   ├── create_readme.sh       # Documentation
│   └── display_summary.sh     # Final summary
├── README.md                   # This file
└── LICENSE                     # MIT License
```

## 🎯 What This Generator Creates

When you run the generator, it creates `~/.dotfiles/` with:

### Core Structure
```
~/.dotfiles/
├── configs/                    # Client configurations
│   ├── client-template.env     # Template for new clients
│   ├── client-personal.env     # Personal development
│   └── client-acme-example.env # Example client config
├── ai/                         # AI integration
│   ├── prompts/               # Code review, debugging, refactoring
│   ├── cursor/                # Cursor AI rules
│   └── templates/             # Client-specific AI context
├── scripts/                    # Utility scripts
│   ├── setup-mcp.sh          # Claude MCP configuration
│   ├── init-project.sh       # Project initialization
│   ├── switch-client.sh      # Client switching
│   └── health-check.sh       # Environment verification
├── Brewfile                    # 50+ development packages
├── bootstrap.sh                # Main environment setup
└── README.md                   # Generated documentation
```

### Key Features Created

**🏢 Client Isolation System:**
- Separate user accounts per client
- Client-specific SSH keys and Git configs
- Isolated AWS profiles and credentials
- Separate development directories

**🤖 AI Development Integration:**
- Cursor rules optimized for TypeScript/React
- Claude Desktop MCP servers for secure file/repo access
- Reusable AI prompts for code review and debugging
- Client-specific AI context templates

**🔧 Professional Development Environment:**
- asdf version manager for Node.js, Python
- Comprehensive shell configuration (Zsh + Oh My Zsh)
- VS Code settings and snippets
- Project initialization templates

## 🔄 Usage Workflows

### Starting a New Project
```bash
# Load client environment
source configs/client-acme.env

# Initialize project with client-specific settings
./scripts/init-project.sh my-new-app

# Project is created in ~/Development/acme/my-new-app with:
# - .cursorrules for AI assistance
# - .ai-context.md for client context
# - Git repository initialized
# - Client-specific configurations
```

### Switching Between Clients
```bash
# Interactive client switcher
./scripts/switch-client.sh

# Or manually load specific client
source configs/client-acme.env
export PS1="[ACME] $PS1"  # Visual indicator
```

### Health Monitoring
```bash
# Check environment health
./scripts/health-check.sh

# Outputs status of:
# - Essential tools (brew, git, node, python)
# - Development tools (code, docker, aws)
# - Directory structure
# - Configuration files
# - AI tools integration
```

## 🔐 Security & Isolation

### Client Separation
- **User Accounts**: Each client gets a separate macOS user account
- **SSH Keys**: Client-specific SSH keys (`id_ed25519_clientname`)
- **Git Configuration**: Separate Git user/email per client
- **AWS Profiles**: Isolated AWS CLI profiles and credentials
- **File System**: Separate development directories

### AI Security
- **MCP Restrictions**: Claude Desktop only accesses specified directories
- **No Credential Exposure**: AI tools never see sensitive credentials
- **Client Context**: AI assistants get appropriate client context only

## 🔧 Customization

### Adding a New Client
1. Copy template: `cp configs/client-template.env configs/client-newco.env`
2. Edit configuration variables
3. Bootstrap: `source configs/client-newco.env && ./bootstrap.sh`

### Extending AI Prompts
Add new prompts to `ai/prompts/`:
```bash
# Create new prompt category
echo "# My Custom Prompts" > ai/prompts/custom-category.md
```

### Adding Custom Packages
Edit the generated `Brewfile` or use client-specific packages:
```bash
# In your client config
export ADDITIONAL_CASKS="figma sketch"
export ADDITIONAL_BREWS="kubernetes-cli helm"
```

## 🧪 Testing & Verification

### Automated Health Checks
```bash
# Run comprehensive health check
./scripts/health-check.sh

# Check specific components
brew doctor                    # Package manager
git config --list            # Git configuration
asdf current                  # Language versions
aws sts get-caller-identity   # AWS configuration
```

### Manual Verification
```bash
# Test language runtimes
node --version && npm --version
python --version && pip --version

# Test client isolation
echo "Client: $CLIENT_NAME"
echo "User: $DEV_USER"
echo "Git Email: $(git config user.email)"

# Test AI integration
ls -la ~/.dotfiles/ai/prompts/
cat .cursorrules  # In any project directory
```

## 🆘 Troubleshooting

### Common Issues

**Homebrew PATH issues (Apple Silicon):**
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

**asdf not working:**
```bash
echo '. $(brew --prefix asdf)/libexec/asdf.sh' >> ~/.zshrc
source ~/.zshrc
```

**Client config not loading:**
```bash
# Always source config before running commands
source configs/client-name.env
./bootstrap.sh
```

**MCP servers not connecting to Claude:**
```bash
# Restart Claude Desktop after running
./scripts/setup-mcp.sh
# Restart Claude Desktop application
```

### Getting Help

1. **Run health check**: `./scripts/health-check.sh`
2. **Check logs**: Look for error messages during bootstrap
3. **Verify permissions**: Ensure you have admin access for user creation
4. **Reset if needed**: Delete `~/.dotfiles` and re-run generator

## 🔄 Updates & Maintenance

### Updating the Generator
```bash
cd dotfiles-generator
git pull origin main
./create-dotfiles.sh  # Regenerate dotfiles
```

### Updating Your Environment
```bash
cd ~/.dotfiles
./bootstrap.sh  # Re-run bootstrap
brew update && brew upgrade  # Update packages
./scripts/health-check.sh  # Verify everything works
```

## 🤝 Contributing

This is designed as a personal dotfiles generator, but contributions are welcome:

1. **Fork** the repository
2. **Create** a feature branch
3. **Add** your modular component to `modules/`
4. **Test** with the generator
5. **Submit** a pull request

### Module Development Guidelines
- Keep modules focused on single responsibilities
- Use the established utility functions
- Include comprehensive error handling
- Add appropriate logging with color codes
- Document any new configuration variables

## 📄 License

MIT License - See LICENSE file for details.

---

**Perfect for TypeScript/JavaScript developers who work with multiple clients and want a professional, AI-enhanced, security-focused development environment that's easy to maintain and extend!**

## 🎉 What's Next?

After running the generator and bootstrap:

1. **Explore your new environment** - Everything is documented in the generated `~/.dotfiles/README.md`
2. **Set up your first project** - Use `./scripts/init-project.sh project-name`
3. **Configure AI tools** - Add your GitHub token for MCP, customize Cursor rules
4. **Add more clients** - Copy and customize additional client configurations
5. **Enjoy coding!** - You now have a professional, isolated, AI-enhanced development environment

*Happy coding! 🚀*
