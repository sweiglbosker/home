require("nvim-treesitter.configs").setup {
  highlight = { enable = false },
  indent = { enable = false },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = "gnn",
      init_selection = "g+",
      node_incremental = "+",
      node_decremental = "_",
    },
  },
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
}
