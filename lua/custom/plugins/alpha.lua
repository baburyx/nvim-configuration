return {
  'goolord/alpha-nvim',
  -- dependencies = {
  --   'nvim-mini/mini.icons',
  --   'nvim-lua/plenary.nvim',
  -- },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- require('alpha').setup(require('alpha.themes.theta').config)
    local theta = require 'alpha.themes.theta'
    theta.header.val = vim.fn.readfile(vim.fn.stdpath 'config' .. '/assets/aphex-twin.txt')
    theta.file_icons.provider = 'devicons'
    require('alpha').setup(theta.config)
  end,
}
