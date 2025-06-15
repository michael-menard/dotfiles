#!/bin/bash
# modules/create_bootstrap.sh
# Creates the main bootstrap script for setting up the development environment

cat > bootstrap.sh << 'EOF'
#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting macOS Bootstrap Process${NC}"

# Check if config is loaded, if not use defaults
if [ -z "$DEV_USER" ]; then
    echo -e "${YELLOW}⚠️  No client config detected. Using default values.${NC}"
    echo -e "${BLUE}💡 To use client-specific config: ${YELLOW}source configs/client-[name].env && ./bootstrap.sh${NC}"
    
    # Default values
    DEV_USER="michael-dev"
    DEV_USER_FULLNAME="Michael Menard (Development)"
    GIT_USER_NAME="Michael Menard"
    GIT_USER_EMAIL="1807918+michael-menard@users.noreply.github.com"
    SSH_KEY_NAME="id_ed25519"
    SSH_KEY_COMMENT="1807918+michael-menard@users.noreply.github.com"
    SSH_HOST_ALIAS="github.com"
    CLIENT_NAME="Personal Development"
    CLIENT_SHORT="personal"
    WORK_DIR_NAME="personal"
    DEFAULT_EDITOR="code"
    ZSH_THEME="robbyrussell"
    PROMPT_CONTEXT="DEV"
    AWS_PROFILE="personal"
    AWS_REGION="us-east-1"
    MCP_ENABLE_DIRECTORY="true"
    MCP_ENABLE_GITHUB="true"
    MCP_ALLOWED_DIRECTORIES="~/Development/personal"
else
    echo -e "${GREEN}✅ Client config loaded: ${CLIENT_NAME}${NC}"
    echo -e "${BLUE}📧 Git Email: ${GIT_USER_EMAIL}${NC}"
    echo -e "${BLUE}👤 Dev User: ${DEV_USER}${NC}"
fi

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo -e "\n${BLUE}👤 Phase 1: Development User Profile Setup${NC}"
CURRENT_USER=$(whoami)

if [ "$CURRENT_USER" != "$DEV_USER" ]; then
    echo -e "${YELLOW}Creating development user profile for: ${CLIENT_NAME}${NC}"
    echo -e "${BLUE}This will create a separate user account: ${DEV_USER}${NC}"
    echo -e "${YELLOW}You'll need administrator privileges to continue.${NC}"
    read -p "Create development user '$DEV_USER'? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # Check if user already exists
        if id "$DEV_USER" &>/dev/null; then
            echo -e "${GREEN}✅ Development user '$DEV_USER' already exists${NC}"
        else
            # Create the user
            sudo dscl . -create /Users/$DEV_USER
            sudo dscl . -create /Users/$DEV_USER UserShell /bin/zsh
            sudo dscl . -create /Users/$DEV_USER RealName "$DEV_USER_FULLNAME"
            sudo dscl . -create /Users/$DEV_USER UniqueID 502
            sudo dscl . -create /Users/$DEV_USER PrimaryGroupID 20
            sudo dscl . -create /Users/$DEV_USER NFSHomeDirectory /Users/$DEV_USER
            
            # Set password
            echo -e "${YELLOW}Setting password for development user...${NC}"
            sudo passwd $DEV_USER
            
            # Create home directory
            sudo createhomedir -c -u $DEV_USER
            
            echo -e "${GREEN}✅ Development user '$DEV_USER' created for ${CLIENT_NAME}${NC}"
        fi
        
        echo -e "${YELLOW}⚠️  Please log out and log in as '$DEV_USER' to continue setup.${NC}"
        echo -e "${BLUE}After logging in as '$DEV_USER', run:${NC}"
        echo -e "${YELLOW}  source ~/.dotfiles/configs/client-${CLIENT_SHORT}.env && ./bootstrap.sh${NC}"
        exit 0
    else
        echo -e "${BLUE}Continuing with current user '$CURRENT_USER'${NC}"
    fi
else
    echo -e "${GREEN}✅ Running as development user '$DEV_USER' for ${CLIENT_NAME}${NC}"
fi

echo -e "\n${BLUE}📋 Phase 2: Installing Homebrew${NC}"
if ! command_exists brew; then
    echo -e "${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}✅ Homebrew already installed${NC}"
fi

echo -e "\n${BLUE}📦 Phase 3: Installing Applications${NC}"
if [ -f "Brewfile" ]; then
    echo -e "${YELLOW}Installing applications from Brewfile...${NC}"
    brew bundle install --file=Brewfile
    
    # Install additional client-specific packages
    if [ -n "$ADDITIONAL_BREWS" ]; then
        echo -e "${YELLOW}Installing additional brew packages for ${CLIENT_NAME}...${NC}"
        brew install $ADDITIONAL_BREWS
    fi
    
    if [ -n "$ADDITIONAL_CASKS" ]; then
        echo -e "${YELLOW}Installing additional cask packages for ${CLIENT_NAME}...${NC}"
        brew install --cask $ADDITIONAL_CASKS
    fi
    
    echo -e "${GREEN}✅ Applications installed${NC}"
