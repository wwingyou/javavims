vim.api.nvim_create_user_command('TextTest', function ()
  local NuiText = require("nui.text")

  local text = NuiText("Something Went Wrong!", "Error")

  local bufnr, ns_id, linenr_start, byte_start = 0, -1, 1, 0

  text:render(bufnr, ns_id, linenr_start, byte_start)
end, {})

vim.api.nvim_create_user_command('InputTest', function ()
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  local input = Input({
    position = "50%",
    size = {
      width = 20,
    },
    border = {
      style = "single",
      text = {
        top = "[Howdy?]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
      prompt = "> ",
      default_value = "Hello",
      on_close = function()
        print("Input Closed!")
      end,
      on_submit = function(value)
        print("Input Submitted: " .. value)
      end,
    })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end, {})

vim.api.nvim_create_user_command('MenuTest', function ()
  local Menu = require("nui.menu")
  local event = require("nui.utils.autocmd").event

  local menu = Menu({
    position = "50%",
    size = {
      width = 25,
      height = 5,
    },
    border = {
      style = "single",
      text = {
        top = "[Choose-an-Element]",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
      lines = {
        Menu.item("Hydrogen (H)"),
        Menu.item("Carbon (C)"),
        Menu.item("Nitrogen (N)"),
        Menu.separator("Noble-Gases", {
          char = "-",
          text_align = "right",
        }),
        Menu.item("Helium (He)"),
        Menu.item("Neon (Ne)"),
        Menu.item("Argon (Ar)"),
      },
      max_width = 20,
      keymap = {
        focus_next = { "j", "<Down>", "<Tab>" },
        focus_prev = { "k", "<Up>", "<S-Tab>" },
        close = { "<Esc>", "<C-c>" },
        submit = { "<CR>", "<Space>" },
      },
      on_close = function()
        print("Menu Closed!")
      end,
      on_submit = function(item)
        print("Menu Submitted: ", item.text)
      end,
    })

  -- mount the component
  menu:mount()
end, {})

vim.api.nvim_create_user_command('PopupTest', function ()
  local Popup = require("nui.popup")
  local event = require("nui.utils.autocmd").event

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
    },
    position = "50%",
    size = {
      width = "80%",
      height = "60%",
    },
    buf_options = {
      readonly = true
    }
  })

  -- mount/open the component
  popup:mount()

  -- unmount component when cursor leaves buffer
  popup:on(event.BufLeave, function()
    popup:unmount()
  end)

  -- set content
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, { "Hello World" })
end, {})

