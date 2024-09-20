-- Set global variables.
vim.g.mapleader=' '
vim.g.maplocalleader=' '

-- Require lazy.nvim
require 'config.lazy'

-- Set colorscheme 'gruvbox'
vim.cmd 'colorscheme gruvbox'

-- Always indent with 3 space.
vim.opt.expandtab=true
vim.opt.tabstop=2
vim.opt.shiftwidth=2

-- Always use the same register with external clipboard.
vim.opt.clipboard:append 'unnamedplus'

-- Alawys save current file before to move to other file.
vim.opt.autowrite=true

-- Show informatic extra columns.
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.foldcolumn='2'

-- NOTE: This options makes it automatically opens and closes current cursor
-- position. It's pretty fun but very confusing as for daily option.
-- Maybe used for later?
-- vim.opt.foldopen='all'
-- vim.opt.foldclose='all'

-- Fold options.
-- NOTE: treesitter fold expression is used instead.
-- vim.opt.foldmethod='syntax'
vim.opt.foldtext=''
vim.wo.foldmethod='expr'
vim.wo.foldexpr='v:lua.vim.treesitter.foldexpr()'

-- Line break options.
vim.opt.wrap=true
vim.opt.linebreak=true
vim.opt.breakindent=true
vim.opt.showbreak='~'
vim.opt.breakindentopt='sbr,shift:2'

-- Ask to save when leaving buffer without saving.
vim.opt.confirm=true

-- Highlight cursor column and line. 
-- vim.opt.cursorcolumn=true
vim.opt.cursorline=true
vim.opt.cursorlineopt='both'

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
vim.opt.splitbelow=true

-- Move cursor at the first non-blank character of the line. Useful maybe?
vim.opt.startofline=true

-- Set popup menu height.
vim.opt.pumheight=20

-- Show only one status line at the bottom
-- vim.opt.laststatus=3

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

-- Highlight on yank.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lsp_utils = require'utils.lsp'

-- Set LSP keymaps when LSP is attached.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    local methods = {
      'textDocument/codeAction',
      'textDocument/declaration',
      'textDocument/definition',
      'textDocument/implementation',
      'textDocument/typeDefinition',
      'textDocument/references',
      'textDocument/hover',
      'textDocument/rename',
    }

    for _, m in pairs(methods) do
      if client.supports_method(m) then lsp_utils.map_method(m) end
    end

    -- Show diagnostic window on CursorHold.
    vim.api.nvim_create_autocmd('CursorHold', {
      desc = 'Show diagnostic window on CursorHold',
      group = vim.api.nvim_create_augroup('diagnostic-on-cursorhold', { clear = true }),
      callback = function()
        vim.diagnostic.open_float()
      end
    })

    -- Reduce updatetime to open up diagnostic faster
    vim.opt.updatetime=1000
  end
})

-- Set padding to the hover window to prevent window to occupy full screan.
local HOVER_WINDOW_PADDING = 10
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    max_width = vim.o.columns - (HOVER_WINDOW_PADDING * 2),
    wrap = false,
  }
)

-- Set highlight groups.
vim.api.nvim_set_hl(0, '@markup.strong', { link = 'GruvboxPurpleBold' })
