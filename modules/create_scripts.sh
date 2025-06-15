#!/bin/bash
# modules/create_scripts.sh
# Creates utility scripts for the dotfiles system

# Create MCP setup script
cat > scripts/setup-mcp.sh << 'EOF'
#!/bin/bash
# MCP Setup and Management Script for Claude Desktop

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔌 MCP (Model Context Protocol) Setup for Claude Desktop${NC}"

# Check if Claude Desktop is installed
if [ ! -d "/Applications/Claude.app" ]; then
    echo -e "${YELLOW}⚠️  Claude Desktop not found. Please install Claude Desktop first.${NC}"
    echo -e "${BLUE}Download from: https://claude.ai/download${NC}"
    exit 1
fi

# Check if Node.js is installed
if ! command -v node >/dev/null 2>&1; then
    echo -e "${RED}❌ Node.js is required for MCP servers but not found.${NC}"
    echo -e "${YELLOW}Installing Node.js via Homebrew...${NC}"
    brew install node
fi

echo -e "\n${BLUE}📋 Available MCP Servers:${NC}"
echo -e "   1. 📁 Filesystem - Secure file system access"
echo -e "   2. 🐙 GitHub - Repository integration" 
echo -e "   3. 🔍 Brave Search - Web search capabilities"
echo -e "   4. 🗃️  Git - Git repository operations"
echo -e "   5. 🧠 Memory - Persistent conversation memory"

# Test MCP servers
echo -e "\n${BLUE}🚀 Testing MCP Servers:${NC}"
echo -e "${YELLOW}Testing filesystem server...${NC}"
if npx -y @modelcontextprotocol/server-filesystem --version >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Filesystem server available${NC}"
else
    echo -e "${RED}❌ Filesystem server installation failed${NC}"
fi

echo -e "\n${GREEN}🎉 MCP setup complete!${NC}"
echo -e "${YELLOW}Restart Claude Desktop to load MCP servers${NC}"
EOF

# Create project initialization script
cat > scripts/init-project.sh << 'EOF'
#!/bin/bash
# Initialize new project with full configuration setup

PROJECT_NAME=$1
if [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project-name>"
    exit 1
fi

# Check if client environment is loaded
if [ -z "$CLIENT_SHORT" ]; then
