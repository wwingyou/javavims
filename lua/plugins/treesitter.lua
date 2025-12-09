return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter.configs'.setup {
      modules = {},
      ensure_installed = {
        'c',
        'lua',
        'vim',
        'vimdoc',
        'markdown',
        'markdown_inline',
        'java',
        'javascript',
        'typescript',
        'html',
      },
      ignore_install = {},
      auto_install = true,
      sync_install = false,
      highlight = {
        enable = true,
        -- additional_vim_regex_highlighting = true,
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
