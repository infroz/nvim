local set = vim.keymap.set

-- buffer management
set('n', '<leader>bo', '<cmd>%bd!|e#<CR>', { desc = 'Delete other buffers' })
set('n', '<leader>bd', '<cmd>bd!<CR>', { desc = 'Delete current buffer' })
set('n', '<leader>ba', '<cmd>bufdo bd!<CR>', { desc = 'Delete * buffers' })


-- Window management - default wincmd's are <Ctrl-w>hjkl
set('n', '<C-h>', '<cmd>wincmd h<CR>', { desc = 'Nav win left' })
set('n', '<C-j>', '<cmd>wincmd j<CR>', { desc = 'Nav win down' })
set('n', '<C-k>', '<cmd>wincmd k<CR>', { desc = 'Nav win up' })
set('n', '<C-l>', '<cmd>wincmd l<CR>', { desc = 'Nav win right' })
