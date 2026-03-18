vim.opt.wrap = true
vim.opt.number = false
vim.opt.relativenumber = false

vim.keymap.set({'n', 'v'}, '<C-n>', 'g<Down>', { buffer = true })
vim.keymap.set({'n', 'v'}, '<C-p>', 'g<Up>', { buffer = true })

vim.opt.statusline="%f"
vim.opt_local.conceallevel=3
