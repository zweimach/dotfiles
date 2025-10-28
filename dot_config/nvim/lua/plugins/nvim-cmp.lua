-- vim: set sw=0 ts=2 et :

local function is_in_start_tag()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return false
  end
  local node_to_check = { 'start_tag', 'self_closing_tag', 'directive_attribute' }
  return vim.tbl_contains(node_to_check, node:type())
end

---@module 'lazy'
---@type LazySpec
return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'PaterJason/cmp-conjure',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    local utils = require('utils')
    local editor_config = require('utils.config').get_editor_config()

    local bordered = cmp.config.window.bordered({
      border = 'rounded',
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    })

    ---@param entry cmp.Entry
    ---@param ctx cmp.Context
    local function entry_filter(entry, ctx)
      if ctx.filetype ~= 'vue' then
        return true
      end

      local bufnr = ctx.bufnr
      local cached_is_in_start_tag = vim.b[bufnr]._vue_ts_cached_is_in_start_tag
      if cached_is_in_start_tag == nil then
        vim.b[bufnr]._vue_ts_cached_is_in_start_tag = is_in_start_tag()
      end

      if vim.b[bufnr]._vue_ts_cached_is_in_start_tag == false then
        return true
      end

      local cursor_before_line = ctx.cursor_before_line
      if cursor_before_line:sub(-1) == '@' then
        return entry.completion_item.label:match('^@')
      elseif cursor_before_line:sub(-1) == ':' then
        return entry.completion_item.label:match('^:') and not entry.completion_item.label:match('^:on%-')
      else
        return true
      end
    end

    cmp.setup({
      window = {
        completion = bordered,
        documentation = bordered,
      },
      sources = cmp.config.sources({
        { name = 'nvim_lsp', entry_filter = entry_filter },
        { name = 'conjure' },
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
            conjure = '[Conjure]',
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
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
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

    cmp.event:on('menu_closed', function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.b[bufnr]._vue_ts_cached_is_in_start_tag = nil
    end)
  end,
}
