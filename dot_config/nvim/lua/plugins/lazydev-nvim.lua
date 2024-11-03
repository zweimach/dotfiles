-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/neoconf.nvim',
    lazy = false,
    priority = 100,
    opts = {},
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
      enabled = function()
        local neoconf = require('neoconf')
        local defaults = { enabled = false }
        return neoconf.get('lazydev', defaults).enabled
      end,
    },
  },
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = 'lazydev',
        group_index = 0,
      })
    end,
  },
}
