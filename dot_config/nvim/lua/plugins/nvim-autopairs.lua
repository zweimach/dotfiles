-- vim: set sw=0 ts=2 et :

return {
  'windwp/nvim-autopairs',
  config = function()
    local npairs = require('nvim-autopairs')
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')

    npairs.setup({
      map_cr = false,
    })

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
