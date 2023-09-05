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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'github/copilot.vim'
Plug 'tpope/vim-sleuth'
Plug 'romainl/vim-qf'

" Syntax
Plug 'neoclide/vim-jsx-improve'
Plug '2072/PHP-Indenting-for-Vim'
Plug 'StanAngeloff/php.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'dart-lang/dart-vim-plugin'
" Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'hashivim/vim-terraform'
" Plug 'hashivim/vim-packer'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'

" Snippets
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
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
Plug 'mcchrish/zenbones.nvim'

" Initialize plugin system
call plug#end()

let mapleader = "\<Space>"
imap jk <Esc>
imap kj <Esc>
nnoremap <Leader>w :w<CR>
nnoremap <leader>= "+y

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
  colorscheme PaperColor
  set background=light
  " colorscheme neonwave
  " set background=dark
  " set notermguicolors
endif
hi Search guibg=yellow guifg=black
hi Search cterm=NONE ctermfg=black ctermbg=yellow

if executable('win32yank.exe')
  let g:clipboard = {
            \   'name': 'win32yank-wsl',
            \   'copy': {
            \      '+': 'win32yank.exe -i --crlf',
            \      '*': 'win32yank.exe -i --crlf',
            \    },
            \   'paste': {
            \      '+': 'win32yank.exe -o --lf',
            \      '*': 'win32yank.exe -o --lf',
            \   },
            \   'cache_enabled': 0,
            \ }
endif

" ----------- AUTOCOMPLETION ----------- "
inoremap <C-l> <C-x><C-o>  

" ----------- BUFFERS ----------- "
nmap <Leader>l :BufSurfForward<cr>
nmap <Leader>h :BufSurfBack<cr>

nmap <Leader>b :Buffers<cr>

" ---------- CUSTOM DIC --------- "
set dictionary+=~/.config/nvim/words

" ----------- FILE TYPES ------- "
au BufNewFile,BufRead *.ejs set filetype=javascript

au FileType yaml setl ts=2 sts=2 sw=2 et
au FileType php setl sw=4 ts=4
au FileType javascript setl sw=2 ts=2 et
au FileType json setl sw=2 ts=2 et
au BufNewFile,BufRead *.svelte set nowrap tabstop=2 shiftwidth=2 expandtab
au BufNewFile,BufRead *.ts set nowrap tabstop=2 shiftwidth=2 expandtab

let php_sql_query = 0
let php_sql_heredoc = 0
let php_sql_nowdoc = 0
let g:vim_markdown_folding_disabled = 1
let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1
let g:dart_style_guide = 2
let g:dart_format_on_save = 1

" ----------- SNIPPETS --------- "
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" ----------- SEARCH ----------- "
" set wildignore=**/node_modules/*,**/vendor/*
nmap <Leader>s :grep -r --hidden --ignore composer.phar --ignore composer.lock --ignore-dir node_modules --ignore-dir vendor --ignore-dir php-app/fc/cdn_js/out  --vimgrep --ignore tags "" ./<left><left><left><left>
nmap <Leader>c :botright copen<cr>
set hlsearch
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

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
let g:netrw_banner = 0
nnoremap - - " Override vim-vinegar map
nmap _ <Plug>VinegarUp

nmap <C-p> :GFiles<cr>

" ------------- ALE ------------ "
let g:ale_completion_enabled = 1
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin indent on

let g:ale_c_cc_executable = 'gcc' " Or use 'clang'
let g:ale_c_cc_options = '-std=c11 -Wall `pkg-config --cflags gtk+-3.0`'

let g:ale_php_phan_use_client = 1
let g:ale_linters = {'php': ['php', 'phan'], 'dart': ['dartanalyzer', 'analysis_server'], 'go': ['golint', 'govet', 'gopls']}
au BufRead,BufNewFile **/.github/workflows/*.yml let b:ale_linters = {'yaml': ['actionlint', 'yamllint'] }
let g:ale_fixers = {
      \   'javascript': [
      \       'eslint'
      \   ],
      \   'typescript': [
      \       'eslint'
      \   ],
      \   'dart': [
      \       'dartfmt'
      \   ],
      \   'php': [
      \       'php_cs_fixer'
      \   ],
      \   'go': [
      \       'gofmt',
      \	      'go vet'
      \   ]
      \}
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_delay = 500
let g:ale_statusline_format = ['X %d', '? %d', '']
let g:ale_echo_msg_format = '%linter% rule %code% says %s'
let g:ale_php_phpcs_standard = "./fc-standard.xml"

call ale#linter#Define('javascript', {
  \   'name': 'javascript-typescript-langserver',
  \   'lsp': 'stdio',
  \   'executable': 'node',
  \   'command': '%e /home/brandon/sources/javascript-typescript-langserver/lib/language-server-stdio.js',
  \   'project_root': './',
  \  })

nnoremap gan :ALENextWrap<cr>
nnoremap gap :ALEPreviousWrap<cr>
nmap gq :ALEFix<CR>

function! SmartInsertCompletion() abort
  " Use the default CTRL-N in completion menus
  if pumvisible()
    return "\<C-n>"
  endif

  " Exit and re-enter insert mode, and use insert completion
  return "\<C-c>a\<C-n>"
endfunction

inoremap <silent> <C-n> <C-R>=SmartInsertCompletion()<CR>

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

nnoremap <silent> gd  :ALEGoToDefinition<CR>
nnoremap <silent> gh  :ALEHover<CR>
nnoremap <silent> gq  :ALEFix<CR>
nnoremap <silent> gan :ALENextWrap<cr>
nnoremap <silent> gap :ALEPreviousWrap<cr>

" ------------- LANGSERVER ------------ "
" let g:LanguageClient_serverCommands = {
    " \ 'javascript': ['node', '/home/brandon/sources/javascript-typescript-langserver/lib/language-server-stdio.js'],
    " \ }
" " \ 'php': ['phan', '--daemonize-tcp-port',  'default']
" "    \ 'dart': ['dart', '/home/brandon/snap/flutter/common/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot', '--lsp']
" let g:LanguageClient_windowLogMessageLevel = "Error"
" let g:LanguageClient_diagnosticsEnable = 0

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
  execute("vertical resize " . (strwidth(getline(".")) + 10))
endfunction

nmap gl :call LineWidth()<cr>
nmap <Leader>r :%s //g<left><left>
nmap <Leader>y "ay
nmap <Leader>p "ap

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
  " set notermguicolors
  " colorscheme neonwave
  let g:zenbones_compat=1
  colorscheme PaperColor
  set background=dark
endfunction

" call DarkMode()
