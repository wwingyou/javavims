-- Set nohlsearch on pressing <ESC>.
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')

-- Resize window size with +, _.
-- NOTE: I used '_' instead of '-' because it's much easier to press '_' and '+' than '-' alternativly.
vim.keymap.set('n', '+', '<C-w>+', { desc = 'Increase current window height' })
vim.keymap.set('n', '_', '<C-w>-', { desc = 'Decrease current window height' })
vim.keymap.set('n', '<C-+>', '<C-w>>', { desc = 'Increase current window width' })
vim.keymap.set('n', '<C-_>', '<C-w><', { desc = 'Decrease current window width' })

-- Move between windows with h, j, k, l.
-- NOTE: This keymap is unused since `vim-tmux-navigator` is used instead.
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })

-- Shortcut to execute external program
vim.keymap.set('n', '!', ':!', { desc = 'Shortcut of executing external program' })

-- Press 'R' to substitute word under cursor.
-- NOTE: 'R' has other default action. Since I don't use it, exchanged it.
vim.keymap.set('n', 'R', function()
  local word = vim.fn.expand('<cword>')
  return ':%s/' .. word .. '/'
end, { expr = true, desc = 'Substitute word under cursor' })

-- Open terminal
-- TODO: It will be much better to open terminal with nvim api. (nvim_open_term())
vim.keymap.set('n', '<leader>1', '<cmd>split term://$SHELL<CR>', { desc = 'Open termnial' })

-- Exit terminal mode with <ESC>
vim.keymap.set('t', '<ESC>', '<C-\\><C-N>', { desc = 'Close terminal' })

-- Quickfix keymaps.
vim.keymap.set('n', '(', '<cmd>cp<CR>zOzz', { desc = 'quickfix list next item' })
vim.keymap.set('n', ')', '<cmd>cn<CR>zOzz', { desc = 'quickfix list prev item' })

vim.keymap.set('n', '<leader>qq', function()
  -- TODO: It would be great to close quickfix list when quickfix list is already open.
  vim.diagnostic.setqflist({ open = true })
end, { desc = 'open lsp diagnostic quickfix list' })

vim.keymap.set('n', '<leader>qe', function()
  vim.diagnostic.setqflist({ open = true, severity = "ERROR" })
end, { desc = 'open lsp diagnostic error list' })

vim.keymap.set('n', '<leader>qw', function()
  vim.diagnostic.setqflist({ open = true, severity = "WARN" })
end, { desc = 'open lsp diagnostic warn list' })

-- Toggle previous buffer.
vim.keymap.set('n', '<C-p>', function()
  local prev_buf = vim.fn.bufnr('#')
  if (prev_buf == -1) then
    vim.api.nvim_err_writeln('No previous buffer.')
    return
  end
  vim.api.nvim_set_current_buf(prev_buf)
end, { desc = 'toggle buffer back and forth' })

vim.keymap.set('n', '<CR>', function()
  if vim.bo.buftype == '' then
    return 'o<ESC>'
  else
    return '<CR>'
  end
end, { expr = true, desc = 'add empty line'})

vim.keymap.set('n', '<BS>', function()
  if vim.bo.buftype == '' then
    local current_line, _ = unpack(vim.api.nvim_win_get_cursor(0))  -- Get current line (1-based index)
    local last_line = vim.api.nvim_buf_line_count(0)  -- Get the total number of lines in the buffer

    if current_line == last_line then
      return 'dd'
    else
      return 'ddk'
    end
  else
    return '<BS>'
  end
end, { expr = true, desc = 'delete a line'})

vim.keymap.set('v', '<', '<gv', { noremap = true, desc = 're-select indent area'})
vim.keymap.set('v', '>', '<gv', { noremap = true, desc = 're-select indent area'})
