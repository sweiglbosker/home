vim.api.nvim_create_autocmd("ColorScheme", { callback = function(args)
  -- local colors = require('base16-colorscheme').colors
  local colors = require("tinted-nvim").get_palette()
    -- i dislike syntax highlighting
  -- vim.api.nvim_set_hl(0, 'Constant', {})
  -- vim.api.nvim_set_hl(0, 'Character', { link = "String" })
  -- vim.api.nvim_set_hl(0, 'Number', {})
  -- vim.api.nvim_set_hl(0, 'Boolean', {})
  -- vim.api.nvim_set_hl(0, 'Float', {})
  -- vim.api.nvim_set_hl(0, 'Identifier', {})
  -- vim.api.nvim_set_hl(0, 'Function', {})
  -- vim.api.nvim_set_hl(0, 'Statement', {})
  -- vim.api.nvim_set_hl(0, 'Conditional', {})
  -- vim.api.nvim_set_hl(0, 'Repeat', {})
  -- vim.api.nvim_set_hl(0, 'Label', {})
  -- vim.api.nvim_set_hl(0, 'Operator', {})
  -- vim.api.nvim_set_hl(0, 'Keyword', {})
  -- vim.api.nvim_set_hl(0, 'Exception', {})
  -- vim.api.nvim_set_hl(0, 'PreProc', {})
  -- vim.api.nvim_set_hl(0, 'Include', {})
  -- vim.api.nvim_set_hl(0, 'Define', {})
  -- vim.api.nvim_set_hl(0, 'Macro', {})
  -- vim.api.nvim_set_hl(0, 'PreCondit', {})
  -- vim.api.nvim_set_hl(0, 'Type', {})
  -- vim.api.nvim_set_hl(0, 'StorageClass', {})
  -- vim.api.nvim_set_hl(0, 'Structure', {})
  -- vim.api.nvim_set_hl(0, 'Typedef', {})
  -- vim.api.nvim_set_hl(0, 'Special', {})
  -- vim.api.nvim_set_hl(0, 'SpecialChar', { link = 'String' })
  -- vim.api.nvim_set_hl(0, 'Tag', {})
  -- vim.api.nvim_set_hl(0, 'Delimiter', {})
  -- vim.api.nvim_set_hl(0, 'Debug', {})
  vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.base01 })
  vim.api.nvim_set_hl(0, 'WinSeparator', { fg = colors.base01 })
  vim.api.nvim_set_hl(0, 'WinBar', { fg = colors.base03 })
  vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.base02 })

  -- STUFF THAT WAS ALREADY COMMENTED
  -- vim.api.nvim_set_hl(0, 'Comment', {})
  -- vim.api.nvim_set_hl(0, 'String', {})
  -- vim.api.nvim_set_hl(0, 'Underlined', {})
  -- vim.api.nvim_set_hl(0, 'SpecialComment', {})
  -- vim.api.nvim_set_hl(0, 'LineNrAbove', { fg = colors.base02 })
  -- vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = colors.base02 })
  -- vim.api.nvim_set_hl(0, 'TSVariable', { fg = colors.base05 })
  -- vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.base05 })
  -- vim.api.nvim_set_hl(0, 'Operator', { fg = colors.base08 })
  -- vim.api.nvim_set_hl(0, 'TSOperator', { fg = colors.base08 })
  -- vim.api.nvim_set_hl(0, 'TSCharacter', { fg = colors.base0B })
  -- vim.api.nvim_set_hl(0, 'TSOperator', { fg = colors.base08 })
  -- vim.api.nvim_set_hl(0, 'TSLabel', { fg = colors.base0C })
  -- vim.api.nvim_set_hl(0, 'Label', { fg = colors.base0C })

  vim.api.nvim_set_hl(0, 'DapBreakpoint', { bg = colors.base00, fg = colors.base08 })
  vim.api.nvim_set_hl(0, 'DapStopped', { bg = colors.base00, fg = colors.base0B })

  vim.cmd[[
     "hi Normal guibg=NONE
     "hi NormalNC guibg=NONE
     hi TabLineFill guibg=bg
     hi TabLineSel guibg=bg guifg=fg
     hi TabLine guibg=bg
     hi NormalFloat guibg=bg
     hi StatusLine guibg=bg guifg=fg
     hi StatusLineNC guibg=bg
  ]]
  vim.api.nvim_set_hl(0, 'FzfLuaBorder', { fg = colors.base01 })
end})
