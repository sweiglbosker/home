local methods = vim.lsp.protocol.Methods

local servers = {
  clangd = {},
  zls = {},
  rust_analyzer = {}
}

require('blink.cmp').setup({
  keymap = {
    preset = 'default',
    ['<C-n>'] = { function(cmp) cmp.show() end, 'select_next' },
    ['<Enter>'] = { 'accept', 'fallback' },
  },
  completion = {
    list = {
      selection = { preselect = true, auto_insert = true },
    },
    menu = {
      border = "rounded",
      auto_show = true,
    },
    documentation = { window = { border = 'rounded' } },
  },
  signature = { window = { border = 'rounded' } },
})

vim.diagnostic.config({
  virtual_text = false,
  float = { border = "rounded" },
  signs = false,
  underline = true,
  update_in_insert = false,
  float = true,
  jump = { float = true },
})

vim.api.nvim_create_autocmd("LspAttach", { callback = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  vim.keymap.set('n', 'grr', function()
    vim.lsp.buf.references() 
  end, { desc = "Code references (LSP)" }) 

  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition() 
  end, { desc = "Goto definition (LSP)" }) 

  vim.keymap.set('n', 'E', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
  if client:supports_method(methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable()
  end

  if client:supports_method(methods.textDocument_formatting) then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({bufnr = args.buf, id = client_id})
      end
    })
  end
end})

local lspconfig = require('lspconfig')

for server, config in pairs(servers) do
  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
  lspconfig[server].setup(config)
end
