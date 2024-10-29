-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  {
    'sainnhe/edge',
    lazy = false,
    priority = 200,
    config = function()
      vim.o.background = 'dark'
      vim.g.edge_style = 'neon'
      vim.g.edge_diagnostic_virtual_text = 1
      vim.g.edge_disable_italic_comment = 1
      vim.g.edge_better_performance = 1

      local augroup = vim.api.nvim_create_augroup('EdgeCustom', { clear = true })
      vim.api.nvim_create_autocmd('ColorScheme', {
        group = augroup,
        pattern = { 'edge' },
        callback = function()
          local configuration = vim.fn['edge#get_configuration']()
          local palette = vim.fn['edge#get_palette'](configuration.style, configuration.dim_foreground, configuration.colors_override)
          vim.fn['edge#highlight']('NormalFloat', palette.fg, palette.bg0)
          vim.fn['edge#highlight']('FloatBorder', palette.grey, palette.bg0)
          vim.fn['edge#highlight']('CursorLineNr', palette.fg, palette.bg0)
        end,
      })

      vim.cmd.colorscheme('edge')
    end,
  },
}
