local map = vim.keymap.set

local function nmap(lhs, rhs, opts)
  map('n', lhs, rhs, opts)
end

local function swap(mode, bind1, bind2)
	local tmp=bind1
  map(mode, bind1, bind2)
  map(mode, bind2, tmp)
end

local function swapnv(bind1, bind2)
  swap({'n', 'v'}, bind1, bind2)
end

function mapobject(bind, action, opts)
  vim.keymap.set({"x", "o"}, bind, action, opts)
end

-- swapnv('m', 'h')
-- swapnv('n', 'j')
-- swapnv('e', 'k')
-- swapnv('i', 'l')
--
-- swapnv('M', 'H')
-- swapnv('N', 'J')
-- swapnv('E', 'K')
-- swapnv('I', 'L')
nmap('<leader>tn', ':tabnew<CR>', { desc = "Open a new tab" })
nmap('<leader>tc', ':tabc<CR>', { desc = "Close the current tab" })
nmap('<leader>tm', ':tabp<CR>', { desc = "Go to previous tab" })
nmap('<leader>ti', ':tabn<CR>', { desc = "Go to next tab" })

nmap('<leader>wh', ':vne<CR>', { desc = "Create vertical split" })
nmap('<leader>wv', ':new<CR>', { desc = "Create horizontal split" })
nmap('<leader>wc', ':clo<CR>', { desc = "Close current window" })

nmap('<leader>wm', '<C-w><C-h>', { desc = "Focus window left of the current one" })
nmap('<leader>wn', '<C-w><C-j>', { desc = "Focus window below the current one" })
nmap('<leader>we', '<C-w><C-k>', { desc = "Focus window above the current one" })
nmap('<leader>wi', '<C-w><C-l>', { desc = "Focus window right of the current one" })
map({'n', 't', 'i'}, '<M-m>', function() require("tmux").move_left() end, { desc = "Focus window left of the current one" })
map({'n', 't', 'i'}, '<M-n>', function() require("tmux").move_bottom() end, { desc = "Focus window below the current one" })
map({'n', 't', 'i'}, '<M-e>', function() require("tmux").move_top() end, { desc = "Focus window above the current one" })
map({'n', 't', 'i'}, '<M-i>', function() require("tmux").move_right() end, { desc = "Focus window right of the current one" })

map({'n', 't', 'i'}, '<M-M>', function() require("tmux").resize_left() end, { desc = "Resize left side of split" })
map({'n', 't', 'i'}, '<M-N>', function() require("tmux").resize_bottom() end, { desc = "Resize bottom side of split" })
map({'n', 't', 'i'}, '<M-E>', function() require("tmux").resize_top() end, { desc = "Resize top side of split" })
map({'n', 't', 'i'}, '<M-I>', function() require("tmux").resize_right() end, { desc = "Resize right side of split" })

nmap('<leader>fo', '<cmd>Telescope find_files<CR>', { silent = true })
nmap('<leader>?', '<cmd>Telescope live_grep<CR>', { silent = true })

nmap('<leader>to', '<cmd>te<CR>', { silent = true; desc = "Open a terminal buffer in the current window." })

-- mapobject("]f", require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects"), { desc = "jump to the start of the next function"})
-- mapobject("[f", require("nvim-treesitter-textobjects.move").goto_prev_start("@function.outer", "textobjects"), { desc = "jump to the start of the previous function"})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = '*',
  callback = function()
    local opts = { buffer = true }
    local langs = require'treesj.langs'['presets']
    if langs[vim.bo.filetype] then
      vim.keymap.set('n', 'S', '<Cmd>TSJToggle<CR>', opts)
      vim.keymap.set('n', 'gS', '<Cmd>TSJSplit<CR>', opts)
      vim.keymap.set('n', 'gJ', '<Cmd>TSJJoin<CR>', opts)
    else
      vim.keymap.set('n', 'S', '<Cmd>lua MiniSplitJoin.toggle()<CR>', opts)
      vim.keymap.set('n', 'gS', '<Cmd>lua MiniSplitJoin.split()<CR>', opts)
      vim.keymap.set('n', 'gJ', '<Cmd>lua MiniSplitJoin.join()<CR>', opts)
    end
  end
})
