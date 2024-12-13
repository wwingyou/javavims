vim.bo.tabstop=2
vim.bo.shiftwidth=2

-- Execute current lua script
vim.keymap.set('n', '<leader>x', '<cmd>source %<CR>')      -- file
vim.keymap.set('n', '<C-R>', ':.lua<CR>')                  -- current line
vim.keymap.set('v', '<C-R>', ':lua<CR>')                   -- selected area
