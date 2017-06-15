" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'mxw/vim-jsx'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'valloric/YouCompleteMe'
Plug 'ap/vim-buftabline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'w0rp/ale'
Plug 'rhysd/devdocs.vim'
Plug 'ton/vim-bufsurf'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()

let mapleader = "\<Space>"
imap jk <Esc>
imap kj <Esc>
nmap gq :ALEFix<CR>
set tm=600
set relativenumber
set smartindent
set nu

" Buffer Switching
nmap <Leader>l :BufSurfForward<cr>
nmap <Leader>h :BufSurfBack<cr>
nnoremap <Leader>b :b

" SYNTASTIC
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" DEVDOCS
nmap K <Plug>(devdocs-under-cursor)
let g:devdocs_filetype_map = {
  \   'javascript.jsx': 'react',
  \ }

nnoremap <Leader>w :w<CR>
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" TYPO FIX
map q: :q

" NERDCommenter
let g:NERDSpaceDelims = 1

syntax enable
set background=dark
colorscheme solarized
set guifont=InputMono\ Light:h14
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
filetype plugin on 

let g:ale_fixers = {
  \   'javascript': [
  \       'eslint',
  \   ],
  \}

