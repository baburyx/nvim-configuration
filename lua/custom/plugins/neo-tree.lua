return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '-', '<cmd>Neotree toggle reveal<cr>', desc = 'Neo-tree toggle' },
      { '<leader>fe', '<cmd>Neotree toggle reveal<cr>', desc = '[F]ile [E]xplorer' },
    },
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
        },
        window = {
          mappings = {
            ['-'] = 'close_window',
          },
        },
      },
    },
  },
}
