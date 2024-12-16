vim.keymap.set('n', '<C-R>', function()
  local file_path = vim.api.nvim_buf_get_name(0)
  local file_name = vim.fn.fnamemodify(file_path, ":t")

  local result = vim.system({ 'python', file_name }, { text = false }):wait()

  if result.code == 0 then
    local stdout, _ = string.gsub(result.stdout, '\n$', '')
    print(stdout)
  else
    local stderr, _ = string.gsub(result.stderr, '\n$', '')
    error(stderr, 1)
  end
end, { desc = '[Run] current python script' })
