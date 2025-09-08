vim.api.nvim_create_autocmd("ColorScheme", { callback = function(args)
  local colors = require('base16-colorscheme').colors
  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.base01 })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.base01 })
  vim.api.nvim_set_hl(0, 'WinBar', { fg = colors.base03 })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = colors.base02 })
  vim.api.nvim_set_hl(0, 'TSVariable', { fg = colors.base05 })
  vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.base05 })
  vim.api.nvim_set_hl(0, 'Operator', { fg = colors.base08 })
  vim.api.nvim_set_hl(0, 'TSOperator', { fg = colors.base08 })
  vim.api.nvim_set_hl(0, 'TSCharacter', { fg = colors.base0B })
  vim.api.nvim_set_hl(0, 'TSOperator', { fg = colors.base08 })
  vim.api.nvim_set_hl(0, 'TSLabel', { fg = colors.base0C })
  vim.api.nvim_set_hl(0, 'Label', { fg = colors.base0C })
  vim.cmd[[
     hi Normal guibg=NONE
     hi NormalNC guibg=NONE
     hi TabLineFill guibg=bg
     hi TabLineSel guibg=bg guifg=fg
     hi TabLine guibg=bg
     hi NormalFloat guibg=bg
     hi StatusLine guibg=bg guifg=fg
     hi StatusLineNC guibg=bg
  ]]
  vim.api.nvim_set_hl(0, 'FzfLuaBorder', { fg = colors.base01 })
end})
