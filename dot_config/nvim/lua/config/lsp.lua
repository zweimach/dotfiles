-- vim: set sw=0 ts=2 et :

local M = {}

local setup_augroup = vim.api.nvim_create_augroup('LspSetup', { clear = true })

local float_opts = { border = 'rounded', focusable = true }

M.setup_augroup = setup_augroup

---@param client vim.lsp.Client
---@param bufnr integer
M.lsp_setup = function(client, bufnr)
  local lsp_format = require('lsp-format')
  local telescope_builtin = require('telescope.builtin')
  local utils_config = require('utils.config')

  local opts = { buffer = bufnr, noremap = true, silent = true }
  local editor_config = utils_config.get_editor_config()

  if not editor_config.semanticHighlighting then
    client.server_capabilities.semanticTokensProvider = nil
  end

  local completion_disabled = {
    'psalm',
    'intelephense',
  }
  if vim.tbl_contains(completion_disabled, client.name) then
    client.server_capabilities.completionProvider = nil
  end

  local hover_disabled = {
    'psalm',
  }
  if vim.tbl_contains(hover_disabled, client.name) then
    client.server_capabilities.hoverProvider = nil
  end

  ---@param mode string|string[]
  ---@param keys string
  ---@param func string|function
  ---@param desc string
  local function map(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    local opts_ = vim.tbl_deep_extend('force', opts, { desc = desc })
    vim.keymap.set(mode, keys, func, opts_)
  end

  map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', 'gd', telescope_builtin.lsp_definitions, '[G]oto [D]efinition')
  map('n', 'gy', telescope_builtin.lsp_type_definitions, '[G]oto T[y]pe Definition')
  map('n', 'gi', telescope_builtin.lsp_implementations, '[G]oto [I]mplementation')
  map('n', 'gr', telescope_builtin.lsp_references, '[G]oto [R]eferences')

  map('n', '<Leader>ds', telescope_builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  map('n', '<Leader>ws', telescope_builtin.lsp_workspace_symbols, '[W]orkspace [S]ymbols')

  map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  map('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')

  local function hover()
    vim.lsp.buf.hover(float_opts)
  end

  map('n', 'K', hover, 'Hover Documentation')

  local function signature_help()
    vim.lsp.buf.signature_help(float_opts)
  end

  map('n', '<Leader>k', signature_help, 'Signature Documentation')
  map('i', '<C-s>', signature_help, 'Signature Documentation')

  map('n', '<Leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('n', '<F2>', vim.lsp.buf.rename, 'Rename')
  map('n', '<Leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  map('n', '<F4>', vim.lsp.buf.code_action, 'Code Action')

  if vim.lsp.buf.range_code_action then
    map('x', '<F4>', vim.lsp.buf.range_code_action, 'Code Action')
  else
    map('x', '<F4>', vim.lsp.buf.code_action, 'Code Action')
  end

  vim.diagnostic.config({
    float = float_opts,
    virtual_text = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = '✘',
        [vim.diagnostic.severity.WARN] = '▲',
        [vim.diagnostic.severity.HINT] = '⚑',
        [vim.diagnostic.severity.INFO] = '»',
      },
    },
  })

  local function diagnostic_jump(count)
    return function()
      vim.diagnostic.jump({ count = count, float = true })
    end
  end

  map('n', '[d', diagnostic_jump(-1), 'Next [D]iagnostic')
  map('n', ']d', diagnostic_jump(1), 'Previous [D]iagnostic')

  local function document_diagnostics()
    telescope_builtin.diagnostics({ bufnr = 0 })
  end

  map('n', '<Leader>dd', document_diagnostics, '[D]ocument [D]iagnostics')
  map('n', '<Leader>wd', telescope_builtin.diagnostics, '[W]orkspace [D]iagnostics')

  local document_highlight_enabled = utils_config.document_highlight_enabled(editor_config, vim.bo[bufnr].filetype)
  if document_highlight_enabled and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
    local highlight_augroup = vim.api.nvim_create_augroup('LspSetupHighlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = highlight_augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      group = highlight_augroup,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    group = setup_augroup,
    buffer = bufnr,
    callback = function()
      for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
          return
        end
      end
      vim.diagnostic.open_float({
        focusable = false,
        close_events = {
          'CursorMoved',
          'CursorMovedI',
          'BufHidden',
          'InsertCharPre',
          'WinLeave',
        },
      })
    end,
  })

  local formatting_enabled = utils_config.disallow_format({
    'bashls',
    'cssls',
    'html',
    'intelephense',
    'jsonls',
    'lemminx',
    'lua_ls',
    'tsgo',
    'vtsls',
    'vue_ls',
    'yamlls',
  })
  local function format()
    vim.lsp.buf.format({
      async = true,
      bufnr = bufnr,
      timeout_ms = 10000,
      filter = formatting_enabled,
    })
  end

  map('n', '<Leader>df', format, '[D]ocument [F]ormat')
  map('x', '<Leader>df', format, '[D]ocument [F]ormat')
  map('n', '<F3>', format, 'Document Format')
  map('x', '<F3>', format, 'Document Format')
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', format, { desc = 'Format current buffer with LSP' })

  if editor_config.formatOnSave and client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) and formatting_enabled(client) then
    lsp_format.on_attach(client)
  end

  if editor_config.codeLens and client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
    map('n', '<Leader>cl', vim.lsp.codelens.run, '[C]ode [L]ens')

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'CursorHold', 'InsertLeave' }, {
      group = setup_augroup,
      buffer = bufnr,
      callback = vim.lsp.codelens.refresh,
    })
  end

  if editor_config.inlayHints and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
    map('n', '<Leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
    end, '[T]oggle Inlay [H]ints')
  end
end

---@param event vim.api.keyset.create_autocmd.callback_args
---@return boolean?
M.on_attach = function(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if not client then
    return
  end
  M.lsp_setup(client, event.buf)
end

return M
