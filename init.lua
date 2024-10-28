-- Set global variables.
vim.g.mapleader=' '
vim.g.maplocalleader=' '

-- Require lazy.nvim
require 'config.lazy'
require 'options'
require 'highlights'
require 'keymaps'
require 'autocmds'

-- Set colorscheme 'gruvbox'
vim.cmd 'colorscheme gruvbox'

-- Enable matchit.
vim.cmd 'packadd! matchit'
