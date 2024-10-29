-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  config = true,
}
