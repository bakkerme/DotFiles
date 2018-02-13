" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'chemzqm/vim-jsx-improve'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'rhysd/devdocs.vim'
Plug 'ton/vim-bufsurf'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator' 
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'flowtype/vim-flow'
Plug 'terryma/vim-smooth-scroll'
Plug 'jungomi/vim-mdnquery'

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'


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
set guioptions=
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
set backupcopy=yes
" set synmaxcol=120

if has("gui_macvim")
  set guifont=InputMono\ Light:h14
else
  set guifont=Input\ Mono\ Light\ 10
endif

" Nofril
let g:nofrils_heavylinenumbers=1
let g:nofrils_strbackgrounds=1

syntax enable
if &diff
  set background=light
  colorscheme xcode-low-key
else
  set background=dark
  colorscheme neonwave
endif
" highlight Cursor guifg=white guibg=black
" hi Search guibg=black guifg=yellow
hi Search guibg=yellow guifg=black
hi Search cterm=NONE ctermfg=black ctermbg=yellow


let g:vim_markdown_folding_disabled = 1

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
nmap <Leader>s :grep -r --ignore-dir node_modules --vimgrep --js --ignore tags "" ./<left><left><left><left>
set hlsearch

" ---------- FLOW ---------- "
" Vim Flow
let g:flow#enable = 0

"Use locally installed flow
let local_flow = finddir('node_modules', '../') . '/.bin/flow'
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
nnoremap gan :ALENextWrap<cr>
nnoremap gap :ALEPreviousWrap<cr>


" Hack fix enter being bound wrong
nnoremap <cr> <cr>

function! HlIndent()
  let currLine = getline('.')
  let matchs = matchstrpos(currLine, '^\(\s\+\)')
  let regex = '^\s\{' . matchs[2] . '}'
  execute 'normal! /' . regex . '<CR>'
endfunction

function! LineWidth()
  execute("vertical resize " . (strlen(getline(".")) + 10))
endfunction

nmap gl :call LineWidth()<cr>

function! FlowGen()
 execute("!glow gen-flow-files % > %:p:h/../lib/%:t.flow 2> flowlog.txt")
endfunction

function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction
