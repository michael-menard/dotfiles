# ⚙️ Michael's Dotfiles

![macOS](https://img.shields.io/badge/Platform-macOS-000?logo=apple)
![License](https://img.shields.io/github/license/michael-menard/dotfiles)
![Made With Love](https://img.shields.io/badge/Built%20with-%E2%9D%A4-red)

> A professional-grade, **AI-enhanced**, **client-isolated** dotfiles system for macOS web developers.

This repo sets up a complete development environment including:

- ✅ Modern Zsh shell w/ Oh My Zsh, plugins, themes
- ⚙️ Version management via [`asdf`](https://asdf-vm.com/)
- 🧠 Claude + ChatGPT AI integrations (via Claude MCP)
- 🛠 Tools for JavaScript/TypeScript, Node, AWS, Git, and more
- 🧱 Project scaffolding, prompt templates, and client-specific isolation

---

## 🚀 Quick Start

### 1. Clone the Repo

\`\`\`bash
git clone https://github.com/michael-menard/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
\`\`\`

### 2. Configure for a Client

\`\`\`bash
cp configs/client-template.env configs/client-acme.env
# Then edit configs/client-acme.env with your values
\`\`\`

### 3. Run the Bootstrap Script

\`\`\`bash
source configs/client-acme.env
./bootstrap.sh
\`\`\`

---

## 🧠 Features

### 🏢 Multi-Client Isolation

- Per-client SSH keys, Git user/email, AWS profiles
- Easy switching via \`source configs/client-*.env\`
- Namespaced directories and environments

### 🤖 AI Integration

- Claude Desktop + MCP (filesystem, GitHub, web search)
- Prompt library for:
  - Code review
  - Debugging
  - Refactoring
- \`.ai-context.md\` generator per project

### 🐚 Terminal Power Tools

- \`Warp\`, \`iTerm2\`, \`starship\`, \`zoxide\`, \`fzf\`, \`thefuck\`
- Fully configured Zsh with plugins and aliases

### 📦 Package Management

- Brewfile includes CLI tools, GUI apps, fonts, QuickLook plugins
- \`stow\` keeps dotfiles symlinked and modular

### 🧱 Project Bootstrap

\`\`\`bash
./scripts/init-project.sh my-app
\`\`\`

Creates:
- \`.gitignore\`, \`.ai-context.md\`, \`.cursorrules\`
- Git repo and folder under \`~/Development/[client]/[project]\`

---

## 🗂 Directory Structure

\`\`\`text
~/.dotfiles/
├── configs/                → Client-specific environments
├── zsh/, git/, aws/        → Modular config dirs
├── ai/                     → Claude/Cursor prompts
├── templates/              → Project starters
├── scripts/                → Setup scripts
├── Brewfile                → Brew + Cask package list
└── bootstrap.sh            → Main install script
\`\`\`

---

## 🧩 Extending It

Add your custom packages in the client config:
\`\`\`env
export ADDITIONAL_BREWS="gnu-sed jq"
export ADDITIONAL_CASKS="notion obsidian"
\`\`\`

Or add more tools to the [\`Brewfile\`](./Brewfile).

---

## 📥 What Gets Installed

- Zsh + Oh My Zsh + plugins
- Node.js, Python (via asdf)
- VS Code, WebStorm, Docker, Warp, Slack, Figma
- AI tools: Claude Desktop, ChatGPT, MCP
- Fonts: JetBrains Mono, Fira Code, Meslo Nerd Font
- Utilities: \`wget\`, \`htop\`, \`bat\`, \`ripgrep\`, \`tree\`, \`exa\`, \`navi\`

---

## 🛡 Security & Isolation

- No secrets committed
- \`.gitignore\` includes SSH keys, \`.env\`, AWS creds
- Per-client token paths for GitHub, AWS, and MCP

---

## 📄 License

MIT © [Michael Menard](https://github.com/michael-menard)

---

## 🧠 Bonus: Prompt Library

Want your AI assistant to do more?

\`\`\`text
ai/prompts/
├── code-review.md
├── debugging.md
└── refactoring.md
\`\`\`

Copy-paste into Claude, Cursor, or ChatGPT for high-signal, dev-specific help.

---

## 💬 Questions?

Feel free to open an issue or fork the repo. This setup is built to scale across multiple clients with minimum friction.

---

**Built with love, caffeine, and a very opinionated shell.**
