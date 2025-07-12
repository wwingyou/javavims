return {
  "hasansujon786/nvim-navbuddy",
  dependencies = {
    "SmiteshP/nvim-navic",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "neovim/nvim-lspconfig"
  },
  keys = {
    { "<leader>nv", "<cmd>Navbuddy<cr>", desc = "Open Navbuddy" },
  },
  opts = {
    window = {
      border = "rounded",
      size = "60%",
      position = "50%",
      scrolloff = nil,
      sections = {
        left = {
          size = "20%",
          border = nil,
        },
        mid = {
          size = "40%",
          border = nil,
        },
        right = {
          size = "40%",
          border = nil,
        }
      }
    },
    node_markers = {
      enabled = true,
      icons = {
        leaf = "  ",
        leaf_selected = " → ",
        branch = " ",
      }
    },
    icons = {
      File          = "󰈙 ",
      Module        = " ",
      Namespace     = "󰌗 ",
      Package       = " ",
      Class         = "󰌗 ",
      Method        = "󰆧 ",
      Property      = " ",
      Field         = " ",
      Constructor   = " ",
      Enum          = "󰕘",
      Interface     = "󰕘",
      Function      = "󰊕 ",
      Variable      = "󰆧 ",
      Constant      = "󰏿 ",
      String        = "󰀬 ",
      Number        = "󰎠 ",
      Boolean       = "◩ ",
      Array         = "󰅪 ",
      Object        = "󰅩 ",
      Key           = "󰌋 ",
      Null          = "󰟢 ",
      EnumMember    = " ",
      Struct        = "󰌗 ",
      Event         = " ",
      Operator      = "󰆕 ",
      TypeParameter = "󰊄 ",
    },
    use_default_mappings = true,
    lsp = {
      auto_attach = false,  -- We'll handle attachment manually for better control
      preference = nil,
    },
    source_buffer = {
      follow_node = true,
      highlight = true,
      reorient = "smart",
      scrolloff = nil
    },
    custom_hl_group = nil,
  }
}

