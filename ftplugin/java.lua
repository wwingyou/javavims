vim.bo.tabstop=4
vim.bo.shiftwidth=4

-- Find build tools and set makeprg.
if #vim.fs.find({ 'gradlew' }, {}) > 0 then
  vim.bo.makeprg='./gradlew compileJava'
elseif #vim.fs.find({ 'mvnw' }, {}) > 0 then
  vim.bo.makeprg='./mvnw compile'
end

-- Map all lsp method keymaps.
local lsp_utils = require'utils.lsp'
lsp_utils.map_methods(lsp_utils.all_methods())

-- Lsp setup.
local function get_data_dir()
  local data_dir = vim.fn.stdpath('data')
  if type(data_dir) == 'table' then data_dir = data_dir[0] end
  if data_dir == nil then
    data_dir = vim.env.XDG_DATA_HOME or (vim.fn.expand('~/.local/share'))
    data_dir = data_dir .. '/nvim'
  end

  return data_dir
end

local mason_root = require'mason.settings'.current.install_root_dir .. '/share'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local jdtls_path = mason_root .. '/jdtls'
-- NOTE: Use jdtls 1.39.0
-- local jdtls_path = vim.fn.stdpath('config') .. '/lsp/jdtls'
local java_debug_path = mason_root .. '/java-debug-adapter'
local java_test_path = mason_root .. '/java-test'
local jar = jdtls_path .. '/plugins/org.eclipse.equinox.launcher.jar'
local config = jdtls_path .. '/config'
local lombok = jdtls_path .. '/lombok.jar'
-- local aspectj = jdtls_path .. '/aspectjweaver-1.9.23.jar'
local workspace = vim.fn.stdpath('cache') .. '/jdtls/workspace/' .. project_name
local java_debug_plugin = java_debug_path .. '/com.microsoft.java.debug.plugin.jar'
local java_test_plugins = vim.split(vim.fn.glob(java_test_path .. '/*.jar'), '\n')
local bundles = { java_debug_plugin }
vim.list_extend(bundles, java_test_plugins)

local jdk_root = '~/.sdkman/candidates/java'
local client_id = require('jdtls').start_or_attach {
  name = 'jdtls',
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. lombok,
    -- '-javaagent:' .. aspectj,
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', jar,
    '-configuration', config,
    '-data', workspace
  },
  capabilities = lsp_utils.capabilities(),
  root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew' }),
  init_options = {
    bundles = bundles
  },
  settings = {
    java = {
      completion = {
        enabled = true,
        importOrder = {
          'java',
          'jakarta',
          'javax',
          'org',
          'com',
          'lombok',
          'groovy'
        }
      },
      configuration = {
        -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
        -- And search for `interface RuntimeOption`
        -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
        runtimes = {
          {
            name = 'JavaSE-11',
            path = vim.fn.expand(jdk_root .. '/11.*-tem/'),
          },
          {
            name = 'JavaSE-17',
            path = vim.fn.expand(jdk_root .. '/17.*-tem/'),
          },
          {
            name = 'JavaSE-21',
            path = vim.fn.expand(jdk_root .. '/21.*-tem/'),
          },
          {
            name = 'JavaSE-23',
            path = vim.fn.expand(jdk_root .. '/23.*-tem/'),
          },
        }
      },
    }
  }
}

-- Add event handler for when JDTLS is fully initialized
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'JDTLS initialization event handler',
  pattern = '*.java',
  group = vim.api.nvim_create_augroup('jdtls-init', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'jdtls' then
      print("=== JDTLS INITIALIZATION ===")
      print(string.format("✓ JDTLS fully initialized for buffer %d", args.buf))
      print(string.format("✓ Client ID: %d", client.id))
      print(string.format("✓ File: %s", vim.api.nvim_buf_get_name(args.buf)))
      print(string.format("✓ Root directory: %s", client.config.root_dir or "Unknown"))
      print(string.format("✓ Server capabilities loaded: %s", 
        client.server_capabilities and "Yes" or "No"))
      
      -- Attach navic for breadcrumbs
      local navic = require'nvim-navic'
      local bufnr = args.buf

      if navic then
        local buf_name = vim.api.nvim_buf_get_name(bufnr)
        local buf_filetype = vim.bo[bufnr].filetype
        
        -- Print detailed navic attachment information
        print("=== NAVIC ATTACHMENT INFO ===")
        print(string.format("✓ Navic attached to buffer %d", bufnr))
        print(string.format("✓ File: %s", buf_name))
        print(string.format("✓ Filetype: %s", buf_filetype))
        print(string.format("✓ LSP Client: %s (ID: %d)", client.name, client.id))
        print(string.format("✓ Document symbols supported: %s", 
          client.server_capabilities.documentSymbolProvider and "Yes" or "No"))
        
        navic.attach(client, bufnr)
        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      end
      
      -- Attach navbuddy for symbol navigation
      local navbuddy = require'nvim-navbuddy'
      if navbuddy then
        print("✓ Navbuddy attached to JDTLS client")
        navbuddy.attach(client, bufnr)
      end
      
      print("============================")
    end
  end
})

vim.keymap.set('n', '<leader>oi', function() require'jdtls'.organize_imports() end, { desc = '[JDTLS] Organize imports'})

-- vim.keymap.set(
--   'n',
--   '<leader>df',
--   function() require'jdtls'.test_class() end,
--   { desc = 'java debug testing class'}
-- )
--
-- vim.keymap.set(
--   'n',
--   '<leader>dn',
--   function() require'jdtls'.test_nearest_method() end,
--   { desc = 'java debug testing nearest method'}
-- )

-- Organize imports before buffer write
-- NOTE: Commented out to resolve LSP error
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   desc = 'Organize imports before buffer write',
--   pattern = '*.java',
--   group = vim.api.nvim_create_augroup('bufwrite-java', { clear = true }),
--   callback = function(_)
--     if vim.bo.filetype == 'java' then
--       require'jdtls'.organize_imports()
--       vim.cmd([[:write]])
--     end
--   end
-- })
--
-- require'dap'.configurations.java = {
--   {
--     console = 'externalTerminal',
--     request = 'launch',
--     type = 'java',
--   }
-- }

-- vim.keymap.set('n', '<C-R>', '<cmd>VimuxRunCommand "./gradlew bootRun"<CR>', { desc = "[Run] spring boot project on tmux pane" })
