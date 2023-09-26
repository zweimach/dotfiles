-- vim: set sw=0 ts=2 et :

return {
  { 'williamboman/mason.nvim', config = true },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      require('mason-lspconfig').setup({
        ensure_installed = { 'jsonls', 'lua_ls' },
        automatic_installation = false,
        handlers = {
          lsp_zero.default_setup,
        },
      })
    end,
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      require('mason-null-ls').setup({
        ensure_installed = { 'stylua' },
        automatic_installation = false,
        handlers = {},
      })
    end,
  },
}
