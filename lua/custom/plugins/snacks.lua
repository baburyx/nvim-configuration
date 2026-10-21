return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      dashboard = { enabled = false },
      notifier = { enabled = false },
      picker = { enabled = true },
      lazygit = { enabled = true },
      terminal = { enabled = true },
    },
    keys = {
      { '<leader>ps', function() Snacks.picker.smart() end, desc = '[P]icker [S]mart' },
      { '<leader>pf', function() Snacks.picker.files() end, desc = '[P]icker [F]iles' },
      { '<leader>pg', function() Snacks.picker.grep() end, desc = '[P]icker [G]rep' },
      { '<leader>pb', function() Snacks.picker.buffers() end, desc = '[P]icker [B]uffers' },
      { '<leader>gg', function() Snacks.lazygit() end, desc = '[G]it [L]azygit' },
      { '<leader>tt', function() Snacks.terminal() end, desc = '[T]oggle [T]erminal' },
    },
  },
}
