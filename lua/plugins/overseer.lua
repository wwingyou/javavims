return {
  'stevearc/overseer.nvim',
  config = function ()
    require'overseer'.setup{
      task_list = {
        keymaps = {
          ['<C-j>'] = false,
          ['<C-k>'] = false,
        },
      },
    }

    vim.keymap.set('n', '<leader>rr', '<cmd>OverseerRun<CR>', { desc = '[Overseer] Run Task' });
    vim.keymap.set('n', '<leader>rt', '<cmd>OverseerToggle<CR>', { desc = '[Overseer] Toggle Task UI' });
     
    vim.api.nvim_create_user_command('ConfigTask', function()
      local config_file = vim.fn.getcwd() .. '/.vscode/tasks.json'

      vim.fn.mkdir(vim.fn.fnamemodify(config_file, ':h'), 'p');
      if vim.fn.filereadable(config_file) == 0 then
        vim.fn.writefile({
          '{',
          '  "version": "2.0.0",',
          '  "tasks": [',
          '    {',
          '      "label": "Example Task",',
          '      "type": "shell",',
          '      "command": "echo",',
          '      "args": [ "hello" ]',
          '    },',
          '  ]',
          '}',
        }, config_file);
      end
      vim.cmd('edit ' .. config_file);
    end, { desc = 'Config .vscode/tasks.json of this project.'});
  end
}
