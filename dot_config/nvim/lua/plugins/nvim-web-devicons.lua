-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'nvim-tree/nvim-web-devicons',
  config = function()
    local devicons = require('nvim-web-devicons')

    local sml_icon = devicons.get_icons_by_extension()['sml']

    devicons.setup({
      override_by_extension = {
        fun = sml_icon,
        mlb = sml_icon,
      },
    })
  end,
}
