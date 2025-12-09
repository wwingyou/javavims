return {
  'stevearc/overseer.nvim',
  config = function ()
    require'overseer'.setup{
      templates = {
        'builtin', 'gradle'
      },
      task_list = {
        keymaps = {
          ["<C-j>"] = false,
          ["<C-k>"] = false,
        },
      },
    }

    vim.keymap.set('n', '<leader>rr', '<cmd>OverseerRun<CR>', { desc = '[Overseer] Run Task' });
    vim.keymap.set('n', '<leader>rt', '<cmd>OverseerToggle<CR>', { desc = '[Overseer] Toggle Task UI' });
  end
}
