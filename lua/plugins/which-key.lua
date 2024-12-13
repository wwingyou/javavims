return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  config = function(opts)
    local wc = require 'which-key'
    wc.setup(opts)
    wc.add({
      { '<leader>f', group = 'Find' },
      { '<leader>c', group = 'Create or Clear' },
      { '<leader>d', group = 'Debug' },
      { '<leader>q', group = 'Quickfix' },
      { '<leader>r', group = 'Run' },
    })
  end
}
