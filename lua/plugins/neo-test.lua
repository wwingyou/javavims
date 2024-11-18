return {
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap", -- for the debugger
      "rcarriga/nvim-dap-ui", -- recommended
      "theHamsta/nvim-dap-virtual-text", -- recommended
    },
  },
  {
    'nvim-neotest/neotest-jest',
    ft = { 'javascript', 'typescript' }
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    },
    keys = {
      {
        '<leader>rf',
        function() require'neotest'.run.run(vim.fn.expand('%')) end,
        mode = 'n',
        desc = 'run test file',
      },
      {
        '<leader>rt',
        function() require'neotest'.run.run() end,
        mode = 'n',
        desc = 'run test file',
      },
      {
        '<leader>dt',
        function() require'neotest'.run.run({ strategy = 'dap' }) end,
        mode = 'n',
        desc = 'run test file',
      },
      {
        '<leader>df',
        function()
          require'neotest'.run.run({ vim.fn.expand('%'), strategy = 'dap' })
        end,
        mode = 'n',
        desc = 'run test file',
      }
    },
    config = function()
      require'neotest'.setup {
        adapters = {
          require'neotest-jest' {
            jestCommand = "npm test --",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
          require'neotest-java',
        }
      }
    end
  },
}
