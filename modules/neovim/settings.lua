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
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.expandtab = true
vim.o.mouse=""
vim.o.guicursor=""
vim.o.swapfile=false

vim.cmd[[
  colorscheme base16-mountain
  hi LineNr guifg=#ceb188
  hi LineNrAbove guifg=#262626
  hi LineNrBelow guifg=#262626
  hi CursorLineNr guifg=#ceb188 guibg=#191919 gui=bold
  hi FloatBorder guifg=#4c4c4c
  hi Pmenu guibg=#0d0d0d
  hi PmenuSel guibg=#191919 guifg=#cacaca
  hi WinBar guifg=#4c4c4c
  hi WinSeparator guifg=#191919

  " status line
  hi StatusLine guibg=#191919 guifg=#4c4c4c
  hi StatuslineInactive guibg=#191919 guifg=#4c4c4c gui=NONE
  hi StatuslineAccent guifg=#0f0f0f guibg=#aca98a gui=bold
  hi StatuslineInsertAccent guifg=#0f0f0f guibg=#8aabac gui=bold
  hi StatuslineVisualAccent guifg=#0f0f0f guibg=#8f8aac gui=bold
  hi StatuslineReplaceAccent guifg=#0f0f0f guibg=#ac8a8c gui=bold
  hi StatuslineTerminalAccent guifg=#0f0f0f guibg=#ac8a8c gui=bold
  hi StatuslineCommandAccent guifg=#0f0f0f guibg=#8aac8b gui=bold
  hi StatuslineFileIcon guibg=#191919 guifg=#8f8aac
  hi StatuslineInfo guibg=#191919 guifg=#4c4c4c 
  hi LspError guibg=#191919 guifg=#c49ea0
  hi LspWarn guibg=#191919 guifg=#8f8aac
  hi LspInfo guibg=#191919 guifg=#8f8aac
  hi LspHint guibg=#191919 guifg=#8aabac
]]
