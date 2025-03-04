vim.g.mapleader =" "
vim.g.maplocalleader =" "

vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = false
vim.opt.autoread = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.o.breakindent = true

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse
vim.o.mouse = "a"

-- Sync clipboard between OS and neovim
vim.o.clipboard = "unnamedplus"

-- No swapfile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- Case insensitive searching Unles \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = "menuone,noselect"
vim.o.termguicolors = true

-- Open splits
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = true
vim.opt.linebreak = true

-- Scroll option
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 15
vim.opt.sidescroll = 5
