-- Highlight on yank.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lsp_utils = require'utils.lsp'

-- Set LSP keymaps when LSP is attached.
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    local methods = {
      'textDocument/codeAction',
      'textDocument/declaration',
      'textDocument/definition',
      'textDocument/implementation',
      'textDocument/typeDefinition',
      'textDocument/references',
      'textDocument/hover',
      'textDocument/rename',
    }

    for _, m in pairs(methods) do
      if client.supports_method(m) then lsp_utils.map_method(m) end
    end

    -- Show diagnostic window on CursorHold.
    vim.api.nvim_create_autocmd('CursorHold', {
      desc = 'Show diagnostic window on CursorHold',
      group = vim.api.nvim_create_augroup('diagnostic-on-cursorhold', { clear = true }),
      callback = function()
        vim.diagnostic.open_float()
      end
    })
  end
})

-- This custom hover handler removes long jdlts links
local hover = function(_, result, ctx, config)
  if not (result and result.contents) then
    return vim.lsp.handlers.hover(_, result, ctx, config)
  end

  local pattern = "%[([^%]%[]+)%]%(jdt[^%)%(]+%)"
  local repl = "**%1**"
  if type(result.contents) == "string" then
    local s = string.gsub(result.contents or "", pattern, repl)
    result.contents = s
  elseif result.contents['value'] ~= nil then
    local s = string.gsub((result.contents or {}).value or "", pattern, repl)
    result.contents.value = s
  else
    local s = string.gsub(result.contents[2] or "", pattern, repl)
    result.contents[2] = s
  end

  return vim.lsp.handlers.hover(_, result, ctx, config)
end

-- Set padding to the hover window to prevent window to occupy full screan.
local HOVER_WINDOW_PADDING = 10
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
  hover, {
    max_width = vim.o.columns - (HOVER_WINDOW_PADDING * 2),
    wrap = true,
  }
)
