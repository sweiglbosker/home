vim.g.mapleader = ' '

vim.o.number = true
vim.o.relativenumber = true
-- vim.o.number = false
-- vim.o.relativenumber = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 15
vim.o.sidescrolloff = 12
vim.o.wrap = false
vim.o.lbr = true
vim.o.shortmess = vim.o.shortmess .. "I"
vim.o.termguicolors = true
vim.opt.fillchars = {eob = " "}
--vim.o.smd = false
--vim.opt.laststatus = 3
vim.opt.laststatus=3
--%-0{minwid}.{maxwid}{item
-- vim.opt.statusline="%=%f%=%r %p%% « %l, %c %y"
vim.opt.statusline="%f%=%p%% « %l, %c "
vim.cmd[[packadd termdebug]]
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
vim.o.guicursor=""
vim.o.swapfile=false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
--vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
-- vim.cmd[[syntax off]]
-- vim.o.winborder = 'rounded' breaks telescope
vim.cmd[[set wildchar=<C-n>]]
-- vim.api.nvim_set_hl(0, 'Comment', {})
vim.api.nvim_set_hl(0, 'Constant', {})
vim.api.nvim_set_hl(0, 'String', {})
vim.api.nvim_set_hl(0, 'Character', {})
vim.api.nvim_set_hl(0, 'Number', {})
vim.api.nvim_set_hl(0, 'Boolean', {})
vim.api.nvim_set_hl(0, 'Float', {})
vim.api.nvim_set_hl(0, 'Identifier', {})
vim.api.nvim_set_hl(0, 'Function', {})
vim.api.nvim_set_hl(0, 'Statement', {})
vim.api.nvim_set_hl(0, 'Conditional', {})
vim.api.nvim_set_hl(0, 'Repeat', {})
vim.api.nvim_set_hl(0, 'Label', {})
vim.api.nvim_set_hl(0, 'Operator', {})
vim.api.nvim_set_hl(0, 'Keyword', {})
vim.api.nvim_set_hl(0, 'Exception', {})
vim.api.nvim_set_hl(0, 'PreProc', {})
vim.api.nvim_set_hl(0, 'Include', {})
vim.api.nvim_set_hl(0, 'Define', {})
vim.api.nvim_set_hl(0, 'Macro', {})
vim.api.nvim_set_hl(0, 'PreCondit', {})
vim.api.nvim_set_hl(0, 'Type', {})
vim.api.nvim_set_hl(0, 'StorageClass', {})
vim.api.nvim_set_hl(0, 'Structure', {})
vim.api.nvim_set_hl(0, 'Typedef', {})
vim.api.nvim_set_hl(0, 'Special', {})
vim.api.nvim_set_hl(0, 'SpecialChar', {})
vim.api.nvim_set_hl(0, 'Tag', {})
vim.api.nvim_set_hl(0, 'Delimiter', {})
vim.api.nvim_set_hl(0, 'SpecialComment', {})
vim.api.nvim_set_hl(0, 'Debug', {})
vim.api.nvim_set_hl(0, 'Underlined', {})
