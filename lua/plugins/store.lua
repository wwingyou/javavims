return {
  -- "alex-popov-tech/store.nvim",
  dir = "/Users/dogchew/workspace/nvim/store.nvim",
  dependencies = {
    "OXY2DEV/markview.nvim", -- optional, for pretty readme preview / help window
  },
  cmd = "Store",
  keys = {
    { "<leader>ss", "<cmd>Store<cr>", desc = "Open Plugin Store" },
  },
  opts = {
    -- optional configuration here
  },
}
