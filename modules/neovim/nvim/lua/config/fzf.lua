require("fzf-lua").setup({
  defaults = {
    file_icons = false,
    prompt = false,
    -- hidden = true,
  },
  previewers = {
    builtin = {
      syntax = false,
      treesitter = false,
      -- toggle_behavior = "extend",
    },
  },
  keymap = {
    builtin = {
      ["<C-p>"] = "toggle-preview",
    },
  },
  files = {
    previewer = "builtin",
    cwd_prompt = false,
    prompt = "  ",
  },
  grep = {
    actions = {
      ['<ctrl-g>'] = nil,
    },
    no_header = true,
    no_header_i = true,
  },
  winopts = {
    -- fullscreen = true,
    row = 1,
    col = 0,
    width = 1,
    height = 0.4,
    title_pos = "left",
    backdrop = 70,
    -- border = "rounded",
    -- border = "none",
    treesitter = {
      enabled = false,
      fzf_colors = false,
    },
    border = { "", "─", "", "", "", "", "", "" },
    preview = {
      layout = "horizontal",
      title_pos = "right",
      -- title = false,
      -- hidden = true,
      scrollbar = false,
      -- border = "none",
      -- border = "rounded",
      winopts = {
        number = false,
      },
      border = function(_, m)
        if m.type == "fzf" then
          return "single"
        else
          assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string")
          local b = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
          if m.layout == "down" then
            b[1] = "├" --top right
            b[3] = "┤" -- top left
          elseif m.layout == "up" then
            b[7] = "├" -- bottom left
            b[6] = "" -- remove bottom
            b[5] = "┤" -- bottom right
          elseif m.layout == "left" then
            b[3] = "┬" -- top right
            b[5] = "┴" -- bottom right
            b[6] = "" -- remove bottom
          else -- right
            b[1] = "┬" -- top left
            b[7] = "┴" -- bottom left
            b[6] = "" -- remove bottom
          end
          return b
        end
      end,
    },
    on_create = function()
      vim.keymap.set('t', '<C-e>', '<Up>', { silent = true, buffer = true })
    end,
  },
  fzf_opts = {
    -- ["--tmux"] = "",
    ["--style"] = "minimal",
    ["--ansi"] = true,
    ["--no-bold"] = "",
    ["--bind"] = "ctrl-n:down,ctrl-e:up",
  },
  hls = {
    border = "FloatBorder",
  },
})

