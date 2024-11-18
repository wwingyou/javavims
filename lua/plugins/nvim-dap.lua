return {
  'mfussenegger/nvim-dap',
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
      desc = '[DEBUG] list breakpoints to quickfix list',
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
    },
    {
      '<leader>dr',
      function() require'dap'.repl.open() end,
      mode = 'n',
      desc = '[DEBUG] open repl',
    }
  },
  config = function()
    vim.fn.sign_define('DapBreakpoint', {text='', texthl='GruvboxRedSign', linehl='', numhl=''})
  end
}
