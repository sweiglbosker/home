local config = require("metals").bare_config()

config.init_options.statusBarProvider = "off"

config.settings = {
  inlayHints = {
    -- inferredTypes = { enable = true },
    -- implicitArguments = { enable = true },
    hintsInPatternMatch = { enable = true },
  },
}

config.capabilities = require("blink.cmp").get_lsp_capabilities()

config.on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
  require("metals").setup_dap()
  vim.keymap.set('n', '<leader>s', require"telescope".extensions.metals.commands)
end

return config
