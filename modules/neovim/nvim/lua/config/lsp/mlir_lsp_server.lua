return {
  cmd = { ((vim.env.LLVM_DIR and (vim.env.LLVM_DIR .. "/bin/")) or "") .. "mlir-lsp-server" },
  filetypes = { 'mlir' },
  root_markers = { '.git' }
}
