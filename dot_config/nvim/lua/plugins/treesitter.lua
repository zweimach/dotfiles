-- vim: set sw=0 ts=2 et :

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/playground',
  },
  build = ':TSUpdate',
  config = function()
    local parsers = require('nvim-treesitter.parsers')

    parsers.get_parser_configs().standard_ml = {
      install_info = {
        -- url = 'https://github.com/stonebuddha/tree-sitter-sml',
        url = '~/Workspace/tree-sitter-sml',
        files = { 'src/parser.c', 'src/scanner.cc' },
      },
      filetype = 'sml',
    }

    parsers.get_parser_configs().carp = {
      install_info = {
        -- url = 'https://github.com/GrayJack/tree-sitter-carp',
        url = '~/Workspace/tree-sitter-carp',
        files = { 'src/parser.c', 'src/scanner.c' },
      },
      filetype = 'carp',
    }

    parsers.get_parser_configs().rescript = {
      install_info = {
        -- url = 'https://github.com/nkrkv/tree-sitter-rescript',
        url = '~/Workspace/tree-sitter-rescript',
        files = { 'src/parser.c', 'src/scanner.c' },
      },
      filetype = 'rescript',
    }

    parsers.get_parser_configs().c3 = {
      install_info = {
        -- url = 'https://github.com/zwiemach/tree-sitter-c3',
        url = '~/Workspace/tree-sitter-c3',
        files = { 'src/parser.c' },
      },
      filetype = 'c3',
    }

    require('nvim-treesitter.configs').setup({
      ensure_installed = { 'json', 'lua', 'query', 'vimdoc', 'vim' },
      auto_install = true,
      sync_install = false,
      ignore_install = {},
      modules = {},
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-Space>',
          node_incremental = '<C-Space>',
          node_decremental = '<A-Space>',
          scope_incremental = '<C-s>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
      },
      playground = {
        enable = true,
      },
      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { 'BufWrite', 'CursorHold' },
      },
    })

    vim.treesitter.language.register('tsx', 'javascriptflow')

    vim.o.foldenable = false
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
}
