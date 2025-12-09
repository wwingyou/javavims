-- Set global variables.
vim.g.mapleader=' '
vim.g.maplocalleader=' '

-- Require lazy.nvim
require 'config.lazy'
require 'options'
require 'highlights'
require 'keymaps'
require 'autocmds'
require 'usercmds'

-- Set colorscheme 'gruvbox'
vim.cmd 'colorscheme catppuccin'

-- Enable matchit.
-- vim.cmd 'packadd! matchit'
