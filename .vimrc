set nocompatible              " be iMproved, required

" The pack/*/start stuff for vim 8 is not working for me on Mac CLI vim
" Thus I am installing using https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'                          " JavaScript support
Plug 'leafgarland/typescript-vim'                       " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'                         " JS and JSX syntax
Plug 'jparise/vim-graphql'                              " GraphQL syntax

Plug  'prettier/vim-prettier', { 'do': 'npm install' } " Prettier

Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Compleition

call plug#end()

filetype plugin indent on

" Completion Setup
let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json']
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

hi CocErrorFloat ctermbg=White ctermfg=Black

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Basic Editor setup
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set wrap linebreak nolist
set number numberwidth=4 ruler
set ignorecase smartcase
set laststatus=2

