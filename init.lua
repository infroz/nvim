vim.lsp.config('*', {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      }
    }
  },
  root_markers = { '.git' },
})

require("core.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
