local servers = {
	'vtsls',
	'csharp_ls',
	'lua_ls',
}

local tools = {
	'stylua',
	'prettier',
}

return {
		'mason-org/mason.nvim',
		dependencies = {
      'mason-org/mason-lspconfig.nvim',
			'neovim/nvim-lspconfig',
		},
		opts = {
		},
		config = function ()
			require('mason').setup { ensure_installed = vim.list_extend(tools, servers) }
			require('mason-lspconfig').setup { ensure_installed = servers }
		end
	}
