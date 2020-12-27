" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Package Manager
" ┗━━━━━━━━━━━━━━━━━━━━━━━
let vimplug=expand('~/.config/nvim/autoload/plug.vim')

call plug#begin(expand('~/.config/nvim/plugged'))


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Core Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'

" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ LSP Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-vetur', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}
Plug 'clangd/coc-clangd', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-rust-analyzer', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-sh', {'do': 'yarn install --frozen-lockfile'}
Plug 'josa42/coc-go', {'do': 'yarn install --frozen-lockfile'}
Plug 'antoinemadec/coc-fzf', {'do': 'yarn install --frozen-lockfile'}
Plug 'iamcco/coc-vimlsp', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}

" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Core Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-sandwich'
Plug 'dracula/vim', { 'as': 'dracula' }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ JavaScript Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
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


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ TypeScript Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'typescript.tsx'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ C/C++ Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Rust Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'rust-lang/rust.vim', { 'for': ['rust'] }



" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Haskell Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ PureScript Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'purescript-contrib/purescript-vim', { 'for': ['purescript'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Elm Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'andys8/vim-elm-syntax', { 'for': ['elm'] }


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Zig Packages
" ┗━━━━━━━━━━━━━━━━━━━━━━━
Plug 'ziglang/zig.vim', { 'for': ['zig'] }


call plug#end()


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Visual Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
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
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
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


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ JavaScript Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Haskell Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
let g:haskell_enable_quantification = 1
let g:haskell_enable_recursivedo = 1
let g:haskell_enable_arrowsyntax = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles = 1
let g:haskell_enable_static_pointers = 1
let g:haskell_backpack = 1


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ Keymap Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━
nnoremap <C-p> :Files <CR>
nmap <silent> <C-j> :bnext<CR>
nmap <silent> <A-j> :tabnext<CR>
nmap <silent> <C-k> :bprev<CR>
nmap <silent> <A-k> :tabprevious<CR>
noremap <C-\> :NERDTreeToggle<CR>


" ┏━━━━━━━━━━━━━━━━━━━━━━━
" ┃ LSP Settings
" ┗━━━━━━━━━━━━━━━━━━━━━━━

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <C-space> coc#refresh()
else
  inoremap <silent><expr> <C-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
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
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
nnoremap <silent><nowait> <space>h :<C-u>CocFzfList actions<cr>
nnoremap <silent><nowait> <space>a :<C-u>CocFzfList diagnostics<cr>
nnoremap <silent><nowait> <space>b :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent><nowait> <space>e :<C-u>CocFzfList extensions<cr>
nnoremap <silent><nowait> <space>c :<C-u>CocFzfList commands<cr>
nnoremap <silent><nowait> <space>l :<C-u>CocFzfList location<cr>
nnoremap <silent><nowait> <space>o :<C-u>CocFzfList outline<cr>
nnoremap <silent><nowait> <space>s :<C-u>CocFzfList symbols<cr>
nnoremap <silent><nowait> <space>y :<C-u>CocFzfList yank<cr>
nnoremap <silent><nowait> <space>j :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p :<C-u>CocFzfListResume<CR>

