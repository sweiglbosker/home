-- builtin neovim lsp configuration
vim.opt.cot = "menu,menuone,noselect"
--vim.opt.cot = "menu,menuone"

local methods = vim.lsp.protocol.Methods
local map = vim.keymap.set

-- hook that makes every floating window opened by nvim lsp rounded
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview 
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
--  virtual_text = { prefix = "", virt_text_pos = "eol_right_align",  },
  virtual_text = false,
  float = { border = "rounded" },
  signs = false,
  underline = true,
  update_in_insert = false,
  float = true,
  jump = { float = true }
})

local function pumvisible()
  return tonumber(vim.fn.pumvisible()) ~= 0
end

vim.api.nvim_create_autocmd("LspAttach", { callback = function(args) 
  local client = vim.lsp.get_client_by_id(args.data.client_id)

--  fun but gets annoying
--  if client:supports_method(methods.textDocument_inlayHint) then
--    vim.lsp.inlay_hint.enable()
--  end
    
  map('n', 'E', '<cmd>lua vim.lsp.buf.hover()<CR>', { silent = true })

  if client:supports_method(methods.textDocument_completion) then
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
    vim.keymap.set('i', '<C-n>', function() 
      return pumvisible() and '<C-n>' or vim.lsp.completion.trigger() 
    end)
  end

-- autoformat on save
  if client:supports_method(methods.textDocument_formatting) then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = args.buf,
      callback = function()
        vim.lsp.buf.format({bufnr = args.buf, id = client_id})
      end
    })
  end
end})
