" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

" General
Plug 'tpope/vim-sensible'
Plug 'chemzqm/vim-jsx-improve'
Plug 'w0rp/ale'
Plug 'rhysd/devdocs.vim'
Plug 'ton/vim-bufsurf'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator' 
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'
Plug 'terryma/vim-smooth-scroll'
Plug 'editorconfig/editorconfig-vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'roxma/LanguageServer-php-neovim',  {'do': 'composer install && composer run-script parse-stubs'}
" Plug 'kana/vim-smartinput'
" Plug 'vim-scripts/AutoClose'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-vdebug/vdebug'

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

"PHP
Plug '2072/PHP-Indenting-for-Vim'
Plug 'StanAngeloff/php.vim'

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

" Nofril
" let g:nofrils_heavylinenumbers=1
" let g:nofrils_strbackgrounds=1

syntax enable
if &diff
  set background=light
  colorscheme xcode-low-key
else
  set background=light
  colorscheme mayansmoke
endif
hi Search guibg=yellow guifg=black
hi Search cterm=NONE ctermfg=black ctermbg=yellow


" ----------- BUFFERS ----------- "
nmap <Leader>l :BufSurfForward<cr>
nmap <Leader>h :BufSurfBack<cr>

nmap <Leader>b :Buffers<cr>

" ----------- FILE TYPES ------- "
au BufNewFile,BufRead *.ejs set filetype=javascript
au FileType php setl sw=4 ts=4
" au FileType javascript setl sw=2 ts=2 et
" au FileType javascript setl sw=4 sts=4
let php_sql_query = 0
let php_sql_heredoc = 0
let php_sql_nowdoc = 0
let g:vim_markdown_folding_disabled = 1
let g:jsx_ext_required = 0
let g:javascript_plugin_jsdoc = 1

" ----------- SEARCH ----------- "
" set wildignore=**/node_modules/*,**/vendor/*
nmap <Leader>s :grep -r --ignore composer.phar --ignore-dir node_modules --ignore-dir vendor --ignore-dir php-app/fc/cdn_js/out  --vimgrep --ignore tags "" ./<left><left><left><left>
nmap <Leader>c :copen<cr>
set hlsearch
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ----------- VDEBUG ----------- "
let g:vdebug_options= {
    \    "port" : 8000,
    \    "server" : '',
    \    "timeout" : 20,
    \    "on_close" : 'detach',
    \    "ide_key" : '',
    \    "debug_window_level" : 0,
    \    "debug_file_level" : 0,
    \    "debug_file" : "",
    \    "watch_window_style" : 'expanded',
    \    "marker_default" : '⬦',
    \    "marker_closed_tree" : '▸',
    \    "marker_open_tree" : '▾',
    \    "path_maps":  {"/var/www/html/": "/home/brandon/sources/funcaptcha-eb/php-app/"},
    \    "break_on_open": 0
    \}

" ----------- LANG SERVER ----------- "
" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ----------- DEVDOCS ----------- "
nmap <Leader>k <Plug>(devdocs-under-cursor)

" ----------- NERDCommenter ----------- "
let g:NERDSpaceDelims = 1
let g:NERDTreeHijackNetrw=1
map <Leader>/ <Leader>c<Leader>

" ----------- NETRW ----------- "
let g:netrw_banner = 1
" let g:netrw_liststyle=2

" ------------- SMOOTH SCROLLING ------------ "
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 8)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 8)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 6)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 6)<CR>
"
" ------------- FZF ------------ "
nmap <C-p> :Files<cr>
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

" ------------- ALE ------------ "
filetype off
let &runtimepath.=',~/.vim/bundle/ale'
filetype plugin indent on

let g:ale_php_phan_use_client = 1
let g:ale_linters = {'php': ['php', 'phan']}
let g:ale_fixers = {
      \   'javascript': [
      \       'eslint'
      \   ],
      \   'php': [
      \       'php_cs_fixer'
      \   ]
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
    \ 'javascript': ['javascript-typescript'],
    \ }
" 'php': ['phan --daemonize-tcp-port default']
"
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
  execute("vertical resize " . (strlen(getline(".")) + 25))
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
endfunction


" ------------- PROJECTS ------------ "
autocmd BufNewFile,BufRead /home/brandon/sources/funcaptcha/* set nowrap tabstop=2 shiftwidth=2 expandtab
autocmd BufNewFile,BufRead /home/brandon/sources/funcaptcha-eb/* set nowrap tabstop=4 shiftwidth=4 noexpandtab
