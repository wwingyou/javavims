return {
  'https://github.com/AndrewRadev/switch.vim',
  config = function ()
    vim.keymap.set('n', '<C-s>', function ()
      vim.fn['switch#Switch']()
    end, { desc = 'switch keyword' });
  end,
}
