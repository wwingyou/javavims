vim.bo.tabstop=4
vim.bo.shiftwidth=4

-- Find build tools and set makeprg.
if #vim.fs.find({ 'gradlew' }, {}) > 0 then
  vim.bo.makeprg='./gradlew compileJava'
elseif #vim.fs.find({ 'mvnw' }, {}) > 0 then
  vim.bo.makeprg='./mvnw compile'
end

-- Set fold level 1 by default to show root class.
vim.wo.foldlevel=1

-- Map all lsp method keymaps.
local mapper = require'utils.lsp-keymapper'
mapper.map_methods(mapper.all_methods)

-- Organize imports before buffer write
vim.api.nvim_create_autocmd('BufWrite', {
  desc = 'Organize imports before buffer write',
  pattern = '*.java',
  group = vim.api.nvim_create_augroup('bufwrite-java', { clear = true }),
  callback = function(_)
    require'jdtls'.organize_imports()
  end
})

