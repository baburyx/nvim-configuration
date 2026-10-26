return {
  'bngarren/checkmate.nvim',
  ft = 'markdown', -- Lazy loads for Markdown files matching patterns in 'files'
  opts = {
    files = { '*.md' }, -- any .md file (instead of defaults)
    ui = { picker = 'snacks' },

    todo_states = {
      unchecked = { marker = '□', order = 1 },
      in_progress = { marker = '◐', markdown = '.', type = 'incomplete', order = 2 },
      checked = { marker = '✔', order = 3 },
    },

    style = {
      CheckmateUncheckedMarker = { fg = '#f7768e', bold = true },
      CheckmateUncheckedMainContent = { fg = '#f7768e' },

      CheckmateInProgressMarker = { fg = '#e0af68', bold = true },
      CheckmateInProgressMainContent = { fg = '#e0af68' },

      CheckmateCheckedMarker = { fg = '#9ece6a', bold = true },
      CheckmateCheckedMainContent = { fg = '#9ece6a' },
    },

    smart_toggle = { enabled = true },

    metadata = {
      created = {
        style = { fg = '#7f849c' },
        get_value = function()
          return os.date '%Y-%m-%d %H:%M'
        end,
      },
      status = {
        sort_order = 10,
        get_value = function()
          return 'not started'
        end,
        choices = { 'not started', 'started', 'done' },
        style = function(context)
          local colors = {
            ['not started'] = '#f7768e',
            started = '#e0af68',
            done = '#9ece6a',
          }
          return { fg = colors[context.value:lower()] or '#c0caf5', bold = true }
        end,
        on_add = function(todo)
          local _, value = todo.get_metadata 'status'
          local states = { ['not started'] = 'unchecked', started = 'in_progress', done = 'checked' }
          if states[value] then
            require('checkmate').set_todo_state(todo, states[value])
          end
        end,
        on_change = function(todo, _, value)
          local states = { ['not started'] = 'unchecked', started = 'in_progress', done = 'checked' }
          if states[value] then
            require('checkmate').set_todo_state(todo, states[value])
          end
        end,
      },
      done = {
        style = { fg = '#96de7a' },
        get_value = function()
          return os.date '%Y-%m-%d %H:%M'
        end,
        on_add = function(todo)
          require('checkmate').set_todo_state(todo, 'checked')
        end,
      },
    },
  },

  config = function(_, opts)
    local function create_task()
      local checkmate = require 'checkmate'
      -- Keep Checkmate's bulk conversion for visual selections.
      if vim.fn.mode():match '[vV\22]' then
        checkmate.create()
        return
      end

      local bufnr = vim.api.nvim_get_current_buf()
      if not require('checkmate.buffer').is_valid(bufnr) then
        return
      end

      local row = vim.api.nvim_win_get_cursor(0)[1] - 1
      local line = vim.api.nvim_get_current_line()
      local item = require('checkmate.parser').get_todo_item_at_position(bufnr, row, 0, { root_only = true })
      local create_opts = {}
      local title = ''

      if item then
        -- Insert after the whole task, including its detail bullets.
        vim.api.nvim_win_set_cursor(0, { item.range['end'].row + 1, 0 })
        create_opts.position = 'below'
        create_opts.indent = item.range.start.col
        create_opts.list_marker = item.list_marker.text
      else
        local list_item = require('checkmate.parser.helpers').match_list_item(line)
        local text = vim.trim(list_item and list_item.content or line)
        if text ~= '' then
          title = text:match '^%*%*(.-)%*%*$' or text
        end
      end

      create_opts.content = ('**%s** @status(not started) @created(%s)'):format(title, os.date '%Y-%m-%d %H:%M')
      if not checkmate.create(create_opts) then
        return
      end

      row = vim.api.nvim_win_get_cursor(0)[1] - 1
      local header = vim.api.nvim_get_current_line()
      local prefix = require('checkmate.parser.helpers').match_todo(header)
      local indent = header:match '^%s*' .. string.rep(' ', #prefix.list_marker + 1)
      local details = {
        '- **Ref:** File path / issue / PRD',
        '- **Goal:** Expected outcome',
        '- **Progress:** Current state',
        '- **Next:** Immediate action',
        '- **Blocked:** External dependencies, if any',
        '- **Decisions:** Unresolved questions',
        '- **Session:** Resume command, if applicable',
      }
      for i, detail in ipairs(details) do
        details[i] = indent .. detail
      end
      vim.cmd 'undojoin'
      vim.api.nvim_buf_set_lines(bufnr, row + 1, row + 1, false, details)
      -- Leave the cursor inside the bold title for editing.
      vim.api.nvim_win_set_cursor(0, { row + 1, prefix.length + 3 })
      vim.cmd 'startinsert'
    end

    opts.keys = vim.deepcopy(require('checkmate.config.defaults').keys)
    opts.keys['<leader>Tn'] = { rhs = create_task, desc = 'Create task from template', modes = { 'n', 'v' } }
    require('checkmate').setup(opts)

    -- Checkmate's metadata callbacks don't run when Tt changes a checkbox.
    -- Sync timestamps and status after task creation and state changes.
    local group = vim.api.nvim_create_augroup('CheckmateTaskMetadataSync', { clear = true })
    local syncing = {}

    vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
      group = group,
      pattern = '*',
      callback = function(event)
        local bufnr = event.buf
        if syncing[bufnr] or vim.bo[bufnr].filetype ~= 'markdown' then
          return
        end

        vim.schedule(function()
          if syncing[bufnr] or not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end

          local buffer = require 'checkmate.buffer'
          if not buffer.is_valid(bufnr) then
            return
          end

          local parser = require 'checkmate.parser'
          local transaction = require 'checkmate.transaction'
          local api = require 'checkmate.api'
          local todo_map = parser.get_todo_map(bufnr)
          local add, remove = {}, {}

          for id, item in pairs(todo_map) do
            local has_done = item.metadata.by_tag.done ~= nil
            local status_entry = item.metadata.by_tag.status
            local status = status_entry and status_entry.value or nil
            local next_status = status

            if not item.metadata.by_tag.created then
              add[#add + 1] = { id = id, meta_name = 'created' }
            end

            if item.state == 'checked' then
              next_status = 'done'
              if not has_done then
                add[#add + 1] = { id = id, meta_name = 'done' }
              end
            else
              if has_done then
                remove[#remove + 1] = { id = id, meta_names = { 'done' } }
              end
              if item.state == 'in_progress' or status == 'done' then
                next_status = 'started'
              elseif not status then
                next_status = 'not started'
              end
            end

            if next_status and next_status ~= status then
              add[#add + 1] = { id = id, meta_name = 'status', meta_value = next_status }
            end
          end

          if #add == 0 and #remove == 0 then
            return
          end

          syncing[bufnr] = true
          transaction.run(bufnr, function(ctx)
            if #add > 0 then
              ctx.add_op(api.add_metadata, add)
            end
            if #remove > 0 then
              ctx.add_op(api.remove_metadata, remove)
            end
          end)
          syncing[bufnr] = nil
        end)
      end,
    })

    local function open_status_picker(bufnr)
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end
      local row = vim.api.nvim_win_get_cursor(0)[1] - 1
      local parser = require 'checkmate.parser'
      local item = parser.get_todo_item_at_position(bufnr, row, 0)
      if not item then
        return
      end

      local function select_status()
        local refreshed = parser.get_todo_map(bufnr)[item.id]
        local entry = refreshed and refreshed.metadata.by_tag.status
        if entry then
          require('checkmate').select_metadata_value {
            position = { row = entry.range.start.row, col = entry.range.start.col },
          }
        end
      end

      if item.metadata.by_tag.status then
        select_status()
      else
        require('checkmate').add_metadata('status', 'not started')
        vim.schedule(select_status)
      end
    end

    local status_group = vim.api.nvim_create_augroup('CheckmateStatusPickerKey', { clear = true })
    local function map_status_picker(bufnr)
      vim.keymap.set('n', '<leader>Ts', function()
        open_status_picker(bufnr)
      end, { buffer = bufnr, silent = true, desc = 'Choose task status' })
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = status_group,
      pattern = 'markdown',
      callback = function(event)
        map_status_picker(event.buf)
      end,
    })
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].filetype == 'markdown' then
        map_status_picker(bufnr)
      end
    end
  end,
}
