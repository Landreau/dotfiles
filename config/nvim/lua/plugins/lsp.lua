return {
  -- Mason pour gérer les LSP
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Capabilities pour l'autocomplétion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Keymaps LSP (s'attachent automatiquement quand un LSP se connecte)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local opts = { buffer = event.buf }
          
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf. references, opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf. hover, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>f', function()
            vim.lsp. buf.format({ async = true })
          end, opts)
        end,
      })

      -- Configuration automatique via Mason
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",        -- C/C++
          "rust_analyzer", -- Rust
          "pyright",       -- Python
          "jdtls",         -- Java
        },
        handlers = {
          -- Handler par défaut pour tous les serveurs
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,
          
          -- Configuration spécifique pour clangd (C/C++)
          ["clangd"] = function()
            require("lspconfig").clangd.setup({
              capabilities = capabilities,
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
              },
            })
          end,
          
          -- Configuration spécifique pour rust-analyzer
          ["rust_analyzer"] = function()
            require("lspconfig").rust_analyzer.setup({
              capabilities = capabilities,
              settings = {
                ["rust-analyzer"] = {
                  cargo = {
                    allFeatures = true,
                  },
                  checkOnSave = {
                    command = "clippy",
                  },
                },
              },
            })
          end,

          -- Configuration spécifique pour Python (Pyright)
          ["pyright"] = function()
            require("lspconfig").pyright.setup({
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                    typeCheckingMode = "basic",
                  },
                },
              },
            })
          end,

          -- Configuration spécifique pour Java (jdtls)
          ["jdtls"] = function()
            require("lspconfig").jdtls.setup({
              capabilities = capabilities,
              settings = {
                java = {
                  signatureHelp = { enabled = true },
                  contentProvider = { preferred = 'fernflower' },
                  completion = {
                    favoriteStaticMembers = {
                      "org.junit.Assert.*",
                      "org.junit. Assume.*",
                      "org.junit.jupiter.api.Assertions.*",
                      "org.junit.jupiter.api. Assumptions.*",
                      "org.junit.jupiter.api.DynamicContainer.*",
                      "org.junit.jupiter.api.DynamicTest.*",
                      "org.mockito.Mockito.*",
                      "org.mockito.ArgumentMatchers.*",
                      "org.mockito. Answers.*"
                    },
                    filteredTypes = {
                      "com.sun.*",
                      "io.micrometer. shaded.*",
                      "java.awt.*",
                      "jdk.*",
                      "sun.*",
                    },
                  },
                  sources = {
                    organizeImports = {
                      starThreshold = 9999,
                      staticStarThreshold = 9999,
                    },
                  },
                  codeGeneration = {
                    toString = {
                      template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                    },
                    useBlocks = true,
                  },
                  configuration = {
                    runtimes = {
                      -- Tu peux ajouter tes versions Java ici
                      -- {
                      --   name = "JavaSE-17",
                      --   path = "/usr/lib/jvm/java-17-openjdk/",
                      -- },
                    }
                  },
                },
              },
            })
          end,
        },
      })
    end,
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
  },

  -- Autocompletion
      -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip. lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config. window.bordered(),
        },
        mapping = cmp.mapping. preset.insert({
          ['<C-b>'] = cmp.mapping. scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp. mapping.complete(),
          ['<C-e>'] = cmp. mapping.abort(),
          ['<CR>'] = cmp.mapping. confirm({ select = true }),
          
          -- Tab pour naviguer et expand snippets
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          
          -- Shift+Tab pour revenir en arrière
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },  -- Snippets en priorité
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        formatting = {
          format = function(entry, vim_item)
            -- Ajoute la source
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
    end,
  },
}
