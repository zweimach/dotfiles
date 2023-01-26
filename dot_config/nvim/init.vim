" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Plugin Manager
" ┗━━━━━━━━━━━━━━━━━━━━━━━
call plug#begin()


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Core Plugins
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim',            { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter',          { 'do': ':TSUpdate' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ LSP Plugins
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'neoclide/coc.nvim',                    { 'branch': 'release' }
Plug 'fannheyward/telescope-coc.nvim'


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Additional Plugins
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'gpanders/editorconfig.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'machakann/vim-sandwich'
Plug 'luukvbaal/stabilize.nvim'
Plug 'sainnhe/edge'
Plug 'lewis6991/gitsigns.nvim'
Plug 'windwp/nvim-autopairs'


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Language Plugins
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'edwinb/idris2-vim',                   { 'for': ['idris']          }
Plug 'purescript-contrib/purescript-vim',   { 'for': ['purescript']     }
Plug 'vmchale/dhall-vim',                   { 'for': ['dhall']          }
Plug 'wsdjeg/vim-livescript',               { 'for': ['livescript']     }
Plug 'arrufat/vala.vim',                    { 'for': ['vala']           }
Plug 'fasterthanlime/ooc.vim',              { 'for': ['ooc']            }
Plug 'jakwings/vim-pony',                   { 'for': ['pony']           }


call plug#end()


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Visual Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
set termguicolors
set ruler
set number
set relativenumber
set hidden
set autoindent
set smartindent
set ignorecase
set smartcase
set list
set listchars=tab:›\ ,trail:~,extends:»,precedes:«,lead:·,space:␣
set expandtab
set tabstop=4
set shiftwidth=0
set cmdheight=1
set updatetime=300
set mouse=a
set mousemodel=extend
set signcolumn=yes
set shortmess+=c
set clipboard+=unnamedplus
set completeopt=menu,menuone,noselect
set formatoptions-=tc
set scrolloff=8
set undofile
set noshowmode
set noswapfile
set nobackup
set nowritebackup

let g:edge_style                   = 'neon'
let g:edge_diagnostic_virtual_text = 1
let g:edge_disable_italic_comment  = 1
let g:edge_better_performance      = 1

function! s:edge_custom() abort
  let l:palette = edge#get_palette(g:edge_style, 0, {})
  call edge#highlight('NormalFloat', l:palette.fg, l:palette.bg0)
  call edge#highlight('FloatBorder', l:palette.grey, l:palette.bg0)
endfunction

augroup EdgeCustom
  autocmd!
  autocmd ColorScheme edge call s:edge_custom()
augroup END

colorscheme edge


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Statusline Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
lua <<EOF
require('lualine').setup({
  options = {
    always_divide_middle = false,
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
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
EOF


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Treesitter Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
lua <<EOF
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
EOF

set nofoldenable
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Finder Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
lua <<EOF
require('telescope').setup({
  defaults = {
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
  },
})

require('telescope').load_extension('fzf')

require('telescope').load_extension('coc')
EOF

nnoremap <silent> <C-p> <Cmd>Telescope find_files<CR>
nnoremap <silent> <A-o> <Cmd>Telescope buffers<CR>
nnoremap <silent> <A-r> <Cmd>Telescope live_grep<CR>
nnoremap <silent> <A-t> <Cmd>Telescope grep_string<CR>
nnoremap <silent> <A-h> <Cmd>Telescope command_history<CR>


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Keymap Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
nnoremap <silent> <Leader>g <Cmd>Gitsigns preview_hunk_inline<CR>
nnoremap <silent> <A-g> <Cmd>tab Git<CR>
nnoremap <silent> <C-j> <Cmd>bnext<CR>
nnoremap <silent> <A-j> <Cmd>tabnext<CR>
nnoremap <silent> <C-k> <Cmd>bprev<CR>
nnoremap <silent> <A-k> <Cmd>tabprevious<CR>
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Explorer Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
lua <<EOF
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
          buftype  = { 'nofile', 'terminal', 'help' },
        },
      },
    },
  },
})
EOF

