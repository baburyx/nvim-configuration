local M = {}

local notebooks = { work = true, knowledge = true, personal = true }

local function quoted_yaml(value)
  return '"' .. value:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', ' ') .. '"'
end

local function notebook_from_path(path)
  local vault = vim.fn.fnamemodify(vim.fn.expand('~/bs-notes'), ':p'):gsub('/+$', '')
  local prefix = vault .. '/'
  if path:sub(1, #prefix) ~= prefix then
    return nil
  end
  local folder = path:sub(#prefix + 1):match('^([^/]+)/')
  return notebooks[folder] and folder or nil
end

local function add_header(args)
  local buffer = vim.api.nvim_get_current_buf()
  if vim.bo[buffer].filetype ~= 'markdown' then
    vim.notify('NoteHeader works in Markdown buffers', vim.log.levels.WARN)
    return
  end

  local first_line = vim.api.nvim_buf_get_lines(buffer, 0, 1, false)[1] or ''
  if first_line:match('^%-%-%-%s*$') then
    vim.notify('This note already has frontmatter', vim.log.levels.INFO)
    return
  end

  local path = vim.api.nvim_buf_get_name(buffer)
  local notebook = args.args ~= '' and args.args or notebook_from_path(path)
  if not notebooks[notebook] then
    vim.notify('Choose a notebook: :NoteHeader work|knowledge|personal', vim.log.levels.WARN)
    return
  end

  local title = path ~= '' and vim.fn.fnamemodify(path, ':t:r') or 'Untitled'
  local header = {
    '---',
    'title: ' .. quoted_yaml(title),
    'date: ' .. os.date('%Y-%m-%d'),
    'tags: []',
    'notebook: ' .. notebook,
    'links: []',
    'template: default',
    '---',
    '',
  }
  vim.api.nvim_buf_set_lines(buffer, 0, 0, false, header)
  vim.notify('Added ' .. notebook .. ' note frontmatter', vim.log.levels.INFO)
end

function M.setup()
  vim.api.nvim_create_user_command('NoteHeader', add_header, {
    nargs = '?',
    complete = function()
      return { 'work', 'knowledge', 'personal' }
    end,
    desc = 'Add Shiki-style frontmatter to the current Markdown note',
  })
  vim.keymap.set('n', '<leader>mh', '<cmd>NoteHeader<cr>', { desc = '[M]arkdown note [H]eader' })
end

return M
