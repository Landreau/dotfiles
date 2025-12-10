# 🎨 Dotfiles

My personal development environment configuration for Pop!_OS. 

![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white)
![C++](https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)
![Rust](https://img.shields.io/badge/rust-%23000000.svg?style=for-the-badge&logo=rust&logoColor=white)

## ✨ Features

### 🎯 Neovim Configuration

- **Theme**: Rose Pine Main with transparency
- **LSP Support**: C/C++, Rust, Python, Java
- **Completion**: Smart autocompletion with snippets
- **File Navigation**: Telescope fuzzy finder + nvim-tree
- **Git Integration**: Gitsigns with visual indicators
- **UI Enhancements**: Bufferline, lualine, alpha dashboard
- **Code Tools**: Auto-pairs, surround, commenting, todo-comments

### 📦 Included Configurations

- **Neovim**:  Complete IDE setup
- **Shell**: Bash/Zsh configurations
- **Git**: Global gitconfig
- **Terminal**: St/WezTerm (if used)

## 🚀 Quick Installation

```bash
# Clone the repository
git clone https://github.com/Landreau/dotfiles.git ~/dotfiles

# Run the installation script
cd ~/dotfiles
./install.sh
```

The script will create symlinks from your home directory to the dotfiles repository. 

## 📋 Manual Installation

If you prefer to install manually:

```bash
# Neovim
ln -sf ~/dotfiles/config/nvim ~/. config/nvim

# Shell configs
ln -sf ~/dotfiles/home/. zshrc ~/.zshrc
```

## 🔧 Dependencies

### System Packages (Pop!_OS/Ubuntu)

```bash
# Update system
sudo apt update && sudo apt upgrade

# Essential tools
sudo apt install git curl wget build-essential

# Neovim (latest version recommended)
sudo apt install neovim

# Programming languages
sudo apt install gcc g++ clang cmake
sudo apt install rustc cargo
sudo apt install python3 python3-pip python3-venv
sudo apt install openjdk-17-jdk openjdk-17-jre

# CLI tools
sudo apt install ripgrep fd-find
sudo apt install tree htop
```

### Nerd Font Installation

Required for icons in Neovim: 

```bash
# Create fonts directory
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

# Download JetBrainsMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip

# Extract and cleanup
unzip JetBrainsMono.zip
rm JetBrainsMono. zip

# Refresh font cache
fc-cache -fv
```

**Important**: Configure your terminal to use "JetBrainsMono Nerd Font". 

### Neovim Plugins

Plugins are automatically installed on first launch via Lazy.nvim.

```bash
# Open Neovim
nvim

# Plugins will install automatically
# Then install LSP servers
:Mason
```

Install these LSP servers in Mason: 
- `clangd` (C/C++)
- `rust_analyzer` (Rust)
- `pyright` (Python)
- `jdtls` (Java)

## ⌨️ Key Bindings

### General

| Keybinding | Action |
|------------|--------|
| `Space` | Leader key |
| `Space + e` | Toggle file explorer |
| `Space + ff` | Find files |
| `Space + fg` | Live grep (search in files) |
| `Space + fb` | Find buffers |
| `Tab` | Next buffer |
| `Shift + Tab` | Previous buffer |
| `Space + x` | Close buffer |

### LSP

| Keybinding | Action |
|------------|--------|
| `gd` | Go to definition |
| `gr` | Show references |
| `gD` | Go to declaration |
| `gi` | Go to implementation |
| `K` | Show hover documentation |
| `Space + rn` | Rename symbol |
| `Space + ca` | Code actions |
| `Space + f` | Format code |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Editing

| Keybinding | Action |
|------------|--------|
| `gcc` | Toggle line comment |
| `gc` (visual) | Toggle comment selection |
| `ys{motion}{char}` | Surround with character |
| `cs{old}{new}` | Change surrounding |
| `ds{char}` | Delete surrounding |

### Terminal

| Keybinding | Action |
|------------|--------|
| `Ctrl + \` | Toggle terminal |

### Snippets

| Keybinding | Action |
|------------|--------|
| `Tab` | Expand snippet / Next field |
| `Shift + Tab` | Previous field |
| `Ctrl + k` | Jump forward in snippet |
| `Ctrl + j` | Jump backward in snippet |

## 🎨 Customization

### Change Theme

Edit `~/.config/nvim/lua/plugins/ui. lua`:

```lua
variant = 'moon',  -- Options: 'main', 'moon', 'dawn'
```

### Adjust Transparency

In `ui.lua`, modify: 

```lua
styles = {
  transparency = true,  -- Set to false to disable
},
```

### Add Custom Snippets

Edit `~/.config/nvim/lua/config/snippets.lua` to add your own snippets. 

## 🐛 Troubleshooting

### LSP not working

```bash
# Check LSP status in Neovim
:LspInfo

# Reinstall LSP servers
:Mason
```

### Icons not showing

Make sure you have a Nerd Font installed and configured in your terminal.

### Transparency not working

Enable transparency in your terminal emulator settings (usually 80-85% opacity).

## 🤝 Contributing

Feel free to fork this repository and adapt it to your needs! 

## 📄 License

MIT License - Feel free to use and modify! 

## 👤 Author

**Landreau**

- GitHub: [@Landreau](https://github.com/Landreau)

---

⭐ If you find this useful, consider giving it a star! 
