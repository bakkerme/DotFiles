" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'mxw/vim-jsx'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ap/vim-buftabline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'w0rp/ale'
Plug 'valloric/YouCompleteMe'
Plug 'rhysd/devdocs.vim'
Plug 'ton/vim-bufsurf'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator' 

"Clojure dev
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'

" Initialize plugin system
call plug#end()

let mapleader = "\<Space>"
imap jk <Esc>
imap kj <Esc>
nmap gq :ALEFix<CR>
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
set smartindent

" Buffer Switching
nmap <Leader>l :BufSurfForward<cr>
nmap <Leader>h :BufSurfBack<cr>
nnoremap <Leader>b :b

" Paste
map <Leader>/ <Leader>c<Leader>

" DEVDOCS
nmap K <Plug>(devdocs-under-cursor)

nnoremap <Leader>w :w<CR>
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" TYPO FIX
map q: :q

" Copy file path
nmap cp :let @" = expand("%")<CR>

" NERDCommenter
let g:NERDSpaceDelims = 1

syntax enable
set background=dark
colorscheme solarized

set guifont=Input\ Mono\ Light\ 10
if has("gui_macvim")
  set guifont=InputMono\ Light:h13
endif

set linespace=3
set tabstop=2
set shiftwidth=2
set expandtab
set number
set relativenumber
set hidden

let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 0

" buftaline
let g:buftabline_numbers = 1

" lightline
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ }

" Auto Pairs
let g:AutoPairsFlyMode = 1
let g:AutoPairsShortcutBackInsert = '<M-b>'

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
  \       'eslint',
  \   ],
  \}

" if has("autocmd")
  " au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
  " au InsertEnter,InsertChange *
    " \ if v:insertmode == 'i' | 
    " \   silent execute '!echo -ne "\e[5 q"' | redraw! |
    " \ elseif v:insertmode == 'r' |
    " \   silent execute '!echo -ne "\e[3 q"' | redraw! |
    " \ endif
  " au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif
