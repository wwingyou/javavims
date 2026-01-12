return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      "igorlfs/nvim-dap-view",
      ---@module 'dap-view'
      ---@type dapview.Config
      opts = {},
    },
  },
  keys = {
    {
      '<leader>cb',
      function() require'dap'.clear_breakpoints() end,
      mode = 'n',
      desc = '[DEBUG] clear breakpoints',
    },
    {
      '<leader>qb',
      function()
        require'dap'.list_breakpoints()
        vim.cmd([[copen]])
      end,
      mode = 'n',
      desc = '[Quickfix] open breakpoint list',
    },
    {
      '<C-B>',
      function() require'dap'.toggle_breakpoint() end,
      mode = 'n',
      desc = '[DEBUG] toggle breakpoints',
    },
    {
      '<leader>dd',
      function() require'dap'.continue() end,
      mode = 'n',
      desc = '[DEBUG] run debug',
    },
    {
      '<leader>sd',
      function() require'dap'.terminate() end,
      mode = 'n',
      desc = '[DEBUG] stop debug',
    }
  },
  config = function()
    local dap = require('dap')
    dap.listeners.before['launch']['jdtls'] = function(_, _)
      vim.cmd([[DapViewOpen]])

      vim.keymap.set("n", "<UP>", function()
        dap.restart_frame()
      end, { desc = "[DEBUG] restart frame" })

      vim.keymap.set("n", "<DOWN>", function()
        dap.step_over()
      end, { desc = "[DEBUG] step over" })

      vim.keymap.set("n", "<LEFT>", function()
        dap.step_out()
      end, { desc = "[DEBUG] step out" })

      vim.keymap.set("n", "<RIGHT>", function()
        dap.step_into()
      end, { desc = "[DEBUG] step into" })

      print("Debugging started")
    end
    dap.listeners.before['event_terminated']['jdtls'] = function(_, _)
      vim.cmd([[DapViewClose]])

      vim.keymap.del("n", "<UP>")
      vim.keymap.del("n", "<DOWN>")
      vim.keymap.del("n", "<LEFT>")
      vim.keymap.del("n", "<RIGHT>")

      print("The debugging process is terminated")
    end

    vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapUIStop', linehl='', numhl=''})
  end
}
