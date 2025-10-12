return {
	"github/copilot.vim",
	config = function()
		-- Github Copilot autocomplete via custom key mapping
		vim.g.copilot_no_tab_map = true
		vim.api.nvim_set_keymap(
			"i",
			"<C-j>", -- accept with Ctrl + j
			'copilot#Accept("<CR>")',
			{ expr = true, silent = true, noremap = true, desc = "Accept Copilot suggestion" }
		)
	end,
}
