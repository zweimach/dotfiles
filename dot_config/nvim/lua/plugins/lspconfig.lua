-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'VonHeikemen/lsp-zero.nvim',
  dependencies = {
    'neovim/nvim-lspconfig',
    'b0o/schemastore.nvim',
    'lukas-reineke/lsp-format.nvim',
  },
  branch = 'v4.x',
  config = function()
    local lsp_zero = require('lsp-zero')
    local lsp_format = require('lsp-format')
    local lspconfig = require('lspconfig')
    local telescope_builtin = require('telescope.builtin')
    local config = require('utils.config')

    local augroup = vim.api.nvim_create_augroup('LspZeroSetup', { clear = true })

    ---@param client vim.lsp.Client
    ---@param bufnr integer
    local function on_attach(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      local editor_config = config.get_editor_config()

      if not editor_config.semanticHighlighting then
        client.server_capabilities.semanticTokensProvider = nil
      end

      local completion_disabled = {
        'psalm',
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

      local function document_diagnostics()
        telescope_builtin.diagnostics({ bufnr = 0 })
      end

      map('n', '<Leader>dd', document_diagnostics, '[D]ocument [D]iagnostics')
      map('n', '<Leader>wd', telescope_builtin.diagnostics, '[W]orkspace [D]iagnostics')

      local document_highlight_enabled = config.document_highlight_enabled(editor_config, vim.bo[bufnr].filetype)
      if document_highlight_enabled and client.supports_method('textDocument/documentHighlight') then
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

      local formatting_enabled = config.disallow_format({
        'bashls',
        'cssls',
        'html',
        'intelephense',
        'jsonls',
        'lemminx',
        'lua_ls',
        'ts_ls',
        'volar',
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

      if editor_config.formatOnSave and client.supports_method('textDocument/formatting') and formatting_enabled(client) then
        lsp_format.on_attach(client)
      end

      map('n', '<Leader>cl', vim.lsp.codelens.run, '[C]ode [L]ens')

      if editor_config.codeLens and client.supports_method('textDocument/codeLens') then
        vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'CursorHold', 'InsertLeave' }, {
          group = augroup,
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })
      end

      local opts_ = { border = 'single', focusable = false }

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, opts_)
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, opts_)
    end

    vim.lsp.handlers['client/registerCapability'] = (function(overridden)
      return function(err, res, ctx)
        local result = overridden(err, res, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if not client then
          return
        end
        on_attach(client, vim.api.nvim_get_current_buf())
        return result
      end
    end)(vim.lsp.handlers['client/registerCapability'])

    lsp_zero.on_attach(on_attach)

    lsp_zero.set_sign_icons({
      error = '✘',
      warn = '▲',
      hint = '⚑',
      info = '»',
    })

    lsp_zero.setup_servers({
      'gleam',
      'metals',
      'nixd',
      'ocamllsp',
      'ruff',
      'zls',
    })
    ---@diagnostic disable: missing-fields
    lspconfig.flow.setup({ filetypes = { 'javascript', 'javascriptreact', 'javascriptflow' } })
    lspconfig.hls.setup({ filetypes = { 'haskell', 'lhaskell', 'cabal' } })
    lspconfig.racket_langserver.setup({ filetypes = { 'racket' } })

    local rescriptls_config = config.get_rescriptls_config()
    lspconfig.rescriptls.setup({
      init_options = { extensionConfiguration = rescriptls_config },
    })

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
    lspconfig.typos_lsp.setup({
      init_options = { diagnosticSeverity = 'Hint' },
    })

    local licence_key, global_storage_path = config.get_intelephense_config()
    lspconfig.intelephense.setup({
      init_options = {
        licenceKey = licence_key,
        globalStoragePath = global_storage_path,
      },
    })

    local eslint_lsp_config = config.get_eslint_lsp_config()
    if config.is_biome_enabled() then
      lspconfig.biome.setup({})
      lspconfig.eslint.setup({ autostart = false })
    else
      lspconfig.eslint.setup({ settings = eslint_lsp_config })
    end

    local vue_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
    if config.is_deno_enabled() then
      lspconfig.denols.setup({})
      lspconfig.ts_ls.setup({ autostart = false })
    elseif config.is_vue_hybrid_mode() then
      local mason_registry = require('mason-registry')
      local vue_language_server = mason_registry.get_package('vue-language-server')
      local install_path = vue_language_server:get_install_path()
      local location = string.format('%s/node_modules/%s/node_modules', install_path, '@vue/language-server')
      lspconfig.ts_ls.setup({
        filetypes = vue_filetypes,
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = location,
              languages = { 'vue' },
            },
          },
        },
      })
    else
      lspconfig.ts_ls.setup({ autostart = false })
      lspconfig.volar.setup({
        filetypes = vue_filetypes,
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      })
    end
    ---@diagnostic enable: missing-fields
  end,
}
