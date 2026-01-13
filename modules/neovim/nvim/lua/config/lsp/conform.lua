-- unused for now
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black", "isort" },
		zig = { "zigfmt" },
		nix = { "nixfmt" },
		c = { "clang-formt" },
		cpp = { "clang-format" },
		scala = { "scalafmt" },
		bzl = { "buildifier" },
	},
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
