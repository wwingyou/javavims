return {
  'ggandor/leap.nvim',
  config = function()
    vim.keymap.set({'n', 'x', 'o'}, 'f',  '<Plug>(leap-forward)', { desc = '[Leap] forward' })
    vim.keymap.set({'n', 'x', 'o'}, 'F',  '<Plug>(leap-backward)', { desc = '[Leap] backward' })
  end
}
