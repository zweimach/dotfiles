-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {},
}
