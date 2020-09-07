""
"" Package Manager
""
let vimplug=expand('~/.config/nvim/autoload/plug.vim')

call plug#begin(expand('~/.config/nvim/plugged'))


""
"" Core Packages
""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
Plug 'amiralies/coc-flow', {'do': 'yarn install --frozen-lockfile'}

""
"" Additional Packages
""
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy'
Plug 'ryanoasis/vim-devicons'
Plug 'liuchengxu/vista.vim'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'dracula/vim', { 'as': 'dracula' }


""
"" JavaScript Language Specific Packages
""
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty',
\ {
\   'for': [
\     'javascript',
\     'javascript.jsx',
\     'typescript',
\     'typescript.tsx'
\   ]
\ }


""
"" TypeScript Language Specific Packages
""
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }


""
"" C/C++ Language Specific Packages
""
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }


""
"" Rust Language Specific Packages
""
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }


""
"" Haskell Language Specific Packages
""
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell'] }


""
"" PureScript Language Specific Packages
""
Plug 'purescript-contrib/purescript-vim', { 'for': ['purescript'] }


""
"" Elm Language Specific Packages
""
Plug 'andys8/vim-elm-syntax', { 'for': ['elm'] }


""
"" Zig Language Specific Packages
""
Plug 'ziglang/zig.vim', { 'for': ['zig'] }


call plug#end()


""
"" Visual Settings
""
syntax enable
set ruler
set relativenumber
set number
set hidden
set expandtab
set listchars=tab:>·,trail:~,extends:>,precedes:<,space:␣
set list
set tabstop=4
set shiftwidth=4
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set clipboard=unnamedplus
set completeopt-=preview
set termguicolors

colorscheme dracula

let g:airline_theme = 'dracula'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_c = '%t'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#branch#prefix        = '⤴'
let g:airline#extensions#readonly#symbol      = '⊘'
let g:airline#extensions#linecolumn#prefix    = '¶'
let g:airline#extensions#paste#symbol         = 'ρ'
let g:airline_symbols.paste                   = 'ρ'
let g:airline_symbols.paste                   = 'Þ'
let g:airline_symbols.paste                   = '∥'
let g:airline_symbols.whitespace              = 'Ξ'
let g:airline#extensions#tabline#left_sep     = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline_left_sep                        = ''
let g:airline_left_alt_sep                    = ''
let g:airline_right_sep                       = ''
let g:airline_right_alt_sep                   = ''
let g:airline_symbols.branch                  = ''
let g:airline_symbols.readonly                = ''
let g:airline_symbols.linenr                  = ''

let g:gitgutter_max_signs = 500
let g:gitgutter_map_keys = 0


"""
""" JavaScript Language Settings
"""
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx


"""
""" Haskell Language Settings
"""
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1


""
"" Keymap Settings
""

"" TAB
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"" SHIFT-T
nnoremap <silent> T :call <SID>show_documentation()<CR>

"" CTRL-P
nnoremap <c-p> :Files <CR>

"" CTRL-S
nnoremap <c-s> :w <CR>

"" SHIFT-K
nmap <silent> <s-k> <Plug>(coc-diagnostic-prev)

"" SHIFT-J
nmap <silent> <s-j> <Plug>(coc-diagnostic-next)

"" CTRL-J
nmap <silent> <c-j> :bnext<CR>

"" CTRL-K
nmap <silent> <c-k> :bprev<CR>

"" CTRL-\
noremap <C-\> :NERDTreeToggle<CR>

"" Y & SHIFT-Y
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

"" CTRL-I
command! -nargs=0 Format :call CocAction('format')
nnoremap <silent> <c-I> :Format <CR>

