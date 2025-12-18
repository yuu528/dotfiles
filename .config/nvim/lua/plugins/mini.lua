return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
		lazy = false,
		keys = {
			{
				"<C-n>",
				"<CMD>lua MiniFiles.open()<CR>",
				desc = "Open file explorer",
			},
		},
		config = function()
			require("mini.pairs").setup()
			require("mini.files").setup()
		end,
	},
}
