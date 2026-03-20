local config = require("metals").bare_config()

config.init_options.statusBarProvider = "off"
config.capabilities = require("blink.cmp").get_lsp_capabilities()

config.on_attach = function(client, bufnr)
  local opts = { buffer = bufnr }
end

return config
