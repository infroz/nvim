-- Highlight yanking
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (Copying text)',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
