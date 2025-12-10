#!/bin/bash

# Dotfiles installation script
# Author: Landreau

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the dotfiles directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║    🚀 Dotfiles Installation Script    ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}📂 Dotfiles directory: $DOTFILES_DIR${NC}"
echo ""

# Function to create symlinks
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo -e "${YELLOW}⚠️  $target already exists${NC}"
        read -p "Do you want to replace it? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$target"
            ln -sf "$source" "$target"
            echo -e "${GREEN}✅ Created symlink: $target -> $source${NC}"
        else
            echo -e "${YELLOW}⏭️  Skipped:  $target${NC}"
        fi
    else
        ln -sf "$source" "$target"
        echo -e "${GREEN}✅ Created symlink: $target -> $source${NC}"
    fi
}

# Create necessary directories
mkdir -p ~/. config

# Install Neovim config
if [ -d "$DOTFILES_DIR/config/nvim" ]; then
    echo -e "\n${BLUE}📝 Installing Neovim configuration...${NC}"
    create_symlink "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim"
fi

# Install Alacritty config
if [ -d "$DOTFILES_DIR/config/alacritty" ]; then
    echo -e "\n${BLUE}🖥️  Installing Alacritty configuration...${NC}"
    create_symlink "$DOTFILES_DIR/config/alacritty" "$HOME/.config/alacritty"
fi

# Install WezTerm config
if [ -d "$DOTFILES_DIR/config/wezterm" ]; then
    echo -e "\n${BLUE}🖥️  Installing WezTerm configuration... ${NC}"
    create_symlink "$DOTFILES_DIR/config/wezterm" "$HOME/.config/wezterm"
fi

# Install Zsh config
if [ -d "$DOTFILES_DIR/config/zsh" ]; then
    echo -e "\n${BLUE}🐚 Installing Zsh configuration...${NC}"
    create_symlink "$DOTFILES_DIR/config/zsh" "$HOME/.config/zsh"
fi

# Install shell configs
if [ -f "$DOTFILES_DIR/home/.bashrc" ]; then
    echo -e "\n${BLUE}🐚 Installing . bashrc...${NC}"
    create_symlink "$DOTFILES_DIR/home/.bashrc" "$HOME/.bashrc"
fi

if [ -f "$DOTFILES_DIR/home/.zshrc" ]; then
    echo -e "\n${BLUE}🐚 Installing .zshrc...${NC}"
    create_symlink "$DOTFILES_DIR/home/.zshrc" "$HOME/.zshrc"
fi

if [ -f "$DOTFILES_DIR/home/.gitconfig" ]; then
    echo -e "\n${BLUE}🔧 Installing .gitconfig...${NC}"
    create_symlink "$DOTFILES_DIR/home/. gitconfig" "$HOME/.gitconfig"
fi

echo ""
echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║      ✨ Installation Complete!  ✨       ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}💡 Next steps:${NC}"
echo -e "   1. Install dependencies (see README.md)"
echo -e "   2. Open Neovim and let Lazy. nvim install plugins"
echo -e "   3. Run ${BLUE}: Mason${NC} in Neovim to install LSP servers"
echo ""
