M = {}

M.build_gradle_task = function (name, task, matcher)
  return {
    name = ' ' .. name,
    builder = function(params)
      return {
        cmd = {'./gradlew'},
        args = {task},
        cwd = '.',
      }
    end,
    condition = {
      callback = function(search)
        local build_file = vim.fn.glob(vim.fn.getcwd() .. '/build.gradle')
        if '' ~= build_file then
          if matcher == nil then
            return true
          end

          local lines = vim.fn.readfile(build_file)
          for _, line in ipairs(lines) do
            if string.match(line, matcher) then
              return true
            end
          end
        end
        return false
      end,
    },
  }
end

return M


