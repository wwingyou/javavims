return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'tokyonight-moon',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      always_divide_middle = false,
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { '%=', { 'filename', file_status = true } },
      lualine_x = {},
      lualine_y = { 'encoding', 'progress' },
      lualine_z = { 'location' }
    }
  }
}
