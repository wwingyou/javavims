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
      '<UP>',
      function() require'dap'.step_out() end,
      mode = 'n',
      desc = '[DEBUG] step out',
    },
    {
      '<DOWN>',
      function() require'dap'.step_into() end,
      mode = 'n',
      desc = '[DEBUG] step into',
    },
    {
      '<LEFT>',
      function() require'dap'.step_over() end,
      mode = 'n',
      desc = '[DEBUG] step over',
    },
    {
      '<RIGHT>',
      function() require'dap'.continue() end,
      mode = 'n',
      desc = '[DEBUG] continue',
    },
    {
      '<leader>dd',
      function() require'dap'.run_last() end,
      mode = 'n',
      desc = '[DEBUG] re-run debugger',
    }
  },
  config = function()
    local dap = require('dap')
    dap.listeners.before['launch']['jdtls'] = function(_, _)
      vim.cmd([[DapViewOpen]])
      print("debuggin started")
    end
        dap.listeners.before['attach']['jdtls'] = function(_, _)
      vim.cmd([[DapViewOpen]])
      print("debuggin attached")
    end
    dap.listeners.after['event_terminated']['jdtls'] = function(_, _)
      vim.cmd([[DapViewClose]])
      print("The debugging process is terminated")
    end
    vim.fn.sign_define('DapBreakpoint', {text='', texthl='Error', linehl='', numhl=''})
  end
}
