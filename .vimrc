" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'chemzqm/vim-jsx-improve'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
" Plug 'ervandew/supertab'
Plug 'rhysd/devdocs.vim'
Plug 'ton/vim-bufsurf'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator' 
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Plug 'jeetsukumaran/vim-buffergator'
Plug 'flowtype/vim-flow'

Plug 'altercation/vim-colors-solarized'
Plug 'robertmeta/nofrils'
Plug 'https://bitbucket.org/kisom/eink.vim.git'
Plug 'xero/blaquemagick.vim'
Plug 'beigebrucewayne/skull-vim'

"Clojure dev
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
 
" Initialize plugin system
call plug#end()

let mapleader = "\<Space>"
imap jk <Esc>
imap kj <Esc>
nmap gq :ALEFix<CR>
nnoremap <Leader>w :w<CR>
 
" TYPO FIX
map q: :q

" Copy file path
nmap cp :let @" = expand("%")<CR>

set tm=900
set relativenumber
set smartindent
set nu
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar
set mouse=a
set ttyfast
set lazyredraw
set nowrap
set linespace=3
set tabstop=2
set shiftwidth=2
set expandtab
set number
set relativenumber
set hidden
set synmaxcol=120

set guifont=Input\ Mono\ Light\ 10
if has("gui_macvim")
  set guifont=InputMono\ Light:h14
endif

" Nofril
let g:nofrils_heavylinenumbers=1
let g:nofrils_strbackgrounds=1

syntax enable
set background=light
colorscheme eink
highlight Cursor guifg=black guibg=white
" colorscheme nofrils-dark 
" colorscheme blaquemagick

" ----------- BUFFERS ----------- "
nmap <Leader>l :BufSurfForward<cr>
nmap <Leader>h :BufSurfBack<cr>

if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
  map <c-n> <c-w>5<
  map <c-m> <c-w>5>
endif


nmap <Leader>b :ls<cr> :b


" ----------- SEARCH ----------- "
set wildignore+=**/node_modules/*
nmap <Leader>s :grep -r --exclude-dir node_modules --exclude tags "" ./
nmap <c-p> :e **/
set hlsearch

" ---------- FLOW ---------- "
" Vim Flow
let g:flow#enable = 0

"Use locally installed flow
" let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
let local_flow = finddir('node_modules', '../') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
    let local_flow= getcwd() . "/" . local_flow
endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

" DEVDOCS
nmap K <Plug>(devdocs-under-cursor)

" NERDCommenter
let g:NERDSpaceDelims = 1
map <Leader>/ <Leader>c<Leader>

let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1

" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 0

" buftaline
let g:buftabline_numbers = 1

" lightline
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'active': {
  \   'left': [ [ 'filename' ],
  \             [ 'gitbranch' ] ],
  \   'right': [ [ 'percent', 'lineinfo' ],
  \              [ 'fileencoding', 'filetype' ] ]
  \ },
  \ 'separator': { 'left': '▓▒░', 'right': '░▒▓' },
  \ 'subseparator': { 'left': '▒', 'right': '░' }
\ }

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" ALE
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin indent on

let g:ale_fixers = {
  \   'javascript': [
  \       'eslint'
  \   ]
  \}
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 1500
" let g:ale_javascript_eslint_options = '-c ../.eslintrc'
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '%linter% says %s'
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>


" Hack fix enter being bound wrong
nnoremap <cr> <cr>
