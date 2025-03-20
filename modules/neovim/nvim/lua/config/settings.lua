vim.g.mapleader = ' '

vim.o.number = true
vim.o.relativenumber = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 15
vim.o.wrap = false
vim.o.lbr = true
vim.o.shortmess = vim.o.shortmess .. "I"
vim.o.termguicolors = true
vim.opt.fillchars = {eob = " "}
--vim.o.smd = false
--vim.opt.laststatus = 3
vim.opt.pumheight = 6
vim.opt.expandtab = true
vim.o.mouse=""
vim.o.guicursor=""
vim.o.swapfile=false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
