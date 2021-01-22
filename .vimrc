set nocompatible              " be iMproved, required

" The pack/*/start stuff for vim 8 is not working for me on Mac CLI vim
" Thus I am installing using https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'                          " JavaScript support
Plug 'leafgarland/typescript-vim'                       " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'                         " JS and JSX syntax
Plug 'jparise/vim-graphql'                              " GraphQL syntax

Plug  'prettier/vim-prettier', { 'do': 'npm install' }  " Prettier

Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Completion
Plug 'mattn/emmet-vim'                                  " HTML Completion

call plug#end()

filetype plugin indent on

" Completion Setup
let g:user_emmet_leader_key=','
let g:coc_global_extensions = ['coc-solargraph', 'coc-tsserver', 'coc-json', 'coc-vetur']
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
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
"
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
"
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Basic Editor setup
source ~/.vim/config/autoclose.vim

let mapleader=","

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set wrap linebreak nolist
set relativenumber numberwidth=4 ruler
set ignorecase smartcase
set laststatus=2

syntax on
colorscheme desert

if has("gui_running")
  set vb t_vb=
  set lines=50 columns=125
else
  if exists("+columns") && &columns < 125
    set columns=125
  endif
endif
