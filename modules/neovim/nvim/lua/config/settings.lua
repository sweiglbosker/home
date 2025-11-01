vim.g.mapleader = ' '
vim.loader.enable({enable = true})
vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.relativenumber = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 999
vim.o.wrap = false
vim.o.linebreak = true
vim.o.shortmess = "tToOFIsWcCi"
vim.o.termguicolors = true
vim.opt.fillchars = {eob = " "}
vim.o.smd = false
vim.opt.laststatus=0
vim.opt.cmdheight=0
vim.opt.pumheight = 6
-- vim.opt.pumborder = "rounded"
vim.opt.expandtab = true
vim.o.mouse=""
vim.o.swapfile=false
vim.opt.foldmethod = "expr"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable=true
vim.cmd[[set wildchar=<C-n>]]
vim.cmd[[cnoreabbrev ts lua vim.treesitter.start()]]
require('vim._extui').enable({})
