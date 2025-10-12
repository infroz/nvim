return {
	{
		"echasnovski/mini.nvim",
		config = function()
			local statusLine = require("mini.statusline")
			statusLine.setup({ use_icons = true })

			local completion = require("mini.completion")
			completion.setup({
				mappings = {
					force_twostep_completion = "<C-y>",
					force_cancel_completion = "<C-e>",
				},
			})
			-- Accept the selected completion item
			vim.api.nvim_set_keymap(
				"i",
				"<C-y>",
				[[pumvisible() ? "\<C-y>" : "\<C-y>"]],
				{ expr = true, noremap = true }
			)

			-- Cancel the completion menu
			vim.api.nvim_set_keymap(
				"i",
				"<C-e>",
				[[pumvisible() ? "\<C-e>" : "\<C-e>"]],
				{ expr = true, noremap = true }
			)
		end,
	},
}
