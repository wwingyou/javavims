return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local default_opt = {
      layout_strategy = 'vertical',
      layout_config = {
        vertical = { preview_height = 0.75 }
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        }
      },
      file_ignore_patterns = { "%.class" }
    }
    require'telescope'.setup {
      defaults = default_opt,
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {
            -- even more opts
          }

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
          --   [kind] = {
          --     make_indexed = function(items) -> indexed_items, width,
          --     make_displayer = function(widths) -> displayer
          --     make_display = function(displayer) -> function(e)
          --     make_ordinal = function(e) -> string
          --   },
          --   -- for example to disable the custom builtin "codeactions" display
          --      do the following
          --   codeactions = false,
          -- }
        }
      }
    }
    require'telescope'.load_extension('ui-select')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', function() builtin.find_files(default_opt) end, {})
    vim.keymap.set('n', '<leader>fg', function() builtin.live_grep(default_opt) end, {})
    vim.keymap.set('n', '<leader>fb', function() builtin.buffers(default_opt) end, {})
    vim.keymap.set('n', '<leader>fh', function() builtin.help_tags(default_opt) end, {})
    vim.keymap.set('n', '<leader>fr', function() builtin.oldfiles(default_opt) end, {})
  end
}
