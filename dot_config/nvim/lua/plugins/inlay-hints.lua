-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'MysticalDevil/inlay-hints.nvim',
  event = 'LspAttach',
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function()
    local inlay_hints = require('inlay-hints')
    local config = require('utils.config')

    local editor_config = config.get_editor_config()
    inlay_hints.setup({
      autocmd = { enable = editor_config.inlayHints },
      commands = { enable = false },
    })
  end,
}
