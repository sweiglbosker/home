return {
  cmd = { ((vim.env.LLVM_DIR and (vim.env.LLVM_DIR .. "/bin/")) or "") .. "tblgen-lsp-server" },
  filetypes = { 'tablegen' },
  root_markers = { '.git' }
}
