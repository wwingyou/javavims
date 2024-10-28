return {
  'mfussenegger/nvim-dap',
  keys = {
    {
      '<CR>',
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
  }
}
