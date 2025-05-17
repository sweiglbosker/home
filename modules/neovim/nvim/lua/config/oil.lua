require("oil").setup({
  default_file_explorer = true,
  columns = {
    -- "icon"
  },
  constrain_cursor = "editable",
  skip_confirm_for_simple_edits = true,
  win_options = {
    number = false,
    relativenumber = false,
    cursorline = true,
  },
  view_options = {
    show_hidden = true,
  },
  float = {
    max_width = .7,
    max_height = .5,
    win_options = {
    },
  },
})
