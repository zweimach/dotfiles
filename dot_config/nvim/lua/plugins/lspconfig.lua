-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'neovim/nvim-lspconfig',
  branch = 'master',
  dependencies = {
    'b0o/schemastore.nvim',
    'lukas-reineke/lsp-format.nvim',
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    local config_lsp = require('config.lsp')
    local utils_config = require('utils.config')

    vim.lsp.handlers['client/registerCapability'] = (function(overridden)
      return function(err, res, ctx)
        local result = overridden(err, res, ctx)
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        if not client then
          return
        end
        config_lsp.lsp_setup(client, vim.api.nvim_get_current_buf())
        return result
      end
    end)(vim.lsp.handlers['client/registerCapability'])

    vim.api.nvim_create_autocmd('LspAttach', {
      group = config_lsp.setup_augroup,
      callback = config_lsp.on_attach,
    })

    vim.lsp.config('*', {
      flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 500,
        exit_timeout = false,
      },
    })

    vim.lsp.config('hls', {
      filetypes = { 'haskell', 'lhaskell', 'cabal' },
      settings = {
        haskell = {
          cabalFormattingProvider = 'cabal-gild',
          formattingProvider = 'fourmolu',
        },
      },
    })
    vim.lsp.config('racket_langserver', { filetypes = { 'racket' } })
    vim.lsp.config('postgres_lsp', {
      root_dir = lspconfig.util.root_pattern('.git', 'postgrestools.jsonc', 'postgrestools.json'),
    })

    vim.lsp.config('psalm', { cmd = { 'vendor/bin/psalm', '--language-server' } })

    local eslint_lsp_config = utils_config.get_eslint_lsp_config()
    vim.lsp.config('eslint', { settings = eslint_lsp_config })

    local rescriptls_config = utils_config.get_rescriptls_config()
    vim.lsp.config('rescriptls', {
      init_options = { extensionConfiguration = rescriptls_config },
    })

    local schemastore = require('schemastore')
    vim.lsp.config('jsonls', {
      settings = {
        json = {
          schemas = schemastore.json.schemas(),
        },
      },
    })
    vim.lsp.config('yamlls', {
      settings = {
        yaml = {
          schemaStore = { enable = false, url = '' },
          schemas = schemastore.yaml.schemas(),
        },
      },
    })
    vim.lsp.config('typos_lsp', {
      init_options = { diagnosticSeverity = 'Hint' },
    })

    local licence_key, global_storage_path = utils_config.get_intelephense_config()
    vim.lsp.config('intelephense', {
      init_options = {
        licenceKey = licence_key,
        globalStoragePath = global_storage_path,
      },
    })

    if utils_config.is_vue_enabled() then
      local vue_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
      local location = vim.fn.stdpath('data') .. '/mason/packages/vue-language-server/node_modules/@vue/language-server'
      vim.lsp.config('vtsls', {
        filetypes = vue_filetypes,
        settings = {
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = '@vue/typescript-plugin',
                  location = location,
                  languages = { 'vue' },
                  configNamespace = 'typescript',
                },
              },
            },
          },
        },
      })
    end

    vim.lsp.enable(mason_lspconfig.get_installed_servers())
    vim.lsp.enable({
      'ada_ls',
      'clangd',
      'dartls',
      'gleam',
      'hls',
      'metals',
      'nixd',
      'ocamllsp',
      'racket_langserver',
      'ruff',
      'zls',
    })
    vim.lsp.enable({ 'graphql', 'harper_ls', 'scheme_langserver', 'vale_ls' }, false)

    if utils_config.is_biome_enabled() then
      vim.lsp.enable('biome', true)
      vim.lsp.enable('eslint', false)
    end

    if utils_config.is_deno_enabled() then
      vim.lsp.enable('denols', true)
      vim.lsp.enable('vtsls', false)
    end
  end,
}
