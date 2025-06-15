#!/bin/bash
# modules/display_summary.sh
# Displays the final summary and next steps

echo -e "\n${PURPLE}════════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}🎉 DOTFILES GENERATION COMPLETE! 🎉${NC}"
echo -e "${PURPLE}════════════════════════════════════════════════════════════════════${NC}"

echo -e "\n${BLUE}📊 Generated Structure Summary:${NC}"
echo -e "${GREEN}📁 Main Directory:${NC} ~/.dotfiles"

# Count generated files
config_count=$(find ~/.dotfiles/configs -name "*.env" 2>/dev/null | wc -l | tr -d ' ')
prompt_count=$(find ~/.dotfiles/ai/prompts -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
script_count=$(find ~/.dotfiles/scripts -name "*.sh" 2>/dev/null | wc -l | tr -d ' ')
brew_count=$(grep -c "^brew\|^cask" ~/.dotfiles/Brewfile 2>/dev/null || echo "0")

echo -e "${GREEN}📋 Configurations:${NC} $config_count client config templates"
echo -e "${GREEN}🤖 AI Prompts:${NC} $prompt_count reusable AI prompts"
echo -e "${GREEN}🔧 Scripts:${NC} $script_count utility scripts"
echo -e "${GREEN}📦 Packages:${NC} $brew_count Homebrew packages configured"
echo -e "${GREEN}🔧 Languages:${NC} Node.js and Python (via asdf)"

echo -e "\n${BLUE}🚀 Next Steps:${NC}"
echo -e "   1. ${YELLOW}cd ~/.dotfiles${NC}"
echo -e "   2. ${YELLOW}cp configs/client-template.env configs/client-yourname.env${NC}"
echo -e "   3. ${YELLOW}Edit configs/client-yourname.env with your details${NC}"
echo -e "   4. ${YELLOW}source configs/client-yourname.env && ./bootstrap.sh${NC}"
echo -e "   5. ${YELLOW}Run health check: ./scripts/health-check.sh${NC}"
echo -e "   6. ${YELLOW}Enjoy your AI-enhanced development environment!${NC}"

echo -e "\n${BLUE}🔧 Available Scripts:${NC}"
echo -e "   ${YELLOW}./bootstrap.sh${NC}                 - Main setup script"
echo -e "   ${YELLOW}./scripts/health-check.sh${NC}      - Environment health check"
echo -e "   ${YELLOW}./scripts/setup-mcp.sh${NC}         - Setup Claude MCP servers"
echo -e "   ${YELLOW}./scripts/init-project.sh${NC}      - Initialize new projects"
echo -e "   ${YELLOW}./scripts/switch-client.sh${NC}     - Switch between clients"

echo -e "\n${BLUE}🏢 Client Configuration Examples:${NC}"
echo -e "   ${YELLOW}Personal:${NC} source configs/client-personal.env && ./bootstrap.sh"
echo -e "   ${YELLOW}Client:${NC}   source configs/client-acme.env && ./bootstrap.sh"

echo -e "\n${BLUE}🔗 Initialize Git Repository (Optional):${NC}"
echo -e "   ${YELLOW}git init${NC}"
echo -e "   ${YELLOW}git add .${NC}"
echo -e "   ${YELLOW}git commit -m \"Initial dotfiles setup with modular architecture\"${NC}"
echo -e "   ${YELLOW}git remote add origin git@github.com:michael-menard/dotfiles.git${NC}"
echo -e "   ${YELLOW}git push -u origin main${NC}"

echo -e "\n${BLUE}🤖 AI Integration Ready:${NC}"
echo -e "   ✅ Cursor rules for TypeScript/React development"
echo -e "   ✅ AI prompt library for code review, debugging, refactoring"
echo -e "   ✅ Claude Desktop MCP configuration"
echo -e "   ✅ Client-specific AI context templates"

echo -e "\n${BLUE}🔐 Security Features:${NC}"
echo -e "   ✅ Client-isolated user accounts"
echo -e "   ✅ Separate SSH keys per client"
echo -e "   ✅ Isolated AWS profiles"
echo -e "   ✅ Restricted MCP filesystem access"

echo -e "\n${GREEN}✨ Your comprehensive development environment is ready to deploy!${NC}"
echo -e "${CYAN}Features: Client isolation • AI integration • AWS ready • MCP enabled • asdf version management • 50+ dev tools${NC}"

echo -e "\n${PURPLE}════════════════════════════════════════════════════════════════════${NC}"

# Display file tree structure
echo -e "\n${BLUE}📂 Generated Directory Structure:${NC}"
if command -v tree >/dev/null 2>&1; then
    tree ~/.dotfiles -I 'modules' -L 3
else
    find ~/.dotfiles -type d -not -path "*/modules*" | head -20 | sed 's|[^/]*/|  |g'
fi

echo -e "\n${YELLOW}💡 Pro Tips:${NC}"
echo -e "   • Use different terminal tabs/windows for different clients"
echo -e "   • Set up client-specific VS Code workspaces"
echo -e "   • Configure client-specific Git signing keys for security"
echo -e "   • Use the health-check script regularly to verify your setup"
echo -e "   • Customize the AI prompts in ai/prompts/ for your workflow"

echo -e "\n${GREEN}Happy coding! 🚀${NC}"
