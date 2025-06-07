local lz = require("lz.n")
local keymap = lz.keymap({
  "telescope.nvim",
  cmd = "Telescope",
  after = function()
    require("telescope").setup()
  end,
})

keymap.set("n", "<leader>fo", function()
  require("telescope.builtin").find_files(require('telescope.themes').get_dropdown({}))
end)
