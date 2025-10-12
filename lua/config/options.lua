-- Setting my default tabbing - neovim always respects .editorconfig over this
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = false

-- displays line number on left
vim.wo.number = true
-- line numbers become relative to cursor
vim.wo.relativenumber = true

-- yank/paste using sys-clipboard
vim.opt.clipboard = 'unnamedplus' 
