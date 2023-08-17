-- vim: set sw=0 ts=2 et :

return {
  'windwp/nvim-autopairs',
  config = function()
    local npairs = require('nvim-autopairs')

    npairs.setup({
      map_cr = false,
    })

    vim.keymap.set('i', '<CR>', function()
      if vim.fn['coc#pum#visible']() ~= 0 then
        return vim.fn['coc#pum#confirm']()
      else
        return npairs.autopairs_cr()
      end
    end, { expr = true, noremap = true, silent = true })
  end,
}
