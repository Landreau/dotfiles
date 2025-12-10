-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configuration de base
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- FIX pour les caracteres bizarres
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.termguicolors = true

-- vim.opt.guicursor = "n-v-c: block,i-ci-ve:ver25,r-cr: hor20,o:hor50"
vim.opt.cursorline = true

-- Options générales
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt. mouse = 'a'
vim.opt. ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'
vim.opt. updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Plugins avec config Lazy pour éviter les caractères bizarres
require("lazy").setup("plugins", {
  ui = {
    icons = {
      cmd = "CMD",
      config = "CFG",
      event = "EVT",
      ft = "FT",
      init = "INIT",
      keys = "KEY",
      plugin = "PLG",
      runtime = "RUN",
      require = "REQ",
      source = "SRC",
      start = "START",
      task = "TASK",
      lazy = "LAZY",
    },
    border = "rounded",
  },
})

-- Configuration des diagnostics
require("config.diagnostics")
require("config.snippets")
