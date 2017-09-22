" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'altercation/vim-colors-solarized'
Plug 'chemzqm/vim-jsx-improve'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'ap/vim-buftabline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
" Plug 'valloric/YouCompleteMe'
Plug 'ervandew/supertab'
Plug 'rhysd/devdocs.vim'
Plug 'ton/vim-bufsurf'
Plug 'scrooloose/nerdcommenter'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator' 
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'flowtype/vim-flow'
Plug 'robertmeta/nofrils'

"Clojure dev
Plug 'tpope/vim-fireplace'
Plug 'guns/vim-clojure-static'

" Nofrils
let g:nofrils_heavylinenumbers=1
let g:nofrils_strbackgrounds=1

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
" set guioptions-=e  "Tabline
set mouse=a
set ttyfast
set lazyredraw
set nowrap

" Indetntation
inoremap <CR> <CR>x<BS>
nnoremap o ox<BS>
nnoremap O Ox<BS>

" Buffer Switching
nmap <Leader>l :BufSurfForward<cr>
nmap <Leader>h :BufSurfBack<cr>
" nnoremap <Leader>b :b

let g:buffergator_autoexpand_on_split = 0
let g:buffergator_autoupdate = 1
let g:buffergator_autodismiss_on_select = 0
let g:buffergator_show_full_directory_path = 0
" let g:buffergator_viewport_split_policy = "l"
let g:buffergator_vsplit_size = 30

" Vim Workspace
let g:workspace_powerline_separators = 1

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
" colorscheme solarized
colorscheme nofrils-dark 

set guifont=Input\ Mono\ Light\ 10
if has("gui_macvim")
  set guifont=InputMono\ Light:h14
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

" YouCompleteMe
let g:ycm_filepath_completion_use_working_dir = 1

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabCompletionContexts =  ['flowcomplete#Complete'] + g:SuperTabCompletionContexts

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

" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \ }
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

set smartindent
