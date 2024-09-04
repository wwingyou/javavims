vim.opt.tabstop=4
vim.opt.shiftwidth=4

-- Find build tools and set makeprg.
if #vim.fs.find({ 'gradlew' }, {}) > 0 then
  vim.opt.makeprg='./gradlew compileJava'
elseif #vim.fs.find({ 'mvnw' }, {}) > 0 then
  vim.opt.makeprg='./mvnw compile'
end

-- Set fold level 1 by default to show root class.
vim.opt.foldlevel=1
