return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        normal = 'gs',
        normal_cur = 'gss',
        normal_line = 'gS',
        normal_cur_line = 'gSS',
      }
    })
  end
}
