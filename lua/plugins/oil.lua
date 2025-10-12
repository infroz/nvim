return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	-- Optional dependencies
	dependencies = {
		{
			"nvim-mini/mini.icons",
			opts = {},
		},
	},
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function()
		local oil = require("oil")

		oil.setup({
			view_options = {
				-- to show dot-files and other hidden stuff
				show_hidden = true,
			},
		})

		local set = vim.keymap.set

		set("n", "<leader>ed", ":Oil<Cr>", { desc = "Explore current directory" })
		set("n", "<leader>ee", ":Oil" .. vim.fn.getcwd() .. "<Cr>", { desc = "Explore current working directory" })
	end,
}
