local M = {}

--- Check if quickfix list is open
---@return boolean
function M.is_quickfix_open()
  for _, win in ipairs(vim.fn.getwininfo()) do
    if win.quickfix > 0 then
      return true
    end
  end
  return false
end

return M
