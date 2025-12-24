return {
  cmd = { ((vim.env.LLVM_DIR and (vim.env.LLVM_DIR .. "/bin/")) or "") .. "mlir-pdll-lsp-server" },
  filetypes = { 'pdll' },
  root_markers = { 'pdll_compile_commands.yml', '.git' }
}
