return {
  "m4xshen/hardtime.nvim",
  enabled = false,
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  config = function(opt)
    local default_config = require'hardtime.config'.config
    vim.tbl_extend('force', default_config, opt)
    default_config.disabled_keys = {}
    default_config.restricted_keys['<CR>'] = nil
    require'hardtime'.setup(default_config)
  end
}
