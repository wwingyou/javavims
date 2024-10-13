return {
  'vim-test/vim-test',
  lazy = true,
  keys = {
    { '<leader>rts', '<cmd>TestSuite<CR>', mode = 'n', desc = 'Test suite' },
    { '<leader>rtf', '<cmd>TestFile<CR>', mode = 'n', desc = 'Test file' },
    { '<leader>rtn', '<cmd>TestNearest<CR>', mode = 'n', desc = 'Test nearest' },
    { '<leader>rtt', '<cmd>TestLast<CR>', mode = 'n', desc = 'Test last' },
  }
}
