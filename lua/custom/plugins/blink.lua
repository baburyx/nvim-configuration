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

      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { 'lsp', 'path', 'snippets', 'buffer' }
      if not vim.tbl_contains(opts.sources.default, 'note_links') then
        table.insert(opts.sources.default, 'note_links')
      end
      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.note_links = {
        name = 'Notes',
        module = 'custom.note_completion',
        score_offset = 100,
        min_keyword_length = 0,
      }

      return opts
    end,
  },
}
