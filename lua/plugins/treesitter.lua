return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      modules = {},
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'markdown', 'java', 'javascript', 'typescript', 'html', 'latex' },
      ignore_install = {},
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "M",
          node_incremental = "M",
          scope_incremental = "H",
          node_decremental = "L",
        }
      },
      indent = {
        enable = true
      }
    }

  end
}
