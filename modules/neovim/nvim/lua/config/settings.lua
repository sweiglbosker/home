vim.g.mapleader = ' '

-- vim.o.number = true
-- vim.o.relativenumber = true
vim.o.number = false
vim.o.relativenumber = false

vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 15
vim.o.sidescrolloff = 12
vim.o.wrap = false
vim.o.lbr = true
vim.o.shortmess = vim.o.shortmess .. "I"
vim.o.termguicolors = true
vim.opt.fillchars = {eob = " "}
vim.o.smd = false
--vim.opt.laststatus = 3
vim.opt.laststatus=3
vim.opt.cmdheight=0
--%-0{minwid}.{maxwid}{item
-- vim.opt.statusline="%=%f%=%r %p%% « %l, %c %y"
vim.opt.statusline="%f%=%p%% « %l, %c "
vim.cmd[[packadd! termdebug]]
-- vim.opt.winbar="%!nvim_treesitter#statusline()"
-- vim.cmd[[
-- hi StatusLineNC guibg=none
-- hi StatusLine guibg=none
-- ]]
-- vim.cmd[[
-- hi LineNr guifg=bg
-- hi LineNrAbove guifg=bg
-- hi LineNrBelow guifg=bg
-- ]]
vim.opt.pumheight = 6
vim.opt.expandtab = true
vim.o.mouse=""
-- vim.o.guicursor=""
vim.o.swapfile=false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

--vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable=true
-- vim.cmd[[syntax off]]
-- vim.o.winborder = 'rounded' breaks telescope

vim.cmd[[set wildchar=<C-n>]]

vim.cmd[[cnoreabbrev ts lua vim.treesitter.start()]]

