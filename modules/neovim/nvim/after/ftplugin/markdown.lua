vim.opt.wrap = true
vim.opt.number = false
vim.opt.relativenumber = false

vim.keymap.set({'n', 'v'}, 'n', 'g<Down>', { buffer = true })
vim.keymap.set({'n', 'v'}, 'e', 'g<Up>', { buffer = true })

vim.opt.statusline="%f"
