return {
  {
    'saghen/blink.cmp',
    opts = function(_, opts)
      opts = opts or {}
      opts.keymap = opts.keymap or {}

      -- Override specific mappings (no deep-extend)
      opts.keymap['<CR>'] = { 'accept', 'fallback' }
      opts.keymap['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' }
      opts.keymap['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' }
      opts.keymap['<C-y>'] = { 'accept', 'fallback' }

      return opts
    end,
  },
}
