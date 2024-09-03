return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = true,
  opts = {
    options = {
      theme = 'gruvbox',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      globalstatus = true
    },
    sections = {
      lualine_b = {},
      lualine_c = { 'branch', 'filename' },
      lualine_x = { 'encoding', 'filetype', 'progress' },
      lualine_y = {}
    }
  }
}
