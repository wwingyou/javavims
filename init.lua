-- Always indent with 2 space.
vim.opt.expandtab=true
vim.opt.tabstop=2
vim.opt.shiftwidth=2

-- Always use the same register with external clipboard.
vim.opt.clipboard:append 'unnamedplus'

-- Alawys save current file before to move to other file.
vim.opt.autowrite=true

-- Show informatic extra columns.
vim.opt.number=true
vim.opt.foldcolumn='2'

-- NOTE: This options makes it automatically opens and closes current cursor
-- position. It's pretty fun but very confusing as for daily option.
-- Maybe used for later?
-- vim.opt.foldopen='all'
-- vim.opt.foldclose='all'

-- Fold options.
vim.opt.foldmethod='syntax'
-- vim.opt.foldtext='' TODO: Define custom foldtext function

-- Line break options.
vim.opt.wrap=true
vim.opt.linebreak=true
vim.opt.breakindent=true
vim.opt.showbreak="~"
vim.opt.breakindentopt="sbr,shift:2"

-- Ask to save when leaving buffer without saving.
vim.opt.confirm=true

-- Highlight cursor column and line. 
-- vim.opt.cursorcolumn=true
vim.opt.cursorline=true
vim.opt.cursorlineopt="both"

-- Always add 'g' flag for substitution.
vim.opt.gdefault=true

-- Use smartcase search.
vim.opt.ignorecase=true
vim.opt.smartcase=true

-- Set list mode by default.
vim.opt.list=true

-- Scroll options.
vim.opt.scrolloff=10

-- Split options.
vim.opt.splitright=true

-- Move cursor at the first non-blank character of the line. Useful maybe?
vim.opt.startofline=true

-- Set colorscheme.
-- vim.cmd 'colorscheme retrobox'

-- Enable matchit.
vim.cmd 'packadd! matchit'

-- Set nohlsearch on pressing <ESC>.
vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')

-- Resize window size with +, _.
-- NOTE: I used '_' instead of '-' because it's much easier to press '_' and '+' than '-' alternativly.
vim.keymap.set('n', '+', '<C-w>+', { desc = 'Increase current window height' })
vim.keymap.set('n', '_', '<C-w>-', { desc = 'Decrease current window height' })
vim.keymap.set('n', '<C-+>', '<C-w>>', { desc = 'Increase current window width' })
vim.keymap.set('n', '<C-_>', '<C-w><', { desc = 'Decrease current window width' })

-- Move between windows with h, j, k, l.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to left window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to right window' })

-- Shortcut to execute external program
vim.keymap.set('n', '!', ':!', { desc = 'Shortcut of executing external program' })

-- Press 'R' to substitute word under cursor.
-- NOTE: 'R' has other default action. Since I don't use it, exchanged it.
vim.keymap.set('n', 'R', function()
  local word = vim.fn.expand('<cword>')
  return ':%s/' .. word .. '/' 
end, { expr = true, desc = 'Substitute word under cursor' })

-- Highlight on yank.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Save file if modified before sourcing
vim.api.nvim_create_autocmd('SourcePre', {
  desc = 'Save file if modified before sourcing',
  group = vim.api.nvim_create_augroup('write-before-souring', { clear = true }),
  callback = function(ev)
    local is_modified = vim.api.nvim_buf_get_option(ev.buf, 'modified')
    if is_modified then
      vim.cmd('write ' .. ev.file)
    end
  end,
})
