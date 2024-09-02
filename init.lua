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

-- Line break options
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

-- Always add 'g' flag for substitution
vim.opt.gdefault=true

-- Use smartcase search
vim.opt.ignorecase=true
vim.opt.smartcase=true

-- Set list mode by default
vim.opt.list=true

-- Scroll options
vim.opt.scrolloff=10

-- Split options
vim.opt.splitright=true

-- Move cursor at the first non-blank character of the line. Useful maybe?
vim.opt.startofline=true

-- Set colorscheme.
vim.cmd 'colorscheme retrobox'

-- Enable matchit
vim.cmd 'packadd! matchit'
