vim.api.nvim_create_autocmd("ColorScheme", { callback = function(args)
  local colors = require('base16-colorscheme').colors
  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.base01 })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.base01 })
  vim.api.nvim_set_hl(0, 'WinBar', { fg = colors.base03 })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = colors.base02 })
  vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = colors.base02 })
  vim.cmd[[
     hi TabLineFill guibg=bg
     hi TabLineSel guibg=bg guifg=fg
     hi TabLine guibg=bg
     hi NormalFloat guibg=bg
     hi StatusLine guibg=bg guifg=fg
     hi StatusLineNC guibg=bg
  ]]
  vim.api.nvim_set_hl(0, 'FzfLuaBorder', { fg = colors.base01 })
end})
