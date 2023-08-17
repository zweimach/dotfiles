-- vim: set sw=0 ts=2 et :

return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({
      signcolumn = true,
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
      },
      update_debounce = 250,
      max_file_length = 10000,
    })
  end,
}
