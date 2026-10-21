return {
  'HakonHarnes/img-clip.nvim',
  event = 'VeryLazy',
  opts = {
    default = {
      dir_path = 'attachments',
      relative_to_current_file = false,
    },
  },
  keys = {
    {
      '<leader>mi',
      '<cmd>PasteImage<cr>',
      desc = 'Paste image from clipboard',
    },
  },
}
