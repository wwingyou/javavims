return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mxsdev/nvim-dap-vscode-js'
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
    },
    {
      '<leader>dr',
      function() require'dap'.repl.toggle() end,
      mode = 'n',
      desc = '[DEBUG] open repl',
    }
  },
  config = function()
    -- dap.defaults.fallback.external_terminal = {
    --   command = '/opt/homebrew/bin/tmux';
    --   args = {'split-pane'};
    -- }
    -- dap.defaults.fallback.force_external_terminal = true
    local root_dir = require'mason.settings'.current.install_root_dir .. '/packages'
    local dap = require('dap')
    require("dap-vscode-js").setup({
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      debugger_path = root_dir .. '/js-debug-adapter',
      debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
      -- log_file_path = vim.fn.stdpath('log') .. "/dap_vscode_js.log", -- Path for file logging
      -- log_file_level = false, -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
      port = 8123
    })

    for _, language in ipairs({ "typescript", "javascript" }) do
      require("dap").configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          port = 8123,
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          port = 8123,
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest Tests",
          port = 8123,
          -- trace = true, -- include debugger info
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
          },
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
        }
      }
    end
    vim.fn.sign_define('DapBreakpoint', {text='', texthl='GruvboxRedSign', linehl='', numhl=''})
  end
}
