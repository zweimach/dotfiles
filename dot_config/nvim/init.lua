-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ Plugin Manager
-- ┗━━━━━━━━━━━━━━━━━━━━━━━
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local url = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', url, '--branch=stable', lazypath })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- ┏━━━━━━━━━━━━━━━━━━━━━━━
  -- ┃ Core Plugins
  -- ┗━━━━━━━━━━━━━━━━━━━━━━━
  'nvim-lua/plenary.nvim',
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x' },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  'nvim-lualine/lualine.nvim',
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',

  -- ┏━━━━━━━━━━━━━━━━━━━━━━━
  -- ┃ LSP Plugins
  -- ┗━━━━━━━━━━━━━━━━━━━━━━━
  { 'neoclide/coc.nvim', branch = 'release' },
  'fannheyward/telescope-coc.nvim',

  -- ┏━━━━━━━━━━━━━━━━━━━━━━━
  -- ┃ Additional Plugins
  -- ┗━━━━━━━━━━━━━━━━━━━━━━━
  'gpanders/editorconfig.nvim',
  'tpope/vim-fugitive',
  'tpope/vim-obsession',
  'machakann/vim-sandwich',
  'luukvbaal/stabilize.nvim',
  'sainnhe/edge',
  'lewis6991/gitsigns.nvim',
  'numToStr/Comment.nvim',
  'lukas-reineke/indent-blankline.nvim',
  'windwp/nvim-autopairs',
  'stevearc/dressing.nvim',

  -- ┏━━━━━━━━━━━━━━━━━━━━━━━
  -- ┃ Language Plugins
  -- ┗━━━━━━━━━━━━━━━━━━━━━━━
  { 'edwinb/idris2-vim', ft = 'idris' },
  { 'purescript-contrib/purescript-vim', ft = 'purescript' },
  { 'vmchale/dhall-vim', ft = 'dhall' },
  { 'wsdjeg/vim-livescript', ft = 'livescript' },
  { 'fasterthanlime/ooc.vim', ft = 'ooc' },
  { 'rescript-lang/vim-rescript', ft = 'rescript' },
})

-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ Visual Settings
-- ┗━━━━━━━━━━━━━━━━━━━━━━━
vim.o.termguicolors = true
vim.o.ruler = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.hidden = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.cursorlineopt = 'number'
vim.o.list = true
vim.opt.listchars = { tab = '› ', trail = '~', extends = '»', precedes = '«', lead = '·', space = '␣' }
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 0
vim.o.cmdheight = 1
vim.o.updatetime = 300
vim.o.mouse = 'a'
vim.o.mousemodel = 'extend'
vim.o.signcolumn = 'yes'
vim.opt.shortmess:append('c')
vim.opt.clipboard:append('unnamedplus')
vim.opt.completeopt:append('menu')
vim.opt.completeopt:append('menuone')
vim.opt.completeopt:append('noselect')
vim.opt.formatoptions:remove('tc')
vim.o.scrolloff = 8
vim.o.undofile = true
vim.o.showmode = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

vim.g.edge_style = 'neon'
vim.g.edge_diagnostic_virtual_text = 1
vim.g.edge_disable_italic_comment = 1
vim.g.edge_better_performance = 1

vim.api.nvim_create_augroup('EdgeCustom', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  group = 'EdgeCustom',
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

-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ Statusline Settings
-- ┗━━━━━━━━━━━━━━━━━━━━━━━
require('lualine').setup({
  options = {
    always_divide_middle = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename', 'g:coc_status' },
    lualine_x = { 'encoding', 'fileformat' },
    lualine_y = { 'filetype' },
    lualine_z = { 'location' },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = { 'buffers' },
    lualine_z = { 'tabs' },
  },
  extensions = { 'fugitive', 'man', 'nvim-tree' },
})

-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ Treesitter Settings
-- ┗━━━━━━━━━━━━━━━━━━━━━━━
local parsers = require('nvim-treesitter.parsers')

require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})

vim.treesitter.language.register('tsx', 'javascriptflow')

vim.o.foldenable = false
vim.o.foldmethod = 'expr'
vim.o.foldexpr = vim.fn['nvim_treesitter#foldexpr']()

-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ Finder Settings
-- ┗━━━━━━━━━━━━━━━━━━━━━━━
local telescope = require('telescope')

telescope.setup({
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
  },
  pickers = {
    command_history = {
      theme = 'dropdown',
    },
    find_files = {
      theme = 'dropdown',
    },
  },
})

telescope.load_extension('fzf')
telescope.load_extension('coc')

local builtin = require('telescope.builtin')
local grep_string = function(use_regex)
  return function(opts)
    builtin.grep_string({ search = opts.args, use_regex = use_regex })
  end
end

vim.api.nvim_create_user_command('R', grep_string(false), { nargs = 1 })
vim.api.nvim_create_user_command('Rg', grep_string(true), { nargs = 1 })

