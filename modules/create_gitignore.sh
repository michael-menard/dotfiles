#!/bin/bash
# modules/create_gitignore.sh
# Creates the .gitignore file for the dotfiles repository

cat > .gitignore << 'EOF'
# Ignore generated configurations (they're created by bootstrap)
git/.gitconfig
ssh/.ssh/config
zsh/.zshrc
zsh/.zsh_aliases
zsh/.zshenv
aws/.aws/config
mcp/.config/claude/mcp_servers.json

# Ignore sensitive files
*.local
.env
.env.local
aws/.aws/credentials

# Ignore SSH keys
ssh/.ssh/id_*
ssh/.ssh/known_hosts
ssh/.ssh/authorized_keys

# Ignore OS files
.DS_Store
Thumbs.db
*.swp
*.swo
*~

# Ignore backup directories
.dotfiles_backup_*

# Ignore client-specific secrets
configs/*-secrets.env
configs/*-mcp-tokens.env

# Ignore modules directory (will be copied during generation)
modules/
EOF

echo -e "${GREEN}  ✓${NC} Created .gitignore"
