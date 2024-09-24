return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local default_opt = {
      layout_strategy = 'vertical',
      layout_config = {
        vertical = { preview_height = 0.75 }
      }
    }
    require'telescope'.setup { defaults = default_opt }

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function() builtin.find_files(default_opt) end, {})
    vim.keymap.set('n', '<leader>fg', function() builtin.live_grep(default_opt) end, {})
    vim.keymap.set('n', '<leader>fb', function() builtin.buffers(default_opt) end, {})
    vim.keymap.set('n', '<leader>fh', function() builtin.help_tags(default_opt) end, {})
  end
}
