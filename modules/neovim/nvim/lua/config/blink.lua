require("blink.cmp").setup({
	keymap = {
		preset = "enter",
	},
	sources = { default = { "lsp", "path", "snippets", "buffer" } },
	completion = {
		menu = {
			auto_show = true,
      max_height=5,
		},
    list = {
      max_items = 6,
    },
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		ghost_text = { enabled = true },
	},
	signature = { enabled = true },
})
