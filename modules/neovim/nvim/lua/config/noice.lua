require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      [ "vim.lsp.util.sylize_markdown" ] = true,
    },

    presets = {
      command_palette = true,
      log_message_to_split = true,
      lsp_doc_border = true,
    },
  },
})
