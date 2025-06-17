usage
=====

- `van` `vin` lsp incremental selection now native via lsp (textDocument/selectionRange)
- `vim.lpeg` looks cool
- `:help diagnostic-signs`
- vim.ui_attach callbacks for ui-messages msg_show

config
======

- new `pummaxwidth`
- `complete` was updated a bit
- `nvim_echo`
- `vim.diagnostic.setqflist` (and setloclist) 
    - check out `vim.lsp.listOpts` `on_list` option. (or just the loclist opt)
- `CommandLeavePre`
- `ui-messages` `msg_show` `append` param
- `vim.lsp.ClientConfig`

to disable hover highlights:
```lua
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'LspReferenceTarget', {})
  end,
})
```
