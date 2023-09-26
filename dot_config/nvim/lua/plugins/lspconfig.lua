-- vim: set sw=0 ts=2 et :

--- @return nil|string
local function getLicenceKey()
  local neoconf = require('neoconf')
  local defaults = { intelephense = { ['intelephense.licenceKey'] = nil } }
  local lspconfig = neoconf.get('lspconfig', defaults)
  return lspconfig.intelephense['intelephense.licenceKey']
end

--- @return boolean
local function isTakeOverModeEnabled()
  local neoconf = require('neoconf')
  local defaults = { volar = { ['volar.takeOverMode.enabled'] = false } }
  local lspconfig = neoconf.get('lspconfig', defaults)
  return lspconfig.volar['volar.takeOverMode.enabled']
end

local function disallowFormat(servers)
  --- @param client lsp.Client
  return function(client)
    return not vim.tbl_contains(servers, client.name)
  end
end

return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'b0o/schemastore.nvim',
  },
  branch = 'v3.x',
  config = function()
    local lsp_zero = require('lsp-zero')
    local lspconfig = require('lspconfig')
    local telescope_builtin = require('telescope.builtin')

    local augroup = vim.api.nvim_create_augroup('LspZeroSetup', { clear = true })

    lsp_zero.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      local capabilities = client.server_capabilities

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
      map('n', '<Leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      map('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      map('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')

      map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
      map('n', '<Leader>k', vim.lsp.buf.signature_help, 'Signature Documentation')

      map('n', '<Leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      map('n', '<F2>', vim.lsp.buf.rename, 'Rename')
      map('n', '<Leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
      map('n', '<F4>', vim.lsp.buf.code_action, 'Code Action')

      if vim.lsp.buf.range_code_action then
        map('x', '<F4>', vim.lsp.buf.range_code_action, 'Code Action')
      else
        map('x', '<F4>', vim.lsp.buf.code_action, 'Code Action')
      end

      map('n', '[d', vim.diagnostic.goto_prev, 'Next [D]iagnostic')
      map('n', ']d', vim.diagnostic.goto_next, 'Previous [D]iagnostic')

      local function documentDiagnostics()
        telescope_builtin.diagnostics({ bufnr = 0 })
      end

      map('n', '<Leader>dd', documentDiagnostics, '[D]ocument [D]iagnostics')
      map('n', '<Leader>wd', telescope_builtin.diagnostics, '[W]orkspace [D]iagnostics')

      if capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          group = augroup,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd('CursorMoved', {
          group = augroup,
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        group = augroup,
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

      local function format()
        vim.lsp.buf.format({
          async = false,
          bufnr = bufnr,
          timeout_ms = 10000,
          filter = disallowFormat({ 'jsonls', 'lua_ls', 'tsserver', 'yamlls', 'volar' }),
        })
      end

      map('n', '<Leader>df', format, '[D]ocument [F]ormat')
      map('x', '<Leader>df', format, '[D]ocument [F]ormat')
      map('n', '<F3>', format, 'Document Format')
      map('x', '<F3>', format, 'Document Format')
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', format, { desc = 'Format current buffer with LSP' })

      if capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = augroup,
          buffer = bufnr,
          callback = format,
        })
      end

      local opts_ = { border = 'single', focusable = false }

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, opts_)
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, opts_)
    end)

    lsp_zero.set_sign_icons({
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = '»',
    })

    lsp_zero.setup_servers({
      'denols',
      'erlangls',
      'gleam',
      'millet',
      'ocamllsp',
      'racket_langserver',
      'vala_ls',
      'zls',
    })
    lspconfig.elixirls.setup({ cmd = { 'elixir-ls' } })
    lspconfig.hls.setup({ filetypes = { 'haskell', 'lhaskell', 'cabal' } })

    local schemastore = require('schemastore')
    lspconfig.jsonls.setup({
      settings = {
        json = {
          schemas = schemastore.json.schemas(),
        },
      },
    })
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          schemaStore = { enable = false, url = '' },
          schemas = schemastore.yaml.schemas(),
        },
      },
    })

    local licenceKey = getLicenceKey()
    if licenceKey then
      lspconfig.intelephense.setup({ init_options = { licenceKey = licenceKey } })
    end

    local volarTakeOverMode = isTakeOverModeEnabled()
    if volarTakeOverMode then
      lspconfig.volar.setup({ filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' } })
    end
  end,
}
