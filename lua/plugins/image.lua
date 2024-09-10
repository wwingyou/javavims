return {
  "3rd/image.nvim",
  -- NOTE: This plugin need many extra dependencies. 
  -- See 'https://github.com/3rd/image.nvim?tab=readme-ov-file'.
  -- Also, It has bug that image is preserved between tmux window switch. 
  -- (https://github.com/3rd/image.nvim/issues/106) Hope this will be fixed soon.
  -- TODO: It looks possible to implement image preview for oil and telescope upon this plugin.
  -- try using api (https://github.com/3rd/image.nvim?tab=readme-ov-file#api)
  opts = {
    backend = "kitty",
    kitty_method = "normal",
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = true,
        filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        resolve_image_path = function (document_path, image_path, fallback)
          return fallback(document_path, image_path)
        end
      },
      html = {
        enabled = false,
      },
      css = {
        enabled = false,
      },
    },
    max_width = nil,
    max_height = nil,
    max_width_window_percentage = nil,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = false,                                         -- toggles images when windows are overlapped
    window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    editor_only_render_when_focused = false,                                      -- auto show/hide images when the editor gains/looses focus
    tmux_show_only_in_active_window = false,                                      -- auto show/hide images in the correct Tmux window (needs visual-activity off)
    hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
  }
}
