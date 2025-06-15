#!/bin/bash

# Main Dotfiles Generator
# Orchestrates the creation of a comprehensive dotfiles structure

set -e  # Exit on any error

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODULES_DIR="$SCRIPT_DIR/modules"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ASCII Art Header
echo -e "${CYAN}"
cat << 'EOF'
╔══════════════════════════════════════════════════════════════════╗
║                                                                  ║
║   ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗  ║
║   ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝  ║
║   ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗  ║
║   ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║  ║
║   ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║  ║
║   ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝  ║
║                                                                  ║
║           Professional Development Environment Generator          ║
║                     by Michael Menard                           ║
╚══════════════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}"

echo -e "${BLUE}🚀 Creating comprehensive dotfiles structure...${NC}"

# Source utility functions
source "$MODULES_DIR/utils.sh"

# Check for existing installation
check_existing_installation

# Create main directory structure
echo -e "${BLUE}📁 Creating directory structure...${NC}"
source "$MODULES_DIR/create_directories.sh"

# Create core configuration files
echo -e "${BLUE}📝 Creating core configuration files...${NC}"
source "$MODULES_DIR/create_gitignore.sh"
source "$MODULES_DIR/create_brewfile.sh"

# Create client configuration system
echo -e "${BLUE}⚙️ Creating client configuration system...${NC}"
source "$MODULES_DIR/create_client_configs.sh"

# Create AI integration files
echo -e "${BLUE}🤖 Creating AI integration files...${NC}"
source "$MODULES_DIR/create_ai_prompts.sh"

# Create utility scripts
echo -e "${BLUE}🔧 Creating utility scripts...${NC}"
source "$MODULES_DIR/create_scripts.sh"

# Create main bootstrap script
echo -e "${BLUE}🚀 Creating main bootstrap script...${NC}"
source "$MODULES_DIR/create_bootstrap.sh"

# Create documentation
echo -e "${BLUE}📚 Creating documentation...${NC}"
source "$MODULES_DIR/create_readme.sh"

# Display final summary
source "$MODULES_DIR/display_summary.sh"
