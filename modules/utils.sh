#!/bin/bash
# modules/utils.sh
# Utility functions used across the dotfiles generator

# Function to check if existing dotfiles directory exists and handle it
check_existing_installation() {
    if [ -d "$HOME/.dotfiles" ]; then
        echo -e "${YELLOW}⚠️  ~/.dotfiles already exists!${NC}"
        echo -e "${BLUE}What would you like to do?${NC}"
        echo -e "   ${GREEN}1)${NC} Backup existing and create new"
        echo -e "   ${GREEN}2)${NC} Overwrite existing (destructive)"
        echo -e "   ${GREEN}3)${NC} Exit without changes"
        echo ""
        read -p "Choose an option (1-3): " -n 1 -r
        echo
        
        case $REPLY in
            1)
                BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
                echo -e "${YELLOW}📦 Backing up to $BACKUP_DIR${NC}"
                mv "$HOME/.dotfiles" "$BACKUP_DIR"
                echo -e "${GREEN}✅ Backup created successfully${NC}"
                ;;
            2)
                echo -e "${RED}🗑️  Removing existing ~/.dotfiles${NC}"
                rm -rf "$HOME/.dotfiles"
                echo -e "${YELLOW}⚠️  Existing dotfiles removed${NC}"
                ;;
            3)
                echo -e "${BLUE}👋 Exiting without changes${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}❌ Invalid option. Exiting to avoid overwriting${NC}"
                exit 1
                ;;
        esac
    fi
}

# Function to create a directory and log the action
create_dir() {
    local dir="$1"
    mkdir -p "$dir"
    echo -e "${GREEN}  ✓${NC} Created: $dir"
}

# Function to create a file with content and log the action
create_file() {
    local file="$1"
    local content="$2"
    echo "$content" > "$file"
    echo -e "${GREEN}  ✓${NC} Created: $file"
}

# Function to make a file executable
make_executable() {
    local file="$1"
    chmod +x "$file"
    echo -e "${GREEN}  ✓${NC} Made executable: $file"
}