vim.keymap.set('n', '<C-p>', function()
  builtin.find_files({ hidden = true })
end, { noremap = true, silent = true })
vim.keymap.set('n', '<A-o>', function()
  builtin.buffers({ ignore_current_buffer = true })
end, { noremap = true, silent = true })
vim.keymap.set('n', '<A-r>', builtin.live_grep, { noremap = true, silent = true })
vim.keymap.set('n', '<A-t>', builtin.grep_string, { noremap = true, silent = true })
vim.keymap.set('n', '<A-h>', builtin.command_history, { noremap = true, silent = true })
vim.keymap.set('n', '<A-m>', builtin.marks, { noremap = true, silent = true })
vim.keymap.set('n', '<A-n>', builtin.jumplist, { noremap = true, silent = true })

-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ Keymap Settings
-- ┗━━━━━━━━━━━━━━━━━━━━━━━
vim.keymap.set('n', '<Leader>g', '<Cmd>Gitsigns preview_hunk_inline<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-g>', '<Cmd>tab Git<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<Cmd>bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', '<Cmd>tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<Cmd>bprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', '<Cmd>tabprevious<CR>', { noremap = true, silent = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ Explorer Settings
-- ┗━━━━━━━━━━━━━━━━━━━━━━━
require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  respect_buf_cwd = true,
  update_cwd = true,
  filters = {
    custom = { '^\\.git$' },
  },
  view = {
    width = 40,
    side = 'left',
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_git = true,
    highlight_opened_files = 'name',
    icons = {
      show = {
        folder_arrow = false,
      },
    },
    indent_markers = {
      enable = true,
    },
    special_files = { 'Makefile', 'MAKEFILE', 'README.md', 'readme.md', 'LICENSE' },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
        exclude = {
          filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
  },
})

vim.keymap.set('n', '<C-\\>', '<Cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>r', '<Cmd>NvimTreeRefresh<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>n', '<Cmd>NvimTreeFindFileToggle<CR>', { noremap = true, silent = true })

-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ Additional Plugin Settings
-- ┗━━━━━━━━━━━━━━━━━━━━━━━
require('stabilize').setup()

require('Comment').setup()

require('gitsigns').setup({
  signcolumn = true,
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
  },
  update_debounce = 250,
  max_file_length = 10000,
})

require('indent_blankline').setup({
  use_treesitter = true,
})

local npairs = require('nvim-autopairs')

npairs.setup({
  map_cr = false,
})

vim.keymap.set('i', '<CR>', function()
  if vim.fn['coc#pum#visible']() ~= 0 then
    return vim.fn['coc#pum#confirm']()
  else
    return npairs.autopairs_cr()
  end
end, { expr = true, noremap = true, silent = true })

-- ┏━━━━━━━━━━━━━━━━━━━━━━━
-- ┃ LSP Settings
-- ┗━━━━━━━━━━━━━━━━━━━━━━━

