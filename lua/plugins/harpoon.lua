--[[ harpoon - allows to keep a quicklist of buffers to work with

Configured with keys 1-5 as hotkeys, do <leader>*
]]--
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local harpoon = require 'harpoon'
    local HARPOON_LIST_COUNT = 5

    harpoon:setup {}

    -- keymap setup
		local set = vim.keymap.set
    set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = '[Harpoon] Add to list' })

    for i = 1, HARPOON_LIST_COUNT, 1 do
      set('n', '<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = '[Harpoon] switch to ' .. i })
    end

    -- Toggle harpoon UI
    set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
  end,
}
