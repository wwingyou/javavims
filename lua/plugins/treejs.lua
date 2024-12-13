return {
  'Wansmer/treesj',
  keys = {
    { '<space>m', desc = 'Select more' },
    { '<space>j', desc = 'Select many' },
    { '<space>s', desc = 'De-select more' },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup {

    }
  end,
}