-- Use tab for trigger completion with characters ahead and navigate.
-- NOTE: There's always complete item selected by default, you may want to enable
-- no select by `"suggest.noselect": true` in your configuration file.
-- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- other plugin before putting this into your config.
vim.keymap.set(
  'i',
  '<Tab>',
  'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<Tab>" : coc#refresh()',
  { noremap = true, silent = true, expr = true, replace_keycodes = false }
)
vim.keymap.set('i', '<S-Tab>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], { noremap = true, silent = true, expr = true, replace_keycodes = false })

-- Make <CR> to accept selected completion item or notify coc.nvim to format.
-- <C-g>u breaks current undo, please make your own choice.
vim.keymap.set(
  'i',
  '<CR>',
  [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"]],
  { noremap = true, silent = true, expr = true, replace_keycodes = false }
)

function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use <C-Space> to trigger completion.
vim.keymap.set('i', '<C-Space>', 'coc#refresh()', { silent = true, noremap = true, expr = true })

-- Use `[g` and `]g` to navigate diagnostics.
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
vim.keymap.set('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true, noremap = true })
vim.keymap.set('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true, noremap = true })

-- GoTo code navigation.
vim.keymap.set('n', 'gd', '<Cmd>Telescope coc definitions<CR>', { silent = true, noremap = true })
vim.keymap.set('n', 'gD', '<Cmd>Telescope coc declarations<CR>', { silent = true, noremap = true })
vim.keymap.set('n', 'gy', '<Cmd>Telescope coc type_definitions<CR>', { silent = true, noremap = true })
vim.keymap.set('n', 'gi', '<Cmd>Telescope coc implementations<CR>', { silent = true, noremap = true })
vim.keymap.set('n', 'gr', '<Cmd>Telescope coc references<CR>', { silent = true, noremap = true })

-- Use K to show documentation in preview window.
vim.keymap.set('n', 'K', '<Cmd>lua _G.show_documentation()<CR>', { silent = true, noremap = true })

function _G.show_documentation()
  if vim.fn.CocAction('hasProvider', 'hover') then
    vim.fn.CocActionAsync('doHover')
  else
    vim.fn.feedkeys('K', 'in')
  end
end

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup('CocGroup', {})
vim.api.nvim_create_autocmd('CursorHold', {
  group = 'CocGroup',
  command = "silent call CocActionAsync('highlight')",
})

-- Symbol renaming.
vim.keymap.set('n', '<Leader>rn', '<Plug>(coc-rename)', { silent = true, noremap = true })

-- Formatting selected code.
vim.keymap.set('x', '<Leader>f', '<Plug>(coc-format-selected)', { silent = true, noremap = true })
vim.keymap.set('n', '<Leader>f', '<Plug>(coc-format-selected)', { silent = true, noremap = true })

-- Update signature help on jump placeholder
vim.api.nvim_create_autocmd('User', {
  group = 'CocGroup',
  pattern = 'CocJumpPlaceholder',
  command = "call CocActionAsync('showSignatureHelp')",
})

-- Apply codeAction to the selected region.
-- Example: `<leader>aap` for current paragraph
vim.keymap.set('x', '<Leader>a', '<Plug>(coc-codeaction-selected)', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Leader>a', '<Plug>(coc-codeaction-selected)', { silent = true, noremap = true, nowait = true })

-- Remap keys for applying codeAction at the current cursor position.
vim.keymap.set('n', '<Leader>ac', '<Plug>(coc-codeaction-cursor)', { silent = true, noremap = true, nowait = true })
-- Remap keys for apply code actions affect whole buffer.
vim.keymap.set('n', '<Leader>as', '<Plug>(coc-codeaction-source)', { silent = true, noremap = true, nowait = true })
-- Apply AutoFix to problem on the current line.
vim.keymap.set('n', '<Leader>qf', '<Plug>(coc-fix-current)', { silent = true, noremap = true, nowait = true })
-- Run the Code Lens action on the current line.
vim.keymap.set('n', '<Leader>cl', '<Plug>(coc-codelens-action)', { silent = true, noremap = true, nowait = true })

-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server.
vim.keymap.set('x', 'if', '<Plug>(coc-funcobj-i)', { silent = true, noremap = true, nowait = true })
vim.keymap.set('o', 'if', '<Plug>(coc-funcobj-i)', { silent = true, noremap = true, nowait = true })
vim.keymap.set('x', 'af', '<Plug>(coc-funcobj-a)', { silent = true, noremap = true, nowait = true })
vim.keymap.set('o', 'af', '<Plug>(coc-funcobj-a)', { silent = true, noremap = true, nowait = true })
vim.keymap.set('x', 'ic', '<Plug>(coc-classobj-i)', { silent = true, noremap = true, nowait = true })
vim.keymap.set('o', 'ic', '<Plug>(coc-classobj-i)', { silent = true, noremap = true, nowait = true })
vim.keymap.set('x', 'ac', '<Plug>(coc-classobj-a)', { silent = true, noremap = true, nowait = true })
vim.keymap.set('o', 'ac', '<Plug>(coc-classobj-a)', { silent = true, noremap = true, nowait = true })

-- Remap <C-f> and <C-b> to scroll float windows/popups.
-- NOTE: coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750.
vim.keymap.set('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, nowait = true, expr = true, noremap = true })
vim.keymap.set('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { silent = true, nowait = true, expr = true, noremap = true })
vim.keymap.set('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', { silent = true, nowait = true, expr = true, noremap = true })
vim.keymap.set('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', { silent = true, nowait = true, expr = true, noremap = true })
vim.keymap.set('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, nowait = true, expr = true, noremap = true })
vim.keymap.set('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { silent = true, nowait = true, expr = true, noremap = true })

-- Use CTRL-S for selections ranges.
-- Requires 'textDocument/selectionRange' support of language server.
vim.keymap.set('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true, noremap = true })
vim.keymap.set('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true, noremap = true })

-- Add `:Format` command to format current buffer.
vim.api.nvim_create_user_command('Format', "call CocAction('format')", { nargs = 0 })

-- " Add `:Fold` command to fold current buffer.
vim.api.nvim_create_user_command('Fold', "call CocAction('fold', <f-args>)", { nargs = '?' })

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command('OR', "call CocActionAsync('runCommand', 'editor.action.organizeImport')", { nargs = 0 })

-- Mappings for CocList and telescope-coc.nvim
vim.keymap.set('n', '<Space>b', ':<C-u>Telescope coc diagnostics<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>a', ':<C-u>Telescope coc workspace_diagnostics<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>d', ':<C-u>Telescope coc document_symbols<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>s', ':<C-u>Telescope coc workspace_symbols<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>h', ':<C-u>Telescope coc file_code_actions<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>c', ':<C-u>Telescope coc commands<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>e', ':<C-u>CocList extensions<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>o', ':<C-u>CocList outline<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>y', ':<C-u>CocList yank<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>j', ':<C-u>CocNext<CR>', { silent = true, noremap = true, nowait = true })
vim.keymap.set('n', '<Space>k', ':<C-u>CocPrev<CR>', { silent = true, noremap = true, nowait = true })

-- vim: set sw=0 ts=2 et :
