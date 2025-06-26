return {
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap", -- for the debugger
      -- "rcarriga/nvim-dap-ui", -- recommended
      "igorlfs/nvim-dap-view", -- changed
      "theHamsta/nvim-dap-virtual-text", -- recommended
    },
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
        '<leader>tR',
        function()
          local neotest = require'neotest'
          neotest.run.run(vim.fn.expand('%'))
          neotest.summary.open()
          neotest.output_panel.open()
        end,
        mode = 'n',
        desc = '[Test] run test file',
      },
      {
        '<leader>tr',
        function() require'neotest'.run.run() end,
        mode = 'n',
        desc = '[Test] run nearest test',
      },
      {
        '<leader>tD',
        function()
          local neotest = require'neotest'
          neotest.run.run({ vim.fn.expand('%'), strategy = 'dap' })
          neotest.summary.open()
          neotest.output_panel.open()
        end,
        mode = 'n',
        desc = '[Test] debug test file',
      },
      {
        '<leader>td',
        function() require'neotest'.run.run({ strategy = 'dap' }) end,
        mode = 'n',
        desc = '[Test] debug nearest test',
      },
      {
        '<leader>tW',
        function()
          require'neotest'.watch.toggle({ vim.fn.expand('%'), strategy = 'dap' })
        end,
        mode = 'n',
        desc = '[Test] toggle watch test file',
      },
      {
        '<leader>tw',
        function() require'neotest'.watch.toggle({ strategy = 'dap' }) end,
        mode = 'n',
        desc = '[Test] toggle watch nearest test',
      },
      {
        '<leader>ts',
        function() require'neotest'.summary.toggle() end,
        mode = 'n',
        desc = '[Test] toggle test summary window',
      },
      {
        '<leader>to',
        function() require'neotest'.output_panel.toggle() end,
        mode = 'n',
        desc = '[Test] toggle test output panel',
      },
      {
        '<leader>tc',
        function()
          local neotest = require'neotest'
          neotest.output_panel.clear()
          neotest.summary.close()
        end,
        mode = 'n',
        desc = '[Test] clear neotest windows',
      },
    },
    config = function()
      require'neotest'.setup {
        adapters = {
          require'neotest-java',
        },
        output_panel = {
          open = '10sp'
        }
      }
    end
  },
}
