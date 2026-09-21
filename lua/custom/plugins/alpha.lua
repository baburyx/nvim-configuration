return {
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.header.val = {
        '                                                     ',
        '  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ██╗ ',
        '  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗  ██║ ',
        '  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔██╗ ██║ ',
        '  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╗██║ ',
        '  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚████║ ',
        '  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝  ╚═══╝ ',
        '                                                     ',
      }

      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find file', ':lua require("telescope.builtin").find_files()<CR>'),
        dashboard.button('r', '  Recent files', ':lua require("telescope.builtin").oldfiles()<CR>'),
        dashboard.button('e', '  File explorer', ':lua require("neo-tree.command").execute({ toggle = true, reveal = true })<CR>'),
        dashboard.button('c', '  Edit config', ':lua require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })<CR>'),
        dashboard.button('q', '  Quit', ':qa<CR>'),
      }

      alpha.setup(dashboard.opts)
    end,
  },
}
