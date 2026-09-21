return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {},
    keys = {
      { '<leader>bn', '<cmd>BufferLineCycleNext<cr>', desc = '[B]uffer [N]ext' },
      { '<leader>bp', '<cmd>BufferLineCyclePrev<cr>', desc = '[B]uffer [P]rev' },
      { '<leader>bd', '<cmd>bd<cr>', desc = '[B]uffer [D]elete' },
    },
  },
}
