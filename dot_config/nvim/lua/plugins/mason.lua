-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  {
    'mason-org/mason.nvim',
    version = 'v2.x',
    ---@module 'mason'
    ---@type MasonSettings
    opts = {
      PATH = 'prepend',
    },
  },
  {
    'mason-org/mason-lspconfig.nvim',
    version = 'v2.x',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    ---@module 'mason-lspconfig'
    ---@type MasonLspconfigSettings
    opts = {
      ensure_installed = { 'jsonls', 'lua_ls' },
      automatic_installation = false,
      automatic_enable = false,
    },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    version = 'v2.x',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvimtools/none-ls.nvim',
    },
    opts = {
      ensure_installed = { 'stylua' },
      automatic_installation = false,
      handlers = {},
    },
  },
}
