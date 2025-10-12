return { 
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make'
		},
	},
	config = function()
		local telescope = require('telescope')
		telescope.setup({
			extensions = {
				fzf = {}
			}
		})
		telescope.load_extension('fzf')


		local builtin = require('telescope.builtin')

		-- LSP / Telescope config
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then return end

				-- References
				if client:supports_method('references') then
					vim.keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = 'References' })
					vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'References' })
				end

				-- Definitions
				if client:supports_method('definition') then
					vim.keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = 'Definitions' })
					vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'Definitions' })
				end

				-- Implemtation
				if client:supports_method('implemtation') then
					vim.keymap.set('n', '<leader>gD', builtin.lsp_implementations, { desc = 'Definitions' })
					vim.keymap.set('n', 'gD', builtin.lsp_implementations, { desc = 'Definitions' })
				end
			end,
		})


		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

		-- git stuff
		vim.keymap.set('n', '<leader>gfb', builtin.git_branches, { desc = "Find git branch" })

		-- in buffer fuzzy search
		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set('n', '<leader>/', function()
			-- You can pass additional configuration to Telescope to change the theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
				winblend = 10,
				previewer = false,
			})
		end, { desc = '[/] Fuzzily search in current buffer' })

		-- Shortcut for searching your Neovim configuration files
		vim.keymap.set('n', '<leader>fn', function()
			builtin.find_files { cwd = vim.fn.stdpath 'config' }
		end, { desc = '[F]ind [N]eovim files' })

		require 'config.telescope.telescope'.setup()
	end,
}