nnoremap <silent> <C-\> <Cmd>NvimTreeToggle<CR>
nnoremap <silent> <Leader>r <Cmd>NvimTreeRefresh<CR>
nnoremap <silent> <Leader>n <Cmd>NvimTreeFindFile<CR>


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Additional Plugin Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
lua <<EOF
require('stabilize').setup()

require('gitsigns').setup({
  signcolumn = true,
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 500,
  },
  update_debounce = 250,
  max_file_length = 10000,
})

local npairs = require("nvim-autopairs")

npairs.setup({
  map_cr = false,
})

vim.keymap.set('i', '<CR>', function()
  if vim.fn["coc#pum#visible"]() ~= 0 then
    return vim.fn["coc#pum#confirm"]()
  else
    return npairs.autopairs_cr()
  end
end, { expr = true, noremap = true, silent = true })
EOF


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ LSP Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent> <expr> <Tab>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <silent> <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format.
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent> <expr> <CR> coc#pum#visible() ? coc#pum#confirm()
  \ : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <C-Space> to trigger completion.
inoremap <silent> <expr> <C-Space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics.
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nnoremap <silent> gd <Cmd>Telescope coc definitions<CR>
nnoremap <silent> gD <Cmd>Telescope coc declarations<CR>
nnoremap <silent> gy <Cmd>Telescope coc type_definitions<CR>
nnoremap <silent> gi <Cmd>Telescope coc implementations<CR>
nnoremap <silent> gr <Cmd>Telescope coc references<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K <Cmd>call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <silent> <Leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <silent> <Leader>f <Plug>(coc-format-selected)
nmap <silent> <Leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<Leader>aap` for current paragraph
xmap <silent> <Leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <Leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <silent> <Leader>ac <Plug>(coc-codeaction)
" Remap keys for apply code actions affect whole buffer
nmap <silent> <Leader>as <Plug>(coc-codeaction-source)
" Apply AutoFix to problem on the current line.
nmap <silent> <Leader>qf <Plug>(coc-fix-current)
" Run the Code Lens action on the current line.
nmap <silent> <Leader>cl <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap <silent> if <Plug>(coc-funcobj-i)
omap <silent> if <Plug>(coc-funcobj-i)
xmap <silent> af <Plug>(coc-funcobj-a)
omap <silent> af <Plug>(coc-funcobj-a)
xmap <silent> ic <Plug>(coc-classobj-i)
omap <silent> ic <Plug>(coc-classobj-i)
xmap <silent> ac <Plug>(coc-classobj-a)
omap <silent> ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups.
" NOTE: coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750.
nnoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(1)\<CR>" : "\<Right>"
inoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? "\<C-r>=coc#float#scroll(0)\<CR>" : "\<Left>"
vnoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Mappings for CocList and telescope-coc.nvim
nnoremap <silent> <nowait> <Space>b :<C-u>Telescope coc diagnostics<CR>
nnoremap <silent> <nowait> <Space>a :<C-u>Telescope coc workspace_diagnostics<CR>
nnoremap <silent> <nowait> <Space>d :<C-u>Telescope coc document_symbols<CR>
nnoremap <silent> <nowait> <Space>s :<C-u>Telescope coc workspace_symbols<CR>
nnoremap <silent> <nowait> <Space>h :<C-u>Telescope coc file_code_actions<CR>
nnoremap <silent> <nowait> <Space>c :<C-u>Telescope coc commands<CR>
nnoremap <silent> <nowait> <Space>e :<C-u>CocList extensions<CR>
nnoremap <silent> <nowait> <Space>o :<C-u>CocList outline<CR>
nnoremap <silent> <nowait> <Space>y :<C-u>CocList yank<CR>
nnoremap <silent> <nowait> <Space>j :<C-u>CocNext<CR>
nnoremap <silent> <nowait> <Space>k :<C-u>CocPrev<CR>

" vim: set sw=0 ts=2 et :
