return {
  -- Snippets prédéfinis pour plusieurs langages
  {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter",
  },

  -- LuaSnip (moteur de snippets)
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local luasnip = require("luasnip")
      
      -- Charge les snippets de friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- Configuration de LuaSnip
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
      })

        -- Snippets personnalisés pour C
      luasnip.add_snippets("c", {
        luasnip.snippet("hello", {
          luasnip.text_node('#include <stdio.h>'),
          luasnip.text_node({"", "", "int main() {"}),
          luasnip. text_node({"", '    printf("Hello, World! \\n");'}),
          luasnip. text_node({"", "    return 0;"}),
          luasnip.text_node({"", "}"}),
        }),
      })
      
      -- Keymaps pour naviguer dans les snippets
      vim.keymap.set({"i", "s"}, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { silent = true, desc = "Expand or jump snippet" })
      
      vim.keymap.set({"i", "s"}, "<C-j>", function()
        if luasnip.jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { silent = true, desc = "Jump back in snippet" })
    end,
  },

  -- Autopairs (ferme automatiquement les parenthèses, etc.)
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      local npairs = require('nvim-autopairs')
      npairs.setup({
        check_ts = true,
        ts_config = {
          lua = {'string'},
          javascript = {'template_string'},
          java = false,
        },
        disable_filetype = { "TelescopePrompt" },
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey='Comment'
        },
      })
      
      -- Intégration avec nvim-cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs. on_confirm_done())
    end,
  },

  -- Auto-tag pour HTML/JSX (ferme les balises automatiquement)
  {
    'windwp/nvim-ts-autotag',
    event = "InsertEnter",
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  -- Surround (ajouter/changer des délimiteurs)
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration par défaut
      })
    end,
  },

  -- Comment. nvim (commenter du code facilement)
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    config = function()
      require('Comment').setup()
    end,
  },

  -- Todo comments (met en évidence TODO, FIXME, etc.)
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        signs = true,
        keywords = {
          FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
      })
      
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next todo comment" })
      
      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo comment" })
      
      vim.keymap.set("n", "<leader>ft", ":TodoTelescope<CR>", { desc = "Find TODOs" })
    end,
  },
}
