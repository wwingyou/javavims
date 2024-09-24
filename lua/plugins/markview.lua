return {
  'OXY2DEV/markview.nvim',
  lazy = false,      -- Recommended
  -- ft = 'markdown' -- If you decide to lazy-load anyway
  dependencies = {
    -- You will not need this if you installed the
    -- parsers manually
    -- Or if the parsers are in your $RUNTIMEPATH
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    modes = { 'n', 'no', 'c' }, -- Change these modes
    -- to what you need
    hybrid_modes = { 'n' },     -- Uses this feature on
    -- normal mode
    -- This is nice to have
    highlight_groups = {
      {
        group_name = 'Heading1Sign',
        value = {
          link = 'DiagnosticSignHint'
        }
      },
      {
        group_name = 'Heading2Sign',
        value = {
          link = 'DiagnosticSignInfo'
        }
      },
    },
    list_items = {
      enable = true,
      shift_width = 4,
      indent_size = 2,

      marker_minus = {
        text = ''
      },
      marker_plus = {
        text = ''
      },
      marker_star = {
        text = ''
      },
      marker_dot = {}
    },
  }
}
