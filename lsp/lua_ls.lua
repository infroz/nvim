return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
		'.git',
    -- ... other root markers
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
				maxPreload = 1000,
				preloadFileSize = 1000,
			},
			telemetry = { enable = false },
    },
  },
	completion = {
		autocomplete = false
	}
}
