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

swapnv('m', 'h')
swapnv('n', 'j')
swapnv('e', 'k')
swapnv('i', 'l')

swapnv('M', 'H')
swapnv('N', 'J')
--swapnv('E', 'K')
swapnv('I', 'L')

nmap('<leader>tn', ':tabnew<CR>', { desc = "Open a new tab" })
nmap('<leader>tc', ':tabc<CR>', { desc = "Close the current tab" })
nmap('<leader>tm', ':tabp<CR>', { desc = "Go to previous tab" })
nmap('<leader>ti', ':tabn<CR>', { desc = "Go to next tab" })

nmap('<leader>wv', ':vne<CR>', { desc = "Create vertical split" })
nmap('<leader>wh', ':new<CR>', { desc = "Create horizontal split" })
nmap('<leader>wc', ':clo<CR>', { desc = "Close current window" })

nmap('<leader>wm', '<C-w><C-h>', { desc = "Focus window left of the current one" })
nmap('<leader>wn', '<C-w><C-j>', { desc = "Focus window below the current one" })
nmap('<leader>we', '<C-w><C-k>', { desc = "Focus window above the current one" })
nmap('<leader>wi', '<C-w><C-l>', { desc = "Focus window right of the current one" })

nmap('<leader>fo', '<cmd>Telescope find_files<CR>', { silent = true })
