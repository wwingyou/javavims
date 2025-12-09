-- https://github.com/neovim/nvim-lspconfig
return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.lsp.config('lua_ls', {})
    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          diagnostics = {
            enable = false;
          },
          checkOnSave = {
            enable = false;
          }
        }
      }
    })
    vim.lsp.config('bacon_ls', {
      init_options = {
        updateOnSave = true,
        updateOnSaveWaitMillis = 1000,
      }
    })
    vim.lsp.config('ts_ls', {})

    vim.lsp.enable('lua_ls')
    vim.lsp.enable('rust_analyzer')
    vim.lsp.enable('bacon_ls')
    vim.lsp.enable('ts_ls')
  end
}
