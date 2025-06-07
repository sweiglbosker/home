vim.loader.enable({enable=true})
vim.g.mapleader = ' '
vim.o.number = true
vim.o.relativenumber = true
vim.o.shiftwidth = 4
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 999
vim.o.sidescrolloff = 999
vim.o.wrap = false
vim.o.shortmess = "tToOFIsWcCi"
vim.o.termguicolors = true
vim.opt.fillchars = {eob = " "}
vim.o.smd = false
vim.o.cmdheight=0
vim.opt.statusline="%=%f%=%r %p%% « %l, %c %y"
vim.opt.pumheight = 6
vim.opt.expandtab = true
vim.o.mouse=""
vim.o.swapfile=false
vim.opt.foldmethod = "expr"

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable=true
vim.cmd[[set wildchar=<C-n>]]

-- vim.g.loaded_matchparen = 1 # disable matchparen
vim.cmd[[cnoreabbrev ts lua vim.treesitter.start()]]
require('vim._extui').enable({})
