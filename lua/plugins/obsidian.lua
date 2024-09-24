return {
  'epwalsh/obsidian.nvim',
  version = '*',  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  keys = {
    { '<leader>fn', '<cmd>ObsidianSearch<CR>', mode = 'n', desc = 'search obsidian' },
    { '<leader>cc', '<cmd>ObsidianNew<CR>', mode = 'n', desc = 'create obsidian capture note' },
    { '<leader>ct', '<cmd>ObsidianToday<CR>', mode = 'n', desc = 'create obsidian today note' },
    { 'gf', '<cmd>ObsidianFollowLink<CR>', mode = 'n', desc = 'obsidian follow link' },
  },
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. 'BufReadPre ' .. vim.fn.expand '~' .. '/my-vault/*.md'
  --   -- refer to `:h file-pattern` for more examples
  --   'BufReadPre ' .. vim.fn.expand '~' .. '/Notes/*.md',
  --   'BufNewFile ' .. vim.fn.expand '~' .. '/Notes/*.md',
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter',
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '~/Notes',
      },
    },
    open_app_foreground = true,
    notes_subdir = "Inbox",
    new_notes_location = "notes_subdir",
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = 'Daily',
      -- Optional, if you want to change the date format for the ID of daily notes.
      -- date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      -- alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil
    }
  },
}
