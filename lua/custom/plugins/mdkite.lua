return {
  'selimacerbas/mdkite.nvim',
  dependencies = { 'selimacerbas/kitehost.nvim' },
  cmd = 'MdKite',
  keys = {
    { '<leader>mp', '<cmd>MdKite toggle<cr>', desc = '[M]arkdown [P]review toggle' },
  },
  config = function()
    require('mdkite').setup({
      instance_mode = 'takeover',
      host = '127.0.0.1',
      open_browser = true,
      browser = 'Zen',
    })
  end,
}
