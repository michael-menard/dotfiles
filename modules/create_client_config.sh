#!/bin/bash
# modules/create_client_configs.sh
# Creates client-specific configuration templates and examples

# Create client configuration template
cat > configs/client-template.env << 'EOF'
# Client Configuration Template
# Copy this file to configs/client-[name].env and customize for each client

# User Account Settings
export DEV_USER="michael-[CLIENT]"              # Username for the development profile
export DEV_USER_FULLNAME="Michael Menard ([CLIENT_FULLNAME])"  # Full name display

# Git Configuration
export GIT_USER_NAME="Michael Menard"           # Git commit author name
export GIT_USER_EMAIL="michael@[CLIENT].com"    # Git commit email
export GIT_SIGNING_KEY=""                       # GPG key ID for signed commits (optional)

# SSH Configuration  
export SSH_KEY_NAME="id_ed25519_[CLIENT]"       # SSH key filename
export SSH_KEY_COMMENT="michael@[CLIENT].com"   # SSH key comment
export SSH_HOST_ALIAS="github-[CLIENT]"         # SSH host alias for GitHub

# GitHub/Git Remote Settings
export GITHUB_USERNAME="michael-menard"         # Your GitHub username
export DEFAULT_REMOTE_HOST="github-[CLIENT]"    # Default remote host for git operations

# Directory Structure
export CLIENT_NAME="[CLIENT_FULLNAME]"          # Full client name for display
export CLIENT_SHORT="[CLIENT]"                  # Short client name for directories
export WORK_DIR_NAME="[CLIENT]"                 # Name for ~/Development/[CLIENT]

# Development Environment
export DEFAULT_EDITOR="code"                    # Default editor (code, vim, etc.)
export DEFAULT_BROWSER="brave-browser"          # Default browser for development

# Project Settings (optional)
export PROJECT_NAMESPACE="[CLIENT]"             # Namespace for projects
export DOCKER_REGISTRY=""                       # Client-specific Docker registry (if any)
export AWS_PROFILE="[CLIENT]"                   # AWS CLI profile name (if using AWS)

# Shell Customization
export ZSH_THEME="robbyrussell"                 # Oh My Zsh theme
export PROMPT_CONTEXT="[CLIENT]"                # Additional prompt context

# AWS Configuration
export AWS_REGION="us-east-1"                   # Default AWS region for client
export AWS_OUTPUT="json"                        # Default output format (json, table, text)
export AWS_CLI_AUTO_PROMPT="on-partial"         # Enable AWS CLI auto-prompt
export AWS_PAGER=""                             # Disable pager for AWS CLI output

# MCP (Model Context Protocol) Configuration
export MCP_GITHUB_TOKEN=""                      # GitHub token for MCP GitHub server
export MCP_ENABLE_DIRECTORY="true"              # Enable directory access MCP server
export MCP_ENABLE_GITHUB="true"                 # Enable GitHub MCP server
export MCP_ENABLE_WEB="true"                    # Enable web search MCP server
export MCP_ALLOWED_DIRECTORIES="~/Development/[CLIENT],~/Documents/Projects/[CLIENT]"

# Client-specific environment variables (add as needed)
export CLIENT_API_BASE_URL=""                   # Client's API base URL
export CLIENT_DOCS_URL=""                       # Client documentation URL
export CLIENT_SLACK_WORKSPACE=""                # Client Slack workspace

# Optional: Additional packages specific to this client
export ADDITIONAL_BREWS=""                      # Space-separated list of additional brew packages
export ADDITIONAL_CASKS=""                      # Space-separated list of additional cask packages
export ADDITIONAL_ZSH_PLUGINS=""                # Space-separated list of additional Oh My Zsh plugins
EOF

# Create personal config
cat > configs/client-personal.env << 'EOF'
# Personal Development Configuration
export DEV_USER="michael-dev"
export DEV_USER_FULLNAME="Michael Menard (Personal)"
export GIT_USER_NAME="Michael Menard"
export GIT_USER_EMAIL="1807918+michael-menard@users.noreply.github.com"
export GIT_SIGNING_KEY=""
export SSH_KEY_NAME="id_ed25519_personal"
export SSH_KEY_COMMENT="1807918+michael-menard@users.noreply.github.com"
export SSH_HOST_ALIAS="github-personal"
export GITHUB_USERNAME="michael-menard"
export DEFAULT_REMOTE_HOST="github-personal"
export CLIENT_NAME="Personal Development"
export CLIENT_SHORT="personal"
export WORK_DIR_NAME="personal"
export DEFAULT_EDITOR="code"
export DEFAULT_BROWSER="brave-browser"
export PROJECT_NAMESPACE="personal"
export ZSH_THEME="robbyrussell"
export PROMPT_CONTEXT="PERSONAL"
export AWS_PROFILE="personal"
export AWS_REGION="us-east-1"
export AWS_OUTPUT="json"
export MCP_GITHUB_TOKEN=""  # User will set this
export MCP_ENABLE_DIRECTORY="true"
export MCP_ENABLE_GITHUB="true"
export MCP_ENABLE_WEB="true"
export MCP_ALLOWED_DIRECTORIES="~/Development/personal,~/Documents/Projects/personal"
export ADDITIONAL_ZSH_PLUGINS="thefuck z aws"
EOF

# Create example client config
cat > configs/client-acme-example.env << 'EOF'
# Example: Acme Corp Configuration
export DEV_USER="michael-acme"
export DEV_USER_FULLNAME="Michael Menard (Acme Corp)"
export GIT_USER_NAME="Michael Menard"
export GIT_USER_EMAIL="michael@acme-corp.com"
export SSH_KEY_NAME="id_ed25519_acme"
export SSH_KEY_COMMENT="michael@acme-corp.com"
export SSH_HOST_ALIAS="github-acme"
export CLIENT_NAME="Acme Corp"
export CLIENT_SHORT="acme"
export WORK_DIR_NAME="acme"
export DEFAULT_EDITOR="code"
export ZSH_THEME="robbyrussell"
export PROMPT_CONTEXT="ACME"
export AWS_PROFILE="acme"
export AWS_REGION="us-west-2"
export AWS_OUTPUT="json"
export MCP_GITHUB_TOKEN=""  # User will set this
export MCP_ENABLE_DIRECTORY="true"
export MCP_ENABLE_GITHUB="true"
export MCP_ALLOWED_DIRECTORIES="~/Development/acme,~/Documents/Projects/acme"
export ADDITIONAL_CASKS="figma"
export ADDITIONAL_ZSH_PLUGINS="aws docker-compose"
EOF

echo -e "${GREEN}  ✓${NC} Created client configuration templates"
