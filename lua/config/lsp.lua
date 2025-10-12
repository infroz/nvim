vim.lsp.enable({
	"vtsls",
	"lua_ls",
	"csharp_ls",
})

--[[
  -- A helper function for setting keymaps.
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, noremap = true, buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  -- Keymappings for LSP functionality.
  map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
  map('n', 'gD', vim.lsp.buf.declaration, 'Go to Declaration')
  map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
  map('n', 'gr', vim.lsp.buf.references, 'Go to References')
  map('n', '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
]]
--

--- This file sets up the LSP client, key mappings, and autocommands for LSP features.
--[[
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})]]
--

-- Configure LSP features on attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if not client then
			return
		end

		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(
				mode,
				lhs,
				rhs,
				{ silent = true, noremap = true, buffer = event.buf, desc = "[LSP] " .. desc }
			)
		end

		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
		map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
		-- map("n", "gr", vim.lsp.buf.references, "Go to References")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")

		-- auto format
		if client:supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = event.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
				end,
			})
		end

		-- suggests completion
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
		end
	end,
})
