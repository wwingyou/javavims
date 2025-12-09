return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local custom_tokyonight = require'lualine.themes.tokyonight-moon'

    custom_tokyonight.normal.c.bg = "none"

    require("lualine").setup({
      options = {
        theme = custom_tokyonight,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        always_divide_middle = false,
        globalstatus = true,
      },
      on_colors = function(colors)
        colors.bg_statusline = colors.none
      end,
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { '%=', { 'filename', file_status = true } },
        lualine_x = {},
        lualine_y = { 'encoding', 'progress' },
        lualine_z = { 'location' }
      },
    })
  end,
}
