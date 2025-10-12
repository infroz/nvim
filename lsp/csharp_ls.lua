local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

return {
	on_attach = on_attach,
	root_markers = { '*.sln', '*.csproj' },
	filetypes = { 'cs' },
}
