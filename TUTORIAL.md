# Neovim Configuration Tutorial

This is a complete guide to your custom Neovim configuration.

## 📁 Project Structure

```md
~/.config/nvim/
├── init.lua                    # Main entry point
├── lazy-lock.json             # Plugin version lock file
├── lua/
│   ├── vim-options.lua        # Editor settings
│   ├── keymaps.lua            # Custom keybindings
│   └── plugins/               # Plugin configurations
│       ├── catppuccin.lua     # Color scheme
│       ├── cmp.lua            # Autocompletion
│       ├── lsp.lua            # Language Server Protocol
│       ├── lualine.lua        # Status line
│       ├── mason.lua          # LSP/Tool installer
│       ├── neotree.lua        # File explorer
│       ├── none-ls.lua        # Linting/Formatting
│       ├── telescope.lua      # Fuzzy finder
│       └── treesitter.lua     # Syntax highlighting
```

---

## 🚀 Getting Started

### What is Neovim?

Neovim is a highly configurable text editor built to enable efficient text editing. Your config uses:

- **lazy.nvim** - Plugin manager (handles installing/updating plugins)
- **Lua** - Configuration language (faster and more powerful than Vimscript)

### How It Works

1. **init.lua** - This file runs first when Neovim starts
   - Sets leader key to `Space`
   - Loads your options and keymaps
   - Bootstraps lazy.nvim plugin manager
   - Tells lazy.nvim to load all plugins from `lua/plugins/` folder

2. **Plugin Loading** - lazy.nvim automatically loads all `.lua` files in `lua/plugins/`
   - Each file returns a table describing a plugin
   - Plugins can be lazy-loaded (only when needed) or loaded immediately

---

## ⌨️ Essential Keybindings

### Leader Key

Your leader key is **Space** - press Space followed by another key for custom commands.

### Window Navigation

- `Ctrl+h` - Move to left window
- `Ctrl+j` - Move to window below
- `Ctrl+k` - Move to window above
- `Ctrl+l` - Move to right window

### File Explorer (Neo-tree)

- `Ctrl+n` - Toggle file tree on the left
- `Space+e` - Alternative to toggle file tree

### Fuzzy Finder (Telescope)

- `Space+ff` - Find files
- `Space+fg` - Live grep (search in files)
- `Space+fb` - Find open buffers

### LSP (Code Intelligence)

When editing code files:

- `gd` - Go to definition
- `gr` - Show references
- `K` - Hover documentation
- `Space+rn` - Rename symbol
- `Space+ca` - Code actions

### Plugin Manager

- `Space+l` - Open Lazy plugin manager
- `Ctrl+p` - Alternative to open Lazy

### Other

- `Esc` - Clear search highlighting
- `Space+q` - Open diagnostic list

---

## 🔧 Configuration Files Explained

### 1. init.lua

```lua
vim.g.mapleader = " "  -- Set Space as leader key
require("vim-options")  -- Load editor settings
require("keymaps")      -- Load key mappings
-- ... Bootstrap lazy.nvim plugin manager
require("lazy").setup("plugins")  -- Load all plugins
```

### 2. lua/vim-options.lua

Editor behavior settings:

- Line numbers (absolute + relative)
- Tab settings (2 spaces)
- No swap files, but undo history
- Smart search (case-insensitive)
- Mouse support
- System clipboard integration

### 3. lua/keymaps.lua

Custom keyboard shortcuts for:

- Window navigation
- Opening Lazy plugin manager
- Diagnostics

### 4. Plugin Configurations

#### catppuccin.lua - Color Scheme

Beautiful pastel theme with Mocha flavor.

#### cmp.lua - Autocompletion

Provides intelligent code completion as you type.

- `Ctrl+Space` - Trigger completion manually
- `Ctrl+b`/`Ctrl+f` - Scroll docs
- `Ctrl+e` - Close completion
- `Enter` - Confirm selection
- `Ctrl+n`/`Ctrl+p` - Navigate suggestions

#### lsp.lua - Language Servers

**NEW API (Neovim 0.11+)**: Uses `vim.lsp.enable()` instead of deprecated `lspconfig`.

Provides intelligent features for:

