vim.g.mapleader = " "

vim.opt.mouse = "a"
vim.opt.nu = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.signcolumn = "yes"

-- tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- appearance
vim.opt.termguicolors = true
vim.opt.cmdheight = 1
vim.opt.updatetime = 5
vim.opt.scrolloff = 8

-- other
vim.opt.clipboard:append("unnamedplus")
vim.opt.backspace = "indent,eol,start"

