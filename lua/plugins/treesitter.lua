return {
	'nvim-treesitter/nvim-treesitter',
	branch = 'master',
	lazy = false,
	build = ':TSUpdate',
	config = function () 
		require('nvim-treesitter.configs').setup {
			ensure_installed = { 
				'c',
				'c_sharp',
				'lua',
				'vim',
				'vimdoc',
				'markdown',
				'query',
				'tsx',
				'javascript',
			},
			auto_install = true,
			ignore_install = {},
			sync_install = true
		}
	end
}
