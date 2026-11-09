return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat(vim.fn.readfile(vim.fn.stdpath 'config' .. '/assets/aphex-twin.txt'), '\n'),
        },
        sections = {
          { section = 'header' },
          {
            pane = 2,
            section = 'terminal',
            cmd = 'colorscript -e square',
            enabled = function()
              return vim.fn.executable 'colorscript' == 1
            end,
            height = 5,
            padding = 1,
          },
          { section = 'keys', gap = 1, padding = 1 },
          { pane = 2, icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
          { pane = 2, icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
          {
            pane = 2,
            icon = ' ',
            title = 'Git Status',
            section = 'terminal',
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = 'git status --short --branch --renames',
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = 'startup' },
        },
      },
      notifier = { enabled = true },
      picker = {
        enabled = true,
        ui_select = true,
        sources = {
          files = { hidden = true },
          smart = { hidden = true },
          explorer = {
            follow_file = true,
            win = { list = { keys = { ['-'] = 'close' } } },
          },
        },
      },
      explorer = { enabled = true },
      indent = { enabled = true },
      image = { enabled = true },
      lazygit = { enabled = true },
      terminal = { enabled = true },
      input = { enabled = true },
    },
    keys = {
      -- Preserve the existing search, explorer and undo shortcuts.
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = '[S]earch [K]eymaps',
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.files()
        end,
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker()
        end,
        desc = '[S]earch [S]elect picker',
      },
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = '[S]earch current [W]ord',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = '[S]earch by [G]rep',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = '[S]earch [D]iagnostics',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.resume()
        end,
        desc = '[S]earch [R]esume',
      },
      {
        '<leader>s.',
        function()
          Snacks.picker.recent()
        end,
        desc = '[S]earch Recent Files ("." for repeat)',
      },
      {
        '<leader><leader>',
        function()
          Snacks.picker.buffers()
        end,
        desc = '[ ] Find existing buffers',
      },
      {
        '<leader>/',
        function()
          Snacks.picker.lines { layout = 'select', preview = false }
        end,
        desc = '[/] Fuzzily search in current buffer',
      },
      {
        '<leader>s/',
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = '[S]earch [/] in Open Files',
      },
      {
        '<leader>sn',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[S]earch [N]eovim files',
      },
      {
        '-',
        function()
          Snacks.explorer()
        end,
        desc = 'Toggle file explorer',
      },
      {
        '<leader>fe',
        function()
          Snacks.explorer()
        end,
        desc = '[F]ile [E]xplorer',
      },
      {
        '<leader>u',
        function()
          Snacks.picker.undo()
        end,
        desc = '[U]ndo history',
      },
      {
        '<leader>ps',
        function()
          Snacks.picker.smart()
        end,
        desc = '[P]icker [S]mart',
      },
      {
        '<leader>pf',
        function()
          Snacks.picker.files()
        end,
        desc = '[P]icker [F]iles',
      },
      {
        '<leader>pg',
        function()
          Snacks.picker.grep()
        end,
        desc = '[P]icker [G]rep',
      },
      {
        '<leader>pb',
        function()
          Snacks.picker.buffers()
        end,
        desc = '[P]icker [B]uffers',
      },
      {
        '<leader>gg',
        function()
          Snacks.lazygit()
        end,
        desc = '[G]it [L]azygit',
      },
      {
        '<leader>gl',
        function()
          Snacks.picker.git_log()
        end,
        desc = '[G]it [L]og',
      },
      {
        '<leader>tt',
        function()
          Snacks.terminal()
        end,
        desc = '[T]oggle [T]erminal',
      },
    },
  },
}
