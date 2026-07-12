-- require("nvim-treesitter.configs").setup {
--   highlight = { enable = true },
--   indent = { enable = false },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       -- init_selection = "gnn",
--       node_incremental = "aa",
--       node_decremental = "ii",
--     },
--   },
-- highlight = {
--   enable = false,
--   disable = function(lang, buf)
--     local max_filesize = 100 * 1024 -- 100 KB
--     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--     if ok and stats and stats.size > max_filesize then
--         return true
--     end
--   end,
-- },
-- }

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
  "lua",
  "cpp",
  "nix",
  "scala",
  "nu",
  "go",
  "rst",
  "css",
  "yaml",
  "toml",
  "scss",
  "json",
  "html",
  "bash",
  "query",
  "ocaml",
  "ocaml-interface",
  "tex",
  "python",
  "bibtex",
  "comment",
  "dockerfile",
  "make",
  "cmake",
  "scheme",
  "llvm",
  "html",
  "glsl",
  "devicetree",
  "cuda",
  "c",
  "cpp",
  "zig",
  "rust",
  "haskell",
  "markdown",
  "markdown-inline",
  "tablegen",
    "mlir",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false, -- Enable multiwindow support.
  max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

-- require("nvim-treesitter-textobjects").setup({
-- 	select = {
-- 		lookahead = true,
-- 	},
-- })
