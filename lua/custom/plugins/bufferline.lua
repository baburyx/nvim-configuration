return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = function()
      return {
        options = {
          style_preset = require('bufferline').style_preset.minimal,
          indicator = { style = 'underline' },
          show_buffer_close_icons = false,
          show_close_icon = false,
          color_icons = false,
          offsets = {
            {
              filetype = 'neo-tree',
              text = '',
              separator = true,
            },
          },
        },
      }
    end,
    keys = {
      { '<leader>bn', '<cmd>BufferLineCycleNext<cr>', desc = '[B]uffer [N]ext' },
      { '<leader>bp', '<cmd>BufferLineCyclePrev<cr>', desc = '[B]uffer [P]rev' },
      { '<leader>bd', '<cmd>bd<cr>', desc = '[B]uffer [D]elete' },
    },
  },
}
