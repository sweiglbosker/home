-- unused for now
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black", "isort" },
    zig = { "zigfmt" },
    nix = { "nixfmt" },
    c = { "clang-formt" },
    cpp = { "clang-format" },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
