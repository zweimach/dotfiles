-- vim: set sw=0 ts=2 et :

---@param path string
---@param url string
---@return string
local function get_dir(path, url)
  local full_path = vim.fs.normalize('$WORKSPACE/' .. path)
  if vim.fn.isdirectory(full_path) ~= 0 then
    return full_path
  else
    return url
  end
end

---@class _ParserInfo
---@field name string
---@field url string
---@field files string[]
---@field filetype string
---@field branch string|nil
---@field requires_grammar boolean|nil

---@type table<string, _ParserInfo>
local parser_info_table = {
  c3 = {
    name = 'tree-sitter-c3',
    url = 'https://github.com/zwiemach/tree-sitter-c3',
    files = { 'src/parser.c', 'src/scanner.c' },
    filetype = 'c3',
  },
  cabal = {
    name = 'tree-sitter-cabal',
    url = 'https://gitlab.com/magus/tree-sitter-cabal',
    files = { 'src/parser.c', 'src/scanner.c' },
    filetype = 'cabal',
  },
  carp = {
    name = 'tree-sitter-carp',
    url = 'https://github.com/GrayJack/tree-sitter-carp',
    files = { 'src/parser.c', 'src/scanner.c' },
    filetype = 'carp',
  },
  haxe = {
    name = 'tree-sitter-haxe',
    url = 'https://github.com/vantreeseba/tree-sitter-haxe',
    files = { 'src/parser.c', 'src/scanner.c' },
    filetype = 'haxe',
  },
  reason = {
    name = 'tree-sitter-reason',
    url = 'https://github.com/danielo515/tree-sitter-reason/',
    files = { 'src/parser.c', 'src/scanner.c' },
    filetype = 'reason',
  },
  sml = {
    name = 'tree-sitter-sml',
    url = 'https://github.com/MatthewFluet/tree-sitter-sml',
    files = { 'src/parser.c', 'src/scanner.c' },
    filetype = 'sml',
  },
}

return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'nvim-treesitter/nvim-treesitter-context',
    'andymass/vim-matchup',
  },
  build = ':TSUpdate',
  config = function()
    local parsers = require('nvim-treesitter.parsers').get_parser_configs()

    for name, info in pairs(parser_info_table) do
      parsers[name] = {
        install_info = {
          url = get_dir(info.name, info.url),
          files = info.files,
          branch = info.branch or 'master',
          requires_generate_from_grammar = info.requires_grammar,
        },
        filetype = info.filetype,
        maintainers = {},
      }
    end

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
      matchup = {
        enable = true,
        disable_virtual_text = true,
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
    })

    vim.treesitter.language.register('markdown', 'markdown.mdx')
    vim.treesitter.language.register('tsx', 'javascriptflow')

    vim.o.foldenable = false
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

    vim.g.matchup_matchparen_deferred = true
    vim.g.matchup_matchparen_hi_surround_always = true
    vim.g.matchup_matchparen_offscreen = { method = 'popup' }
  end,
}
