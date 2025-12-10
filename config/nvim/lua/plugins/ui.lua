return {
  -- Rose Pine (thème élégant avec transparence)
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = 'main',  -- auto, main, moon, dawn
        dark_variant = 'main',
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        
        styles = {
          bold = true,
          italic = true,
          transparency = true,  -- ✅ ACTIVE LA TRANSPARENCE
        },
        
        groups = {
          border = 'muted',
          link = 'iris',
          panel = 'surface',
          error = 'love',
          hint = 'iris',
          info = 'foam',
          warn = 'gold',
        },
        
        highlight_groups = {
          -- Rend le fond transparent
          Normal = { bg = 'none' },
          NormalFloat = { bg = 'none' },
          NormalNC = { bg = 'none' },
          CursorLine = { bg = 'none', blend = 10 },
          SignColumn = { bg = 'none' },
          StatusLine = { bg = 'none' },
          
          -- Transparence pour Telescope
          TelescopeNormal = { bg = 'none' },
          TelescopeBorder = { bg = 'none' },
          
          -- Transparence pour les fenêtres flottantes
          FloatBorder = { bg = 'none' },
          
          -- Transparence pour nvim-tree
          NvimTreeNormal = { bg = 'none' },
          NvimTreeNormalNC = { bg = 'none' },
          NvimTreeEndOfBuffer = { bg = 'none' },
          
          -- Transparence pour bufferline
          BufferLineFill = { bg = 'none' },
        }
      })
      
      vim.cmd('colorscheme rose-pine')
    end,
  },

  -- Alternative: Catppuccin (si tu préfères)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    enabled = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,  -- ✅ Transparence pour Catppuccin
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          mason = true,
          telescope = true,
        }
      })
      vim.cmd('colorscheme catppuccin')
    end,
  },

  -- Indent guides (lignes d'indentation colorées)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",
          tab_char = "│",
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = false,
        },
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
          },
        },
      })
    end,
  },

  -- Coloriser les couleurs (affiche les codes couleurs)
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  -- Notifications stylées
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      
      notify.setup({
        background_colour = "#000000",
        fps = 60,
        render = "compact",
        timeout = 2000,
        top_down = true,
        minimum_width = 50,
        max_width = 80,
        stages = "fade",
      })
      
      vim.notify = notify
      
      -- Filtre pour ignorer certains messages
      local banned_messages = {
        "mason-lspconfig",
        "Treesitter parser",
        "has been",
        "was successfully",
      }
      
      vim.notify = function(msg, ...)
        for _, banned in ipairs(banned_messages) do
          if string.find(msg, banned) then
            return
          end
        end
        notify(msg, ...)
      end
    end,
  },

  -- Buffer line (onglets stylés avec transparence)
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "slant",
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          color_icons = true,
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left"
            }
          },
        },
        highlights = {
          fill = {
            bg = 'none',  -- ✅ Transparence pour bufferline
          },
        },
      })
      
      -- Keymaps pour naviguer entre les buffers
      vim.keymap. set('n', '<Tab>', ':BufferLineCycleNext<CR>', { silent = true })
      vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { silent = true })
      vim.keymap.set('n', '<leader>x', ':bdelete<CR>', { desc = 'Close buffer' })
    end,
  },

  -- Dashboard au démarrage
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      
      dashboard.section.header.val = {
        "                                                     ",
        "  ██╗  ██╗    ██╗         ██╗    ██████╗            ",
        "  ██║ ██╔╝    ██║         ██║    ██╔══██╗           ",
        "  █████╔╝     ██║         ██║    ██████╔╝           ",
        "  ██╔═██╗     ██║         ██║    ██╔═══╝            ",
        "  ██║  ██╗    ███████╗    ██║    ██║                ",
        "  ╚═╝  ╚═╝    ╚══════╝    ╚═╝    ╚═╝                ",
        "                                                     ",
      }
      
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ": Telescope find_files <CR>"),
        dashboard.button("e", "  New file", ": ene <BAR> startinsert <CR>"),
        dashboard. button("r", "  Recent files", ": Telescope oldfiles <CR>"),
        dashboard.button("g", "  Find text", ": Telescope live_grep <CR>"),
        dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }
      
      alpha.setup(dashboard.opts)
    end,
  },
}
