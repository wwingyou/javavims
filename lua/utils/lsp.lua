local M = {}

--- List of all available methods.
--- pass this list to `map_method()` to map all methods.
---
--- @see map_method
---
--- @return unknown methods
function M.all_methods()
  return {
    'textDocument/codeAction',
    'textDocument/declaration',
    'textDocument/definition',
    'textDocument/implementation',
    'textDocument/typeDefinition',
    'textDocument/references',
    'textDocument/hover',
    'textDocument/rename',
  }
end

--- Maps LSP keymap with given method.
---
--- NOTE: this is a place to define keymaps for lsp.
--- since different lsp offers different set of methods, 
--- it's preferd to asign all keymaps in single place, and 
--- use it througout configuratoin.
---
--- Example:
---
--- ```lua
--- local mapper = require'utils.lsp'
--- mapper.map_method('textDocument/codeAction')
--- ```
---
---@param method string
function M.map_method(method)
    if method == 'textDocument/codeAction' then
      vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { desc = 'LSP code action' })
    elseif method == 'textDocument/declaration' then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP go to declaration' })
    elseif method == 'textDocument/definition' then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP go to definition' })
    elseif method == 'textDocument/implementation' then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP go to implementation' })
    elseif method == 'textDocument/typeDefinition' then
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'LSP go to type definition' })
    elseif method == 'textDocument/references' then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'LSP find references' })
    elseif method == 'textDocument/hover' then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP hover' })
    elseif method == 'textDocument/rename' then
      -- If supports, replace 'R' keymap to rename lsp function. If not, use substitution instead.
      vim.keymap.set('n', 'R', vim.lsp.buf.rename, { desc = 'LSP rename' })
    end
end

--- Maps all given methods.
---
--- This method internally call `map_method()`.
--- Example:
---
--- ```lua
--- local mapper = require'utils.lsp-keymapper'
--- mapper.map_methods(mapper.all_methods)
--- ```
---
---@param methods string[]
---
---@see map_method
function M.map_methods(methods)
  for _, method in pairs(methods) do
    M.map_method(method)
  end
end

--- Get common lsp capabilites.
---
---@return unknown capabilites
function M.capabilities()
  return require('cmp_nvim_lsp').default_capabilities()
end

return M