else
    echo -e "${RED}❌ Brewfile not found${NC}"
fi

echo -e "\n${BLUE}🐚 Phase 4: Setting up Zsh and Oh My Zsh${NC}"
# Set zsh as default shell if not already
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/local/bin/zsh" ] && [ "$SHELL" != "/opt/homebrew/bin/zsh" ]; then
    echo -e "${YELLOW}Setting zsh as default shell...${NC}"
    if command_exists brew; then
        ZSH_PATH=$(brew --prefix)/bin/zsh
        if [ -f "$ZSH_PATH" ] && ! grep -q "$ZSH_PATH" /etc/shells; then
            echo "$ZSH_PATH" | sudo tee -a /etc/shells
        fi
        chsh -s "$ZSH_PATH"
    else
        chsh -s /bin/zsh
    fi
    echo -e "${GREEN}✅ Zsh set as default shell${NC}"
fi

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo -e "${GREEN}✅ Oh My Zsh installed${NC}"
else
    echo -e "${GREEN}✅ Oh My Zsh already installed${NC}"
fi

echo -e "\n${BLUE}🔧 Phase 5: Setting up asdf version manager${NC}"
if ! command_exists asdf; then
    echo -e "${YELLOW}Installing asdf via Homebrew...${NC}"
    brew install asdf
fi

# Add asdf to shell
if ! grep -q "asdf" ~/.zshrc 2>/dev/null; then
    echo -e "${YELLOW}Adding asdf to shell configuration...${NC}"
    echo '. $(brew --prefix asdf)/libexec/asdf.sh' >> ~/.zshrc
fi

# Source asdf for current session
if command_exists brew; then
    source "$(brew --prefix asdf)/libexec/asdf.sh"
fi

# Install Node.js via asdf
echo -e "${YELLOW}Installing Node.js via asdf...${NC}"
if ! asdf plugin list | grep -q nodejs; then
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
fi

# Install latest LTS Node.js
NODEJS_VERSION=$(asdf list-all nodejs | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | grep -v 'rc\|alpha\|beta' | tail -1)
if [ -n "$NODEJS_VERSION" ]; then
    echo -e "${YELLOW}Installing Node.js $NODEJS_VERSION...${NC}"
    asdf install nodejs $NODEJS_VERSION
    asdf global nodejs $NODEJS_VERSION
    echo -e "${GREEN}✅ Node.js $NODEJS_VERSION installed and set as global${NC}"
fi

# Install Python via asdf
echo -e "${YELLOW}Installing Python via asdf...${NC}"
if ! asdf plugin list | grep -q python; then
    asdf plugin add python https://github.com/asdf-vm/asdf-python.git
fi

PYTHON_VERSION=$(asdf list-all python | grep -E '^3\.[0-9]+\.[0-9]+$' | grep -v 'a\|b\|rc' | tail -1)
if [ -n "$PYTHON_VERSION" ]; then
    echo -e "${YELLOW}Installing Python $PYTHON_VERSION...${NC}"
    asdf install python $PYTHON_VERSION
    asdf global python $PYTHON_VERSION
    echo -e "${GREEN}✅ Python $PYTHON_VERSION installed and set as global${NC}"
fi

echo -e "\n${BLUE}📁 Phase 6: Creating Development Directory Structure${NC}"
mkdir -p ~/Development/{$WORK_DIR_NAME,playground,tools}
mkdir -p ~/Screenshots
mkdir -p ~/Documents/Projects/$CLIENT_SHORT
echo -e "${GREEN}✅ Development directories created for ${CLIENT_NAME}${NC}"

echo -e "\n${GREEN}🎉 Bootstrap complete for ${CLIENT_NAME}!${NC}"
echo -e "${BLUE}📝 Next steps:${NC}"
echo -e "   1. Restart your terminal (or run: ${YELLOW}exec zsh${NC})"
echo -e "   2. Test Git configuration: ${YELLOW}git config --list${NC}"
echo -e "   3. Configure AWS credentials: ${YELLOW}aws configure --profile $AWS_PROFILE${NC}"
echo -e "   4. Set up MCP GitHub token: ${YELLOW}export MCP_GITHUB_TOKEN=your_token${NC}"
echo -e "   5. Initialize new projects: ${YELLOW}./scripts/init-project.sh <project-name>${NC}"
echo -e "   6. Run health check: ${YELLOW}./scripts/health-check.sh${NC}"

echo -e "\n${BLUE}🏢 Client Environment Summary:${NC}"
echo -e "   👤 User: $DEV_USER"
echo -e "   📧 Git Email: $GIT_USER_EMAIL"
echo -e "   ☁️  AWS Profile: $AWS_PROFILE"
echo -e "   🤖 AI Context: Client-specific configurations ready"
echo -e "   🔧 Languages: Node.js $(node --version 2>/dev/null || echo 'pending'), Python $(python --version 2>/dev/null || echo 'pending')"
EOF

chmod +x bootstrap.sh
echo -e "${GREEN}  ✓${NC} Created bootstrap.sh"
