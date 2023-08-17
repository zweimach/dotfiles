-- vim: set sw=0 ts=2 et :

return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    use_treesitter = true,
  },
}
