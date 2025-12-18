return {
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"andersevenrud/nvim_context_vt",
		event = "BufReadPost",
		config = true,
		opts = {
			enabled = true,
			prefix = "",
			disable_virtual_lines = true,
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		version = false,
		build = ":TSUpdate",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		config = function()
			local treesitter = require("nvim-treesitter")

			local ignore_ft = {
				"tex",
			}

			local group = vim.api.nvim_create_augroup("TreesitterConfig", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = { "*" },
				callback = function(event)
					if not vim.tbl_contains(ignore_ft, event.match) then
						local lang = vim.treesitter.language.get_lang(event.match) or event.match
						local buf = event.buf

						pcall(vim.treesitter.start, buf, lang)

						vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

						treesitter.install({ lang })
					end
				end,
			})
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		events = { "BufReadPre", "BufNewFile" },
		config = true,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		config = true,
		opts = {
			enable_autocmd = false,
		},
	},
}
