-- Set global variables.
vim.g.mapleader=' '
vim.g.maplocalleader=' '

-- Require lazy.nvim
require 'config.lazy'

-- Set colorscheme 'gruvbox'
vim.cmd 'colorscheme gruvbox'

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

-- LSP configs with mason.
local mason_bin_dir = vim.fn.stdpath('data') .. '/mason/bin'

-- Load cmp_nvim_lsp capabilities
local capabilites = require('cmp_nvim_lsp').default_capabilities()

-- Lua language server for nvim configuration.
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Start lua-language-server when lua filetype is attached',
  pattern = 'lua',
  group = vim.api.nvim_create_augroup('lsp-lua', { clear = true }),
  callback = function(ev)
    vim.lsp.start {
      name = 'lua-language-server',
      cmd = { mason_bin_dir .. '/lua-language-server' },
      capabilities = capabilites,
      root_dir = vim.fs.root(ev.buf, { 'init.lua', 'init.vim' }),
      settings = {
        Lua = {
          runtime = {
            -- 'init.lua' has higher proirity so that I can load modele properly.
            path = { '?/init.lua', '?.lua' },
          },
          workspace = {
            library = {
              -- Add vim standard library.
              vim.env.VIMRUNTIME,
              -- Add lazy plugin libraries,
              vim.fn.stdpath('data') .. '/lazy',
            }
          }
        }
      }
    }
  end
})

-- Set LSP keymaps when LSP is attached.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.supports_method('textDocument/codeAction') then
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { desc = 'LSP code action' })
    end
    if client.supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP go to declaration' })
    end
    if client.supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP go to definition' })
    end
    if client.supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP go to implementation' })
    end
    if client.supports_method('textDocument/typeDefinition') then
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'LSP go to type definition' })
    end
    if client.supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP find references' })
    end
    if client.supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
    end
    if client.supports_method('textDocument/rename') then
      -- If supports, replace 'R' keymap to rename lsp function. If not, use substitution instead.
      vim.keymap.set('n', 'R', vim.lsp.buf.rename, { desc = 'LSP rename' })
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
