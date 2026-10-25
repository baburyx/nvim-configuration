return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  init = function()
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    local directions = { h = 'Left', j = 'Down', k = 'Up', l = 'Right' }
    for key, direction in pairs(directions) do
      local lhs = '<C-' .. key .. '>'
      local command = '<cmd>TmuxNavigate' .. direction .. '<CR>'
      local opts = { silent = true, desc = 'Navigate ' .. direction:lower() .. ' through Neovim and tmux' }
      vim.keymap.set('n', lhs, command, opts)
      vim.keymap.set('t', lhs, function()
        return vim.bo.filetype == 'fzf' and lhs or '<C-\\><C-n>' .. command
      end, vim.tbl_extend('force', opts, { expr = true }))
    end
    vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<CR>', { silent = true, desc = 'Navigate to previous split or pane' })
  end,
}
