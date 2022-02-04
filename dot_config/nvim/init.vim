" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Package Manager
" ┗━━━━━━━━━━━━━━━━━━━━━━━
call plug#begin(expand('~/.config/nvim/plugged'))


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Core Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lualine/lualine.nvim'


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ LSP Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'neoclide/coc.nvim',                    {'branch': 'release'}
Plug 'antoinemadec/coc-fzf',                 {'branch': 'release'}
Plug 'neoclide/coc-pairs',                   {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-css',                     {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-json',                    {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-yaml',                    {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-html',                    {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-prettier',                {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-eslint',                  {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-stylelint',               {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-tsserver',                {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'neoclide/coc-yank',                    {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'fannheyward/coc-rust-analyzer',        {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'fannheyward/coc-pyright',              {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'fannheyward/coc-deno',                 {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'clangd/coc-clangd',                    {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'coc-extensions/coc-svelte',            {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'rodrigore/coc-tailwind-intellisense',  {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'josa42/coc-go',                        {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'xiyaowong/coc-sumneko-lua',            {'do': 'npm install --no-package-lock --legacy-peer-deps'}
Plug 'yaegassy/coc-volar',                   {'do': 'npm install --no-package-lock --legacy-peer-deps'}


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Additional Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'machakann/vim-sandwich'
Plug 'luukvbaal/stabilize.nvim'
Plug 'sainnhe/edge'


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Idris Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'edwinb/idris2-vim', { 'for': ['idris'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Reason Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'reasonml-editor/vim-reason-plus', { 'for': ['reason'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ PureScript Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'purescript-contrib/purescript-vim', { 'for': ['purescript'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Dhall Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'vmchale/dhall-vim', { 'for': ['dhall'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ ReScript Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'rescript-lang/vim-rescript', { 'for': ['rescript'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Racket Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'wlangstroth/vim-racket', { 'for': ['racket', 'scheme'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ LiveScript Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'wsdjeg/vim-livescript', { 'for': ['livescript'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Vala Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'arrufat/vala.vim', { 'for': ['vala'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ OOC Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'fasterthanlime/ooc.vim', { 'for': ['ooc'] }


call plug#end()


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Visual Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
syntax enable
set mouse=a
set ruler
set relativenumber
set number
set hidden
set expandtab
set autoindent
set nosmartindent
set nocindent
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:␣
set list
set tabstop=4
set shiftwidth=4
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes
set clipboard=unnamedplus
set completeopt-=preview
set formatoptions-=t
set noshowmode
set noswapfile
set termguicolors
set nobackup
set nowritebackup

filetype indent off

let g:edge_style                   = 'neon'
let g:edge_enable_italic           = 1
let g:edge_disable_italic_comment  = 1
let g:edge_better_performance      = 1

colorscheme edge

let g:EditorConfig_preserve_formatoptions  = 1

let g:gitgutter_map_keys                   = 0
let g:gitgutter_sign_added                 = '+'
let g:gitgutter_sign_modified              = '>'
let g:gitgutter_sign_removed               = '-'
let g:gitgutter_sign_removed_first_line    = '^'
let g:gitgutter_sign_modified_removed      = '<'

lua <<EOF
require("stabilize").setup()
EOF


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Statusline Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
lua <<EOF
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'edge',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat'},
    lualine_y = {'filetype'},
    lualine_z = {'location'},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {'buffers'},
    lualine_z = {'tabs'},
  },
  extensions = {'fugitive', 'fzf', 'nvim-tree'},
})
EOF


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Treesitter Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
lua <<EOF
require('nvim-treesitter.configs').setup({
  ensure_installed = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
})
EOF


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Keymap Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <A-o> :Buffers<CR>
nnoremap <silent> <C-j> :bnext<CR>
nnoremap <silent> <A-j> :tabnext<CR>
nnoremap <silent> <C-k> :bprev<CR>
nnoremap <silent> <A-k> :tabprevious<CR>
nnoremap <silent> <C-l> :nohlsearch<Bar>diffupdate<CR><C-l>
nnoremap <silent> Y y$
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Explorer Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
let g:nvim_tree_quit_on_open = 0
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_root_folder_modifier = ':~'
let g:nvim_tree_add_trailing = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_disable_window_picker = 1
let g:nvim_tree_icon_padding = ' '
let g:nvim_tree_symlink_arrow = ' >> '
let g:nvim_tree_respect_buf_cwd = 1
let g:nvim_tree_create_in_closed_folder = 0
let g:nvim_tree_refresh_wait = 500
let g:nvim_tree_window_picker_exclude = {
\   'filetype': [
\     'notify',
\     'packer',
\     'qf'
\   ],
\   'buftype': [
\     'terminal'
\   ]
\ }
let g:nvim_tree_special_files = {
\   'README.md': 1,
\   'Makefile': 1,
\   'MAKEFILE': 1
\ }
let g:nvim_tree_show_icons = {
\   'git': 1,
\   'folders': 1,
\   'files': 1,
\   'folder_arrows': 1,
\ }
let g:nvim_tree_icons = {
\   'default': '',
\   'symlink': '',
\   'git': {
\     'unstaged': "✗",
\     'staged': "✓",
\     'unmerged': "",
\     'renamed': "➜",
\     'untracked': "★",
\     'deleted': "",
\     'ignored': "◌"
\     },
\   'folder': {
\     'arrow_open': "",
\     'arrow_closed': "",
\     'default': "",
\     'open': "",
\     'empty': "",
\     'empty_open': "",
\     'symlink': "",
\     'symlink_open': "",
\   }
\ }

lua <<EOF
require('nvim-tree').setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  auto_close = false,
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable = true,
  },
  git = {
    enable = true,
    ignore = true,
  },
  filters = {
    dotfiles = false,
    custom = {'.git', 'node_modules', '.cache'},
  },
  view = {
    width = 40,
    side = 'left',
    auto_resize = false,
  },
})
EOF

nnoremap <silent> <C-\> :NvimTreeToggle<CR>
nnoremap <silent> <leader>r :NvimTreeRefresh<CR>
nnoremap <silent> <leader>n :NvimTreeFindFile<CR>

highlight NvimTreeFolderIcon guibg=blue


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ LSP Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent> <expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent> <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent> <expr> <C-space> coc#refresh()
else
  inoremap <silent> <expr> <C-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent> <expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <silent> <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <silent> <leader>f <Plug>(coc-format-selected)
nmap <silent> <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>a <Plug>(coc-codeaction-selected)


" Remap keys for applying codeAction to the current buffer.
nmap <silent> <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <silent> <leader>qf <Plug>(coc-fix-current)
" Apply CodeLens action on the current line.
nmap <silent> <leader>lc <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <silent> <nowait> <expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <silent> <nowait> <expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

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

" Mappings for CoCList
nnoremap <silent> <nowait> <space>h :<C-u>CocFzfList actions<cr>
nnoremap <silent> <nowait> <space>a :<C-u>CocFzfList diagnostics<cr>
nnoremap <silent> <nowait> <space>b :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <nowait> <space>e :<C-u>CocFzfList extensions<cr>
nnoremap <silent> <nowait> <space>c :<C-u>CocFzfList commands<cr>
nnoremap <silent> <nowait> <space>l :<C-u>CocFzfList location<cr>
nnoremap <silent> <nowait> <space>o :<C-u>CocFzfList outline<cr>
nnoremap <silent> <nowait> <space>s :<C-u>CocFzfList symbols<cr>
nnoremap <silent> <nowait> <space>y :<C-u>CocFzfList yank<cr>
nnoremap <silent> <nowait> <space>j :<C-u>CocNext<CR>
nnoremap <silent> <nowait> <space>k :<C-u>CocPrev<CR>
nnoremap <silent> <nowait> <space>p :<C-u>CocFzfListResume<CR>
