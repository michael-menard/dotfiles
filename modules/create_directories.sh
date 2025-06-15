#!/bin/bash
# modules/create_directories.sh
# Creates the main directory structure for dotfiles

# Create main directory
mkdir -p ~/.dotfiles
cd ~/.dotfiles

# Create all subdirectories
create_dir "configs"
create_dir "git"
create_dir "ssh"
create_dir "aws"
create_dir "zsh"
create_dir "mcp"
create_dir "ai"
create_dir "vscode"
create_dir "docs"
create_dir "scripts"
create_dir "templates"
create_dir "modules"

# Create AI subdirectories
create_dir "ai/cursor"
create_dir "ai/prompts" 
create_dir "ai/claude"
create_dir "ai/github-copilot"
create_dir "ai/windsurf"
create_dir "ai/templates/client-specific"

# Create VS Code subdirectories
create_dir "vscode/.vscode/snippets"
create_dir "vscode/User/snippets"

# Create template subdirectories
create_dir "templates/project-setup/typescript-project"
create_dir "templates/project-setup/react-app"
create_dir "templates/project-setup/node-api"

echo -e "${GREEN}✅ Directory structure created${NC}"
