return {
	{
		"nvim-mini/mini.nvim",
		version = "*",
		lazy = false,
		keys = {
			{
				"<C-n>",
				function()
					require("mini.files").open()
				end,
				desc = "Open file explorer",
			},
		},
		config = function()
			require("mini.pairs").setup()
			require("mini.files").setup()
		end,
	},
}
