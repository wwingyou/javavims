return {
  'Wansmer/treesj',
  keys = { 'gj' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup {
      use_default_keymaps = false
    }

    vim.keymap.set('n', 'gj', require'treesj'.toggle, { desc = '[Edit] toggle treesj' })
  end,
}
