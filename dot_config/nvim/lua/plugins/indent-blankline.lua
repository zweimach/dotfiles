-- vim: set sw=0 ts=2 et :

return {
  'lukas-reineke/indent-blankline.nvim',
  version = '2.*',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    use_treesitter = true,
  },
}
