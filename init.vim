" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" General
Plug 'tpope/vim-sensible'
Plug 'w0rp/ale'
Plug 'rhysd/devdocs.vim'
Plug 'ton/vim-bufsurf'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator' 
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'editorconfig/editorconfig-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
" Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug '~/.fzf'
" Plug '/usr/share/doc/fzf/examples/plugin/fzf.vim' 
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'maksimr/vim-jsbeautify'

" Syntax
Plug 'stephpy/vim-yaml'
Plug 'chemzqm/vim-jsx-improve'
Plug 'pangloss/vim-javascript'
Plug '2072/PHP-Indenting-for-Vim'
Plug 'StanAngeloff/php.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'Shougo/deoplete-clangx'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'hashivim/vim-terraform'

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" Color Schemes
Plug 'robertmeta/nofrils'
Plug 'wolverian/minimal'
Plug 'elmindreda/vimcolors'
Plug 'MidnaPeach/neonwave.vim'
Plug 'dgraham/xcode-low-key-vim'
Plug 'vim-scripts/mayansmoke'
Plug 'andreypopp/vim-colors-plain'
Plug 'Lokaltog/vim-monotone'
Plug 'logico-dev/typewriter'
Plug 'NLKNguyen/papercolor-theme'
Plug 'aunsira/macvim-light'
Plug 'chriskempson/base16-vim'

" Initialize plugin system
call plug#end()

let mapleader = "\<Space>"
imap jk <Esc>
imap kj <Esc>
nnoremap <Leader>w :w<CR>

" TYPO FIX
map q: :q

" Copy file path
nmap cp :let @" = expand("%")<CR>

set tm=900
set smartindent
set nu
set guioptions=
set mouse=a
set nowrap
set number
set relativenumber
set hidden
set backupcopy=yes
set inccommand=nosplit
set termguicolors

" Nofril
" let g:nofrils_heavylinenumbers=1
" let g:nofrils_strbackgrounds=1

syntax enable
if &diff
  set background=light
  colorscheme xcode-low-key
else
  " colorscheme base16-3024
  " set background=dark
  colorscheme PaperColor
  set background=light
endif
hi Search guibg=yellow guifg=black
hi Search cterm=NONE ctermfg=black ctermbg=yellow

" ----------- AUTOCOMPLETION ----------- "
imap <C-o> <C-x><C-o>  

" ----------- BUFFERS ----------- "
nmap <Leader>l :BufSurfForward<cr>
nmap <Leader>h :BufSurfBack<cr>

nmap <Leader>b :Buffers<cr>

" ---------- CUSTOM DIC --------- "
set dictionary+=~/.config/nvim/words

" ----------- FILE TYPES ------- "
au BufNewFile,BufRead *.ejs set filetype=javascript

au FileType php setl sw=4 ts=4
au FileType javascript setl sw=2 ts=2 et
au FileType json setl sw=2 ts=2 et
" au FileType javascript setl sw=4 ts=4
au FileType json setl sw=2 ts=2 et
let php_sql_query = 0
let php_sql_heredoc = 0
let php_sql_nowdoc = 0
let g:vim_markdown_folding_disabled = 1
let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1
let g:svelte_indent_script = 0

let g:ale_c_cc_executable = 'gcc' " Or use 'clang'
let g:ale_c_cc_options = '-std=c11 -Wall `pkg-config --cflags gtk+-3.0`'

" call deoplete#custom#var('clangx', 'default_c_options', '`pkg-config --cflags gtk+-3.0`')

" ----------- SEARCH ----------- "
" set wildignore=**/node_modules/*,**/vendor/*
nmap <Leader>s :grep -r --ignore composer.phar --ignore composer.lock --ignore-dir node_modules --ignore-dir vendor --ignore-dir php-app/fc/cdn_js/out  --vimgrep --ignore tags "" ./<left><left><left><left>
nmap <Leader>c :botright copen<cr>
set hlsearch
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ----------- LANG SERVER ----------- "
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <Leader>d :call LanguageClient#textDocument_definition()<CR>

let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" ----------- Vim Go ------------ "
set completeopt=menu
let g:go_fmt_fail_silently = 0
nmap <Leader>t :GoTest<CR>

" ----------- DEVDOCS ----------- "
nmap <Leader>k <Plug>(devdocs-under-cursor)

" ----------- NERDCommenter ----------- "
let g:NERDSpaceDelims = 1
let g:NERDTreeHijackNetrw=1
map <Leader>/ <Leader>c<Leader>
map <c-/> <Leader>c<Leader>

" ----------- NETRW ----------- "
let g:netrw_banner = 1
nnoremap - - " Override vim-vinegar map
nmap _ <Plug>VinegarUp

nmap <C-p> :FZF<cr>

" ------------- ALE ------------ "
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin indent on

let g:ale_php_phan_use_client = 1
let g:ale_linters = {'php': ['php', 'phan'], 'go': ['golint']}
let g:ale_fixers = {
      \   'javascript': [
      \       'eslint'
      \   ],
      \   'php': [
      \       'php_cs_fixer'
      \   ],
      \   'go': [
      \       'gofmt'
      \   ]
      \}
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 500
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '%linter% says %s'
let g:ale_php_phpcs_standard = "./fc-standard.xml"

nnoremap gan :ALENextWrap<cr>
nnoremap gap :ALEPreviousWrap<cr>
nmap gq :ALEFix<CR>

" ------------- LANGSERVER ------------ "
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['node', '/home/brandon/sources/javascript-typescript-langserver/lib/language-server-stdio.js']
    \ }
" \ 'php': ['phan', '--daemonize-tcp-port',  'default']
let g:LanguageClient_windowLogMessageLevel = "Error"
let g:LanguageClient_diagnosticsEnable = 0

" ------------- EDITOR CONFIG ------------ "
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ------------- SnipMate ------------- "
let g:snipMate = { 'snippet_version' : 1 }

" ------------- FUNCTIONS ------------ "
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
      \}
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 500
" let g:ale_javascript_eslint_options = '-c ../.eslintrc'
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '%linter% says %s'
let g:ale_php_phpcs_standard = "./fc-standard.xml"

nnoremap gan :ALENextWrap<cr>
nnoremap gap :ALEPreviousWrap<cr>
nmap gq :ALEFix<CR>

" ------------- LANGSERVER ------------ "
let g:LanguageClient_serverCommands = {
    \ 'javascript': ['node', '/home/brandon/sources/javascript-typescript-langserver/lib/language-server-stdio.js']
    \ }
" \ 'php': ['phan', '--daemonize-tcp-port',  'default']
let g:LanguageClient_windowLogMessageLevel = "Error"
let g:LanguageClient_diagnosticsEnable = 0

" ------------- EDITOR CONFIG ------------ "
let g:EditorConfig_exclude_patterns = ['fugitive://.*']


" ------------- FUNCTIONS ------------ "
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction

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
nmap <Leader>r :%s //g<left><left>

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

" Makes it easier to deal with JS in PHP
function! JSPHP()
  set filetype=javascript
  set syntax=javascript
  set shiftwidth=4
  set noexpandtab
  set tabstop=4
  ALEDisable
endfunction

function! LightMode()
  colorscheme PaperColor
  set background=light
endfunction

function! DarkMode()
  colorscheme base16-3024
  set background=dark
endfunction


" ------------- PROJECTS ------------ "
