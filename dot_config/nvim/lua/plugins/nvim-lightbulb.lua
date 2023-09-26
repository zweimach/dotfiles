-- vim: set sw=0 ts=2 et :

return {
  'kosayoda/nvim-lightbulb',
  config = function()
    vim.api.nvim_set_hl(0, 'LightBulbSign', { link = 'DiagnosticSignWarn' })

    require('nvim-lightbulb').setup({
      autocmd = { enabled = true },
      sign = { enabled = true, text = '' },
    })
  end,
}
