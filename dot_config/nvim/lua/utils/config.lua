local M = {}

function M.disallow_format(servers)
  ---@param client vim.lsp.Client
  return function(client)
    return not vim.tbl_contains(servers, client.name)
  end
end

function M.get_editor_config()
  local defaults = {
    documentHighlight = { true, {} },
    formatOnSave = false,
    semanticHighlighting = false,
    showCompletionSource = false,
  }
  local neoconf = require('neoconf')
  local editor = neoconf.get('editor', defaults)
  return editor
end

---@param editor_config { documentHighlight: [boolean, table<string, boolean>]}
---@param filetype string
---@return boolean
function M.document_highlight_enabled(editor_config, filetype)
  local enabled = editor_config.documentHighlight[1]
  local ft_table = editor_config.documentHighlight[2]
  local ft_enabled = ft_table[filetype]
  if ft_enabled ~= nil then
    return ft_enabled
  else
    return enabled
  end
end

function M.get_lsp_config()
  local defaults = {
    denols = {
      ['deno.enable'] = false,
    },
    rescriptls = {},
    volar = {
      ['vue.hybridMode'] = false,
    },
  }
  local neoconf = require('neoconf')
  local lspconfig = neoconf.get('lspconfig', defaults)
  return lspconfig
end

---@return nil|string, string
function M.get_intelephense_config()
  local storage_path = vim.fs.normalize('$XDG_DATA_HOME/intelephense')
  local fd = vim.uv.fs_open(vim.fs.joinpath(storage_path, 'licence.txt'), 'r', 438)
  if fd == nil then
    return nil, storage_path
  end
  local stat = assert(vim.uv.fs_fstat(fd))
  local data = vim.uv.fs_read(fd, stat.size, 0)
  assert(vim.uv.fs_close(fd))
  if data == nil then
    return data, storage_path
  else
    return vim.trim(data), storage_path
  end
end

---@return boolean
function M.is_deno_enabled()
  local lspconfig = M.get_lsp_config()
  return lspconfig.denols['deno.enable']
end

---@return boolean
function M.is_vue_hybrid_mode()
  local lspconfig = M.get_lsp_config()
  return lspconfig.volar['vue.hybridMode']
end

function M.get_rescriptls_config()
  local utils = require('utils')
  local lspconfig = M.get_lsp_config()
  -- return lspconfig.rescriptls['rescript.settings']
  local nested_rescriptls = utils.tbl_nest(lspconfig.rescriptls)
  return vim.tbl_get(nested_rescriptls, 'rescript', 'settings') or {}
end

return M