- C/C++ (clangd)
- Go (gopls)
- TypeScript/JavaScript (ts_ls)
- Rust (rust_analyzer)
- Lua (lua_ls) - with Neovim API awareness
- Python (pyright)

#### mason.lua - Tool Installer

UI for installing LSP servers, linters, formatters.
Access with `:Mason`

#### neotree.lua - File Explorer

Tree-view file explorer on the left side.

- `lazy = false` - Loads immediately (not lazy-loaded)
- Git integration enabled
- Follows current file

#### none-ls.lua - Linting & Formatting

Integrates external tools as LSP sources.

- Stylua (Lua formatter)
- Black (Python formatter)
- Prettier (JS/TS/JSON formatter)

#### telescope.lua - Fuzzy Finder

Fast file/text finder with live preview.

- `Ctrl+j`/`Ctrl+k` - Navigate results

#### treesitter.lua - Syntax Highlighting

Modern syntax highlighting engine.

- Better than regex-based highlighting
- Enables code folding, indentation
- Auto-installs parsers for listed languages

---

## 🔨 Common Tasks

### Installing a New Plugin

1. Create a new file in `lua/plugins/`, e.g., `newplugin.lua`
2. Add the plugin configuration:

```lua
return {
  "author/plugin-name",
  config = function()
    require("plugin-name").setup({})
  end,
}
```

1. Restart Neovim or run `:Lazy sync`

### Adding a Language Server

1. Open `:Mason`
2. Search for your LSP server (press `/` to search)
3. Press `i` to install
4. Add to `lua/plugins/lsp.lua`:

```lua
local servers = {
  -- ... existing servers
  your_lsp = {},  -- Add this line
}
```

### Adding a Keybinding

Edit `lua/keymaps.lua`:

```lua
vim.keymap.set("n", "<leader>x", "<cmd>YourCommand<CR>", 
  { noremap = true, silent = true, desc = "Description" })
```

---

## 🐛 Troubleshooting

### Lazy Dashboard Won't Open

If `Ctrl+p` doesn't work:

1. Try `Space+l` instead
2. Or type `:Lazy` manually
3. The `vim.schedule()` wrapper helps prevent timing issues

### LSP Not Working

1. Check if server is installed: `:Mason`
2. Check if it's configured in `lua/plugins/lsp.lua`
3. View LSP logs: `:LspLog`

### Plugin Not Loading

1. Check `:Lazy` - see if it's installed
2. Look for errors: `:checkhealth`
3. View all messages: `:messages`

### Treesitter Highlighting Not Working

1. Check if parser is installed: `:TSInstallInfo`
2. Install missing parser: `:TSInstall <language>`
3. Restart Neovim

---

## 📚 Learning More

### Neovim Commands

- `:help <topic>` - Built-in help (e.g., `:help vim.lsp`)
- `:checkhealth` - Diagnose configuration issues
- `:Lazy` - Manage plugins
- `:Mason` - Manage LSP/tools

### Key Concepts

**Lazy Loading**: Plugins load only when needed, speeding up startup.

- `lazy = false` - Load immediately
- `cmd = "Command"` - Load when command is used
- `event = "BufRead"` - Load when event fires
- `keys = {...}` - Load when key is pressed

**LSP (Language Server Protocol)**: Provides IDE features.

- Autocomplete
- Go to definition
- Error checking
- Refactoring

**Treesitter**: Modern parsing for syntax highlighting.

- More accurate than regex patterns
- Enables advanced text objects

---

## 🎯 Next Steps

1. **Get comfortable** - Practice the keybindings for a week
2. **Explore Telescope** - `Space+ff` is your best friend
3. **Learn LSP features** - `gd`, `gr`, `K` while coding
4. **Customize** - Add your own keybindings and plugins
5. **Read `:help`** - Neovim's documentation is excellent

---

## 📝 Notes

- Your config uses **Neovim 0.11+ APIs** (modern and future-proof)
- All plugins use **lazy.nvim** for optimal performance
- **Leader key is Space** - most custom commands start with it
- Files auto-format on save (via none-ls.lua)

---

**Happy coding!** 🚀

For questions, check:

- `:help` in Neovim
- [Neovim Documentation](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
