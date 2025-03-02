--vim.api.nvim_create_autocmd("TermOpen", {
--  callback = function()
--    vim.o.statusline = "%{b:term_title}"
--  end
--})

vim.cmd[[autocmd TermOpen * setlocal statusline=%{b:term_title}]]
