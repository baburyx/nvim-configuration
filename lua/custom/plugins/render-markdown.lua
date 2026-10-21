return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    opts = {
      -- Only render in normal & command mode; raw markdown while editing
      render_modes = { 'n', 'c' },
      heading = {
        sign = false,
        icons = { '◉ ', '○ ', '✸ ', '✿ ' },
        backgrounds = {},
      },
      code = {
        style = 'normal',
        border = 'thin',
      },
      checkbox = { enabled = false },
      bullet = {
        icons = { '•', '◦', '▪', '▫' },
      },
      win_options = {
        concealcursor = { rendered = '' },
      },
      -- Disable LSP-driven overlays that can throw "missing request context"
      overrides = {
        buftype = {
          nofile = { enabled = false },
        },
      },
      on = {
        attach = function() end,
      },
    },
    keys = {
      { '<leader>mr', '<cmd>RenderMarkdown toggle<cr>', desc = '[M]arkdown [R]ender toggle' },
    },
  },
}
