-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'nvim-lua/plenary.nvim',
  'tpope/vim-fugitive',
  'tpope/vim-obsession',
  'stevearc/dressing.nvim',
  { 'luukvbaal/stabilize.nvim', config = true },

  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    config = true,
  },
}
