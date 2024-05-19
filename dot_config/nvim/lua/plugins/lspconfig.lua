-- vim: set sw=0 ts=2 et :

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
    local config = require('utils.config')

    local augroup = vim.api.nvim_create_augroup('LspZeroSetup', { clear = true })

    lsp_zero.on_attach(function(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      local capabilities = client.server_capabilities
      local editor_config = config.get_editor_config()

      if not editor_config.semanticHighlighting then
        client.server_capabilities.semanticTokensProvider = nil
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
      if document_highlight_enabled and capabilities and capabilities.documentHighlightProvider then
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
          filter = config.disallow_format({
            'cssls',
            'html',
            'intelephense',
            'jsonls',
            'lua_ls',
            'tsserver',
            'volar',
            'yamlls',
          }),
        })
      end

      map('n', '<Leader>df', format, '[D]ocument [F]ormat')
      map('x', '<Leader>df', format, '[D]ocument [F]ormat')
      map('n', '<F3>', format, 'Document Format')
      map('x', '<F3>', format, 'Document Format')
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', format, { desc = 'Format current buffer with LSP' })

      if editor_config.formatOnSave and capabilities and capabilities.documentFormattingProvider then
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
      'gleam',
      'metals',
      'ocamllsp',
      'racket_langserver',
      'zls',
    })
    lspconfig.flow.setup({ filetypes = { 'javascript', 'javascriptreact', 'javascriptflow' } })
    lspconfig.hls.setup({ filetypes = { 'haskell', 'lhaskell', 'cabal' } })

    if config.is_deno_enabled() then
      lspconfig.denols.setup({})
      lspconfig.tsserver.setup({ autostart = false })
    end

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

    local licence_key, global_storage_path = config.get_intelephense_config()
    lspconfig.intelephense.setup({
      init_options = {
        licenceKey = licence_key,
        globalStoragePath = global_storage_path,
      },
    })

    local vue_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
    if config.is_vue_hybrid_mode() then
      local mason_registry = require('mason-registry')
      local vue_language_server = mason_registry.get_package('vue-language-server')
      local install_path = vue_language_server:get_install_path()
      local location = string.format('%s/node_modules/%s/node_modules', install_path, '@vue/language-server')
      lspconfig.tsserver.setup({
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
      lspconfig.tsserver.setup({ autostart = false })
      lspconfig.volar.setup({
        filetypes = vue_filetypes,
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      })
    end
  end,
}
