-- vim: set sw=0 ts=2 et :

return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    local cmp_action = require('lsp-zero').cmp_action()
    local utils = require('utils')
    local editor_config = require('utils.config').get_editor_config()

    local bordered = cmp.config.window.bordered({
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    })

    cmp.setup({
      window = {
        completion = bordered,
        documentation = bordered,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }),
      formatting = {
        expandable_indicator = true,
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
          mode = 'symbol',
          maxwidth = 50,
          ellipsis_char = '...',
          menu = {
            buffer = '[Buffer]',
            cmdline = '[Command]',
            luasnip = '[Snippet]',
            nvim_lsp = '[LSP]',
            path = '[Path]',
          },
          show_labelDetails = editor_config.showCompletionSource,
          before = utils.show_lsp_server_name,
        }),
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-d>'] = cmp_action.luasnip_jump_forward(),
        ['<C-u>'] = cmp_action.luasnip_jump_backward(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
      }),
    })

    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
}
