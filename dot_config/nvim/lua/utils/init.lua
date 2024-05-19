local M = {}

---@param flat_table table<string, unknown>
---@return table<string, unknown>
function M.tbl_nest(flat_table)
  local new_table = {}
  for key in pairs(flat_table) do
    local path = vim.split(key, '.', { plain = true, trimempty = true })
    local current = new_table
    for idx = 1, #path - 1 do
      local segment = path[idx]
      current[segment] = current[segment] or {}
      current = current[segment]
    end
    current[path[#path]] = flat_table[key]
  end
  return new_table
end

---@param entry cmp.Entry
---@param vim_item vim.CompletedItem
---@return vim.CompletedItem
function M.show_lsp_server_name(entry, vim_item)
  if entry.source.name ~= 'nvim_lsp' then
    return vim_item
  end
  local success, name = pcall(function()
    ---@type vim.lsp.Client
    local client = entry.source.source.client
    return client.name
  end)
  if not success or type(name) ~= 'string' then
    return vim_item
  end
  vim_item.menu = string.format(' (%s)', name)
  return vim_item
end

return M
