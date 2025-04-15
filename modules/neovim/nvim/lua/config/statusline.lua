local modes = {
  ["n"] = "",
  ["no"] = "",
  ["nt"] = "",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL-LINE",
  [""] = "VISUAL-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT-LINE",
  [""] = "SELECT-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM-EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local m = vim.api.nvim_get_mode().mode
  local s = modes[m]
  return s == "" and "" or string.format("%s » ", s)
end

M = {}

M.statusline = function()
  return table.concat {
    " ",
    mode(),
    "%f%=%p%% « %l, %c "
  }
end

M.termStatus = function()
  return table.concat {
    " ",
    mode(),
    "%{b:term_title}%=%p%% « %l, %c "
  }
end

M.setup = function(config)
  vim.api.nvim_exec([[
    set statusline=%!v:lua.M.statusline()
    augroup Statusline
    au!
    au TermOpen * setlocal statusline=%!v:lua.M.termStatus()
    augroup END
  ]], false)
end

M.setup()
