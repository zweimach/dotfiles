-- vim: set sw=0 ts=2 et :

---@module 'lazy'
---@type LazySpec
return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'gbprod/none-ls-ecs.nvim',
  },
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.phpstan.with({
          command = 'vendor/bin/phpstan',
          condition = function(utils)
            return utils.root_has_file('phpstan.neon')
          end,
        }),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shfmt,
        null_ls.builtins.formatting.stylua,
      },
    })
    null_ls.register(require('none-ls-ecs.formatting').with({
      name = 'easy-coding-standard',
      command = 'vendor/bin/ecs',
      condition = function(utils)
        return utils.root_has_file('ecs.php')
      end,
    }))
  end,
}
