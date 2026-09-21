-- unused for now
local util = require("conform.util")

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
    cmake = { "gersemi" },
    ocaml = { "ocamlformat" },
    systemverilog = { "verible" },
  },
  formatters = {
    verible = {
      prepend_args = { "--flagfile=rules.verible.format" },
      cwd = util.root_file({ "rules.verible.format" }),
      require_cwd = true,
    },
  },
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
