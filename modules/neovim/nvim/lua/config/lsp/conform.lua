-- unused for now
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    zig = { "zigfmt" },
    nix = { "nixfmt" },
    c = { "clang-format" },
    scala = { lsp_format = "fallback" },
    cpp = { "clang-format" },
    bzl = { "buildifier" },
    rust = { "rustfmt" },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
