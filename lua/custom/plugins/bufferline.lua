return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      options = {
        offsets = {
          {
            filetype = 'neo-tree',
            test = 'File Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
      },
    },
    keys = {
      { '<leader>bn', '<cmd>BufferLineCycleNext<cr>', desc = '[B]uffer [N]ext' },
      { '<leader>bp', '<cmd>BufferLineCyclePrev<cr>', desc = '[B]uffer [P]rev' },
      { '<leader>bd', '<cmd>bd<cr>', desc = '[B]uffer [D]elete' },
    },
  },
}
