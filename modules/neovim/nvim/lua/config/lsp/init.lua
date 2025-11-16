vim.opt.cot = "menu,menuone,noinsert"
vim.opt.pumblend=5


local methods = vim.lsp.protocol.Methods
local map = vim.keymap.set

require("config.lsp.conform")
-- vim.lsp.config = {
--   ['clangd'] = require("config.lsp.clangd"),
--   ['zls'] = require("config.lsp.zls"),
-- }

local servers = {
  clangd = {},
  zls = {},
  basedpyright = {},
  ruff = {},
  -- lua_ls = {},
  nixd = {
    nixd = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
  cmake = {},
  verible = {},
  qmlls = {
    cmd = {"qmlls", "-E"}
  },
-- rust_analyzer = {}
}

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
--  virtual_text = { prefix = "", virt_text_pos = "eol_right_align",  },
--  virtual_text = true,
  float = { border = "rounded" },
  signs = false,
  underline = true,
  update_in_insert = false,
  float = true,
  jump = { float = true },
})

-- is completion visible
local function pumvisible()
  return tonumber(vim.fn.pumvisible()) ~= 0
end

vim.api.nvim_create_autocmd("LspAttach", { callback = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client == nil then
    return
  end

  client.server_capabilities.semanticTokensProvider = nil

  vim.keymap.set('n', 'grr', function()
    vim.lsp.buf.references()
  end, { desc = "Code references (LSP)" })

  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition()
  end, { desc = "Goto definition (LSP)" })

  -- if client:supports_method(methods.textDocument_completion) then
  --   local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
  --   client.server_capabilities.completionProvider.triggerCharacters = chars
  --   vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  --
  --   map('i', "<CR>", function()
  --     return pumvisible() and '<C-y>' or '<CR>'
  --   end, { expr = true })
  --
  --   -- TODO: this ignores/overwrites default omnifunc rn
  --   map('i', "<C-n>", function()
  --     return pumvisible() and '<C-n>' or vim.lsp.completion.get()
  --   end, { expr = true })
  --
  --   map('i', '<Esc>', function()
  --     return pumvisible() and '<C-E>' or '<Esc>'
  --   end, { expr = true })
  -- end

  -- if client:supports_method(methods.textDocument_semanticTokens) then
  -- end

  -- use pyright hover instead of ruff
  if client.name == 'ruff' then
    client.server_capabilities.hoverProvider = false
  end

  -- vim.keymap.set('n', 'E', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })
  if client:supports_method(methods.textDocument_inlayHint) then
    vim.lsp.inlay_hint.enable()
  end

  -- if client:supports_method(methods.textDocument_formatting) then
  --   vim.api.nvim_create_autocmd("BufWritePre", {
  --     buffer = args.buf,
  --     callback = function()
  --       vim.lsp.buf.format({bufnr = args.buf, id = client_id})
  --     end
  --   })
  -- end
end})

-- lspconfig = require('lspconfig')

for server, config in pairs(servers) do
-- --  config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
--   -- vim.lsp.config[server].settings = config
--   -- vim.lsp.config[server] = config
--   -- vim.lsp.enable(server)
--   -- lspconfig.rust_analyzer.setup({})
 -- lspconfig[server].setup(config)
 vim.lsp.config[server] = config
 vim.lsp.enable(server)
end

-- vim.lsp.enable({'lua_ls', 'zls', 'clangd'})
vim.lsp.enable({'zls', 'clangd', 'lua_ls'})

