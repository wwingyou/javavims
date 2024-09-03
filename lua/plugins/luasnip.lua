return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  dependencies = {
    "rafamadriz/friendly-snippets"
  },
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  config = function()
    require'luasnip.loaders.from_vscode'.lazy_load()
    local ls = require'luasnip'

    -- FIXME: This code cannot pregress to the last position when continually jumping forward in insert mode.
    -- Problem is fixed if I jump in select mode or returning from the end in select mode. Why?
    -- vim.keymap.set({"i", "s"}, "<Tab>", function()
    --   if ls.expand_or_jumpable() then
    --     ls.jump(1)
    --   else
    --     return '<Tab>'
    --   end
    -- end, { silent = true, expr = true })
    -- vim.keymap.set({"i", "s"}, "<S-Tab>", function() ls.jump(-1) end, {silent = true})

    -- This keymap is pretty good. May I use this?
    vim.keymap.set({"i", "s"}, "<C-L>", function()
      ls.jump( 1)
    end, { desc = 'Luasnip jump forward', silent = true })
    vim.keymap.set({"i", "s"}, "<C-J>", function()
      ls.jump(-1)
    end, { desc = 'Luasnip jump backward', silent = true})
  end
}
