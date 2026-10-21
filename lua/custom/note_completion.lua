local source = {}

local notebooks = { 'work', 'knowledge', 'personal' }

local function vault_root()
  return vim.fn.fnamemodify(vim.fn.expand('~/bs-notes'), ':p'):gsub('/+$', '')
end

function source.new()
  return setmetatable({}, { __index = source })
end

function source:enabled()
  if vim.bo.filetype ~= 'markdown' then
    return false
  end
  local prefix = vault_root() .. '/'
  return vim.api.nvim_buf_get_name(0):sub(1, #prefix) == prefix
end

function source:get_trigger_characters()
  return { '[' }
end

function source:get_completions(ctx, callback)
  local before = ctx.line:sub(1, ctx.cursor[2])
  local opening = before:match('.*()%[%[')
  if not opening or before:find(']]', opening + 2, true) then
    callback({ items = {} })
    return
  end

  local root = vault_root()
  local line_number = ctx.cursor[1] - 1
  local start_character = opening + 1 -- zero-based column immediately after [[
  local has_closing = ctx.line:sub(ctx.cursor[2] + 1, ctx.cursor[2] + 2) == ']]'
  local items = {}

  for _, notebook in ipairs(notebooks) do
    for _, path in ipairs(vim.fn.globpath(root .. '/' .. notebook, '**/*.md', false, true)) do
      local relative = path:sub(#root + 2):gsub('%.md$', '')
      local stem = vim.fn.fnamemodify(path, ':t:r')
      table.insert(items, {
        label = relative,
        labelDetails = { description = stem },
        kind = vim.lsp.protocol.CompletionItemKind.File,
        filterText = relative .. ' ' .. stem,
        textEdit = {
          newText = relative .. (has_closing and '' or ']]'),
          range = {
            start = { line = line_number, character = start_character },
            ['end'] = { line = line_number, character = ctx.cursor[2] },
          },
        },
      })
    end
  end

  callback({ items = items, is_incomplete_forward = true })
end

return source
