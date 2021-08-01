set nocompatible              " be iMproved, required

" The pack/*/start stuff for vim 8 is not working for me on Mac CLI vim
" Thus I am installing using https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'pangloss/vim-javascript'                          " JavaScript support
Plug 'leafgarland/typescript-vim'                       " TypeScript syntax
Plug 'posva/vim-vue'                                    " Vue syntax
Plug 'maxmellon/vim-jsx-pretty'                         " JS and JSX syntax
Plug 'jparise/vim-graphql'                              " GraphQL syntax
Plug 'kamykn/spelunker.vim'                             " Spell Check

Plug  'prettier/vim-prettier', { 'do': 'npm install' }  " Prettier

Plug 'neoclide/coc.nvim', {'branch': 'release'}         " Completion
Plug 'mattn/emmet-vim'                                  " HTML Completion

" Various extra color themes
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'tomasiser/vim-code-dark'
Plug 'KeitaNakamura/neodark.vim'

call plug#end()

filetype plugin indent on

" colorscheme spaceduck
colorscheme codedark

" Completion Setup
let g:user_emmet_leader_key=','
let g:coc_global_extensions = ['coc-lists', 'coc-solargraph', 'coc-tsserver', 'coc-json', 'coc-vetur']
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
  let g:prettier#autoformat = 1
  let g:prettier#autoformat_require_pragma = 0
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>i :CocCommand tsserver.organizeImports<cr>

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

set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set wrap linebreak nolist
set relativenumber numberwidth=4 ruler
set ignorecase smartcase
set laststatus=2

set nospell
" Option to disable word checking.
" Disable URI checking. (default: 0)
let g:spelunker_disable_uri_checking = 1

" Disable email-like words checking. (default: 0)
let g:spelunker_disable_email_checking = 1

" Disable account name checking, e.g. @foobar, foobar@. (default: 0)
" NOTE: Spell checking is also disabled for JAVA annotations.
let g:spelunker_disable_account_name_checking = 1

" Disable acronym checking. (default: 0)
let g:spelunker_disable_acronym_checking = 1

" Disable checking words in backtick/backquote. (default: 0)
let g:spelunker_disable_backquoted_checking = 1

" Disable default autogroup. (default: 0)
let g:spelunker_disable_auto_group = 1

" Create own custom autogroup to enable spelunker.vim for specific filetypes.
augroup spelunker
  autocmd!
  " Setting for g:spelunker_check_type = 1:
  autocmd BufWinEnter,BufWritePost *.vim,*.js,*.jsx,*.json,*.md,*.ts,*.tsx call spelunker#check()

  " Setting for g:spelunker_check_type = 2:
  autocmd CursorHold *.vim,*.js,*.jsx,*.json,*.md,*.ts,*.tsx call spelunker#check_displayed_words()
augroup END

" Override highlight group name of incorrectly spelled words. (default:
" 'SpelunkerSpellBad')
let g:spelunker_spell_bad_group = 'SpelunkerSpellBad'

" Override highlight group name of complex or compound words. (default:
" 'SpelunkerComplexOrCompoundWord')
let g:spelunker_complex_or_compound_word_group = 'SpelunkerComplexOrCompoundWord'

" Override highlight setting.
autocmd ColorScheme *
    \ highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e |
    \ highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

syntax on
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

if has("gui_running")
  set vb t_vb=
  set lines=50 columns=125
else
  if exists("+columns") && &columns < 125
    set columns=125
  endif
endif
