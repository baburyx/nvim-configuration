return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    { '<leader>fy', '<cmd>Yazi<cr>', desc = 'Yazi: open at current file' },
    { '<leader>fY', '<cmd>Yazi cwd<cr>', desc = 'Yazi: open working directory' },
    { '<C-Up>', '<cmd>Yazi toggle<cr>', desc = 'Yazi: resume last session' },
  },
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
}
