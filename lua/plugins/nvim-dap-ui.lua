return {
  "rcarriga/nvim-dap-ui",
  keys = {
    { '<leader>du', function() require'dapui'.toggle() end, mode = 'n', desc = '[Debug] toggle dabug ui' }
  },
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  opts = {}
}
