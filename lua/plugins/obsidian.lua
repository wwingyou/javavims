return {
  'epwalsh/obsidian.nvim',
  version = '*',  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  keys = {
    { '<leader>fn', '<cmd>ObsidianSearch<CR>', mode = 'n', desc = 'search obsidian' },
    { '<leader>cc', '<cmd>ObsidianNew<CR>', mode = 'n', desc = 'create obsidian capture note' },
    { '<leader>ct', '<cmd>ObsidianToday<CR>', mode = 'n', desc = 'create obsidian today note' },
  },
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. 'BufReadPre ' .. vim.fn.expand '~' .. '/my-vault/*.md'
  --   -- refer to `:h file-pattern` for more examples
  --   'BufReadPre ' .. vim.fn.expand '~' .. '/Notes/*.md',
  --   'BufNewFile ' .. vim.fn.expand '~' .. '/Notes/*.md',
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter',
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '~/Notes',
      },
    },
    open_app_foreground = true,

    -- see below for full list of options 👇
  },
}
