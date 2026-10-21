local M = {}

local notebooks = { 'work', 'knowledge', 'personal' }

local function trim(value)
  return value:match('^%s*(.-)%s*$')
end

local function normalize(value)
  return trim(value):lower():gsub('%.md$', '')
end

local function link_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local column = vim.api.nvim_win_get_cursor(0)[2] + 1
  local position = 1
  while true do
    local first, last, link = line:find('%[%[([^%]]+)%]%]', position)
    if not first then
      return nil
    end
    if column >= first and column <= last then
      return trim(link:match('^[^|]+'))
    end
    position = last + 1
  end
end

local function note_title(path)
  local lines = vim.fn.readfile(path, '', 30)
  for _, line in ipairs(lines) do
    local title = line:match('^title:%s*(.-)%s*$')
    if title then
      return title:gsub('^"', ''):gsub('"$', ''):gsub("^'", ''):gsub("'$", '')
    end
  end
  for _, line in ipairs(lines) do
    local title = line:match('^#%s+(.+)$')
    if title then
      return trim(title)
    end
  end
  return nil
end

local function all_notes(vault)
  local notes = {}
  for _, notebook in ipairs(notebooks) do
    local files = vim.fn.globpath(vault .. '/' .. notebook, '**/*.md', false, true)
    vim.list_extend(notes, files)
  end
  return notes
end

local function open_note(path, heading)
  vim.cmd.edit(vim.fn.fnameescape(path))
  if not heading then
    return
  end
  for number, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local text = line:match('^#+%s+(.+)$')
    if text and normalize(text) == normalize(heading) then
      vim.api.nvim_win_set_cursor(0, { number, 0 })
      return
    end
  end
  vim.notify('Opened note, but heading not found: ' .. heading, vim.log.levels.WARN)
end

local function follow_note_link()
  local link = link_under_cursor()
  if not link then
    vim.notify('Place the cursor on a [[note link]]', vim.log.levels.WARN)
    return
  end

  local target, heading = link:match('^(.-)#(.+)$')
  if not target then
    target = link
  end
  target = normalize(target)
  local vault = vim.fn.fnamemodify(vim.fn.expand('~/bs-notes'), ':p'):gsub('/+$', '')
  local matches = {}
  for _, path in ipairs(all_notes(vault)) do
    local relative = path:sub(#vault + 2):gsub('%.md$', '')
    local stem = vim.fn.fnamemodify(path, ':t:r')
    local title = note_title(path)
    if normalize(relative) == target or normalize(stem) == target or (title and normalize(title) == target) then
      table.insert(matches, path)
    end
  end

  if #matches == 0 then
    vim.notify('Note not found: ' .. target, vim.log.levels.WARN)
  elseif #matches == 1 then
    open_note(matches[1], heading)
  else
    vim.ui.select(matches, {
      prompt = 'Open note:',
      format_item = function(path)
        return path:sub(#vault + 2)
      end,
    }, function(choice)
      if choice then
        open_note(choice, heading)
      end
    end)
  end
end

function M.setup()
  vim.api.nvim_create_user_command('NoteFollow', follow_note_link, {
    desc = 'Open the [[note link]] under the cursor',
  })
  vim.keymap.set('n', '<leader>ml', '<cmd>NoteFollow<cr>', { desc = '[M]arkdown [L]ink follow' })
end

return M
