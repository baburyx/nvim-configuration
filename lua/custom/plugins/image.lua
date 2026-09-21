return {
  '3rd/image.nvim',
  build = false, -- use the magick_cli processor; don't build the luarocks magick rock
  event = 'BufReadPre',
  opts = {
    backend = 'kitty', -- Ghostty implements Kitty's graphics protocol
    processor = 'magick_cli', -- shells out to ImageMagick (already installed)
    integrations = {
      markdown = {
        enabled = true,
        clear_in_insert_mode = true,
        only_render_image_at_cursor = false,
      },
    },
    max_width_window_percentage = 80,
    max_height_window_percentage = 60,
    -- tmux/ghostty friendliness: only draw in the focused window/pane
    editor_only_render_when_focused = true,
    tmux_show_only_in_active_window = true, -- requires `set -g visual-activity off` (you have it)
    -- open an image file directly and render it
    hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
  },
}
