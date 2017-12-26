" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'chemzqm/vim-jsx-improve'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
" Plug 'ervandew/supertab'
Plug 'rhysd/devdocs.vim'
Plug 'ton/vim-bufsurf'
Plug 'scrooloose/nerdcommenter'
" Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator' 
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
" Plug 'jeetsukumaran/vim-buffergator'
Plug 'flowtype/vim-flow'
Plug 'takac/vim-hardtime'
Plug 'terryma/vim-smooth-scroll'

Plug 'jaxbot/semantic-highlight.vim'
" Plug 'bigfish/vim-js-context-coloring'

" Color Schemes
Plug 'altercation/vim-colors-solarized'
Plug 'robertmeta/nofrils'
Plug 'https://bitbucket.org/kisom/eink.vim.git'
Plug 'xero/blaquemagick.vim'
Plug 'beigebrucewayne/skull-vim'
Plug 'wolverian/minimal'
Plug 'elmindreda/vimcolors'
Plug 'MidnaPeach/neonwave.vim'
Plug 'vim-scripts/ibmedit.vim'
Plug 'vim-scripts/Shades-of-Amber'
Plug 'dgraham/xcode-low-key-vim'

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
set go-=egLb "everything else
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
" set synmaxcol=120

set guifont=Input\ Mono\ Light\ 10
if has("gui_macvim")
  set guifont=InputMono\ Light:h14
endif

" Nofril
let g:nofrils_heavylinenumbers=1
let g:nofrils_strbackgrounds=1

syntax enable
set background=light
colorscheme xcode-low-key
" highlight Cursor guifg=white guibg=black
" hi Search guibg=black guifg=yellow
hi Search guibg=yellow guifg=black
hi Search cterm=NONE ctermfg=black ctermbg=yellow

" ----------- BUFFERS ----------- "
nmap <Leader>l :BufSurfForward<cr>
nmap <Leader>h :BufSurfBack<cr>

if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
  map <c-n> <c-w>5<
  map <c-m> <c-w>5>
endif


nmap <Leader>b :ls<cr> :b<space>

" ----------- HARDTIME ----------- "
let g:hardtime_default_on = 0
let g:hardtime_allow_different_key = 1


" ----------- SEARCH ----------- "
set wildignore+=**/node_modules/*
nmap <Leader>s :grep -r --ignore-dir node_modules --ignore tags "" ./
" nmap <c-p> : e **/
set hlsearch

" ---------- FLOW ---------- "
" Vim Flow
let g:flow#enable = 0

"Use locally installed flow
" let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
let local_flow = finddir('node_modules', '../') . '/.bin/flow'
" if matchstr(local_flow, "^\/\\w") == ''
    " let local_flow= getcwd() . "/" . local_flow
" endif
if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

" DEVDOCS
nmap K <Plug>(devdocs-under-cursor)

" NERDCommenter
let g:NERDSpaceDelims = 1
map <Leader>/ <Leader>c<Leader>

" ------------- Smooth Scrolling ------------
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 16)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 16)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 16)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 16)<CR>

let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_path_nolim = 1
let g:ctrlp_working_path_mode = 0
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

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

function! HlIndent()
  let currLine = getline('.')
  let matchs = matchstrpos(currLine, '^\(\s\+\)')
  let regex = '^\s\{' . matchs[2] . '}'
  execute 'normal! /' . regex . '<CR>'
endfunction

function! FlowGen()
 execute("!./node_modules/.bin/flow gen-flow-files % > %:p:h/../lib/%:t.flow 2> flowlog.txt")
endfunction
