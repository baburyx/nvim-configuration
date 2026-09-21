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
      {
        '<leader>mt',
        function()
          local line = vim.api.nvim_get_current_line()
          if line:find('%- %[ %]') then
            line = line:gsub('%- %[ %]', '- [x]', 1)
          elseif line:find('%- %[x%]') then
            line = line:gsub('%- %[x%]', '- [ ]', 1)
          elseif line:find('%- %[X%]') then
            line = line:gsub('%- %[X%]', '- [ ]', 1)
          end
          vim.api.nvim_set_current_line(line)
        end,
        desc = '[M]arkdown [T]ask toggle',
      },
      {
        '<leader>mu',
        function()
          vim.cmd 'write'
          local script = vim.fn.stdpath 'config' .. '/scripts/md_note_rollup.py'
          local file = vim.fn.expand '%:p'
          local result = vim.system({ 'python3', script, file }, { text = true }):wait()
          if result.code == 0 then
            vim.cmd 'edit!'
            vim.notify(vim.trim(result.stdout), vim.log.levels.INFO)
          else
            vim.notify(vim.trim(result.stderr ~= '' and result.stderr or result.stdout), vim.log.levels.ERROR)
          end
        end,
        desc = '[M]arkdown [U]pdate task/decision rollup',
      },
      {
        '<leader>mU',
        function()
          vim.cmd 'write'
          local script = vim.fn.stdpath 'config' .. '/scripts/md_note_rollup.py'
          local file = vim.fn.expand '%:p'
          local result = vim.system({ 'python3', script, '--clear', file }, { text = true }):wait()
          if result.code == 0 then
            vim.cmd 'edit!'
            vim.notify(vim.trim(result.stdout), vim.log.levels.INFO)
          else
            vim.notify(vim.trim(result.stderr ~= '' and result.stderr or result.stdout), vim.log.levels.ERROR)
          end
        end,
        desc = '[M]arkdown clear roll[U]p',
      },
    },
  },
}
