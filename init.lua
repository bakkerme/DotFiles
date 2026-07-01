-- ----------- LAZY.NVIM BOOTSTRAP ----------- --
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    -- General
    { 'tpope/vim-sensible' },
    { 'rhysd/devdocs.vim' },
    { 'ton/vim-bufsurf' },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'christoomey/vim-tmux-navigator' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-rhubarb' },
    { 'tpope/vim-surround' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-vinegar' },
    { 'editorconfig/editorconfig-vim' },
    { 'junegunn/fzf', build = function() vim.fn['fzf#install']() end },
    { 'junegunn/fzf.vim' },
    { 'maksimr/vim-jsbeautify' },
    { 'tpope/vim-sleuth' },
    { 'romainl/vim-qf' },

    -- Syntax
    { 'neoclide/vim-jsx-improve' },
    { '2072/PHP-Indenting-for-Vim', ft = 'php' },
    { 'StanAngeloff/php.vim', ft = 'php' },
    { 'dart-lang/dart-vim-plugin', ft = 'dart' },
    { 'hashivim/vim-terraform', ft = 'terraform' },
    { 'HerringtonDarkholme/yats.vim', ft = { 'typescript', 'typescriptreact' } },
    { 'leafgarland/typescript-vim', ft = { 'typescript', 'typescriptreact' } },

    -- LSP
    {
      "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },

    -- Golang
    { 'nvim-treesitter/nvim-treesitter' },
    { 'neovim/nvim-lspconfig' },
    { 'ray-x/guihua.lua', build = 'cd lua/fzy && make' },
    {
      'ray-x/go.nvim',
      ft = 'go',
      dependencies = { 'ray-x/guihua.lua' },
      config = function()
        require('go').setup()
      end,
    },

    -- Snippets
    { 'Shougo/neosnippet.vim' },
    { 'Shougo/neosnippet-snippets' },
    { 'honza/vim-snippets' },

    -- Color Schemes
    { 'MidnaPeach/neonwave.vim' },
    { 'NLKNguyen/papercolor-theme' },
  },
})

-- ----------- KEYMAPS ----------- --
vim.g.mapleader = ' '

local map = vim.keymap.set

map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
map('n', '<Leader>w', ':w<CR>')
map('v', '<Leader>=', '"+y')
map('n', '<Leader>p', '"+p')

map('n', '<Leader>r', ':%s //g<Left><Left>')

-- TYPO FIX
map('', 'q:', ':q')

-- Copy file path
map('n', 'cp', function()
  vim.fn.setreg('"', vim.fn.expand('%'))
end)

-- ----------- OPTIONS ----------- --
vim.opt.timeoutlen = 900
vim.opt.smartindent = true
vim.opt.guioptions = ''
vim.opt.mouse = 'a'
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.backupcopy = 'yes'
vim.opt.inccommand = 'nosplit'
vim.opt.termguicolors = true
vim.opt.hlsearch = true
vim.opt.dictionary:append('~/.config/nvim/words')

vim.api.nvim_set_hl(0, 'MatchParen', {})

-- ----------- COLORSCHEME ----------- --
if vim.o.diff then
  vim.opt.background = 'light'
  vim.cmd.colorscheme('xcode-low-key')
else
  vim.cmd.colorscheme('PaperColor')
  vim.opt.background = 'light'
  -- vim.cmd.colorscheme('neonwave')
  -- vim.opt.background = 'dark'
  -- vim.opt.termguicolors = false
end

vim.api.nvim_set_hl(0, 'Search', { bg = 'yellow', fg = 'black' })

if vim.fn.executable('win32yank.exe') == 1 then
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end

-- ----------- AUTOCOMPLETION ----------- --
map('i', '<C-l>', '<C-x><C-o>')

-- ----------- BUFFERS ----------- --
map('n', '<Leader>l', ':BufSurfForward<CR>')
map('n', '<Leader>h', ':BufSurfBack<CR>')
map('n', '<Leader>b', ':Buffers<CR>')

-- ----------- FILE TYPES ----------- --
local augroup = vim.api.nvim_create_augroup('DotfilesFileTypes', {})

vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup,
  pattern = '*.ejs',
  command = 'set filetype=javascript',
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup,
  pattern = { '.envrc', '.envrc.local' },
  command = 'set filetype=sh',
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'yaml',
  command = 'setlocal ts=2 sts=2 sw=2 et',
})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'php',
  command = 'setlocal sw=4 ts=4',
})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'javascript',
  command = 'setlocal sw=2 ts=2 et',
})
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'json',
  command = 'setlocal sw=2 ts=2 et',
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup,
  pattern = '*.svelte',
  command = 'set nowrap tabstop=2 shiftwidth=2 expandtab',
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  group = augroup,
  pattern = '*.ts',
  command = 'set nowrap tabstop=2 shiftwidth=2 expandtab',
})

vim.g.php_sql_query = 0
vim.g.php_sql_heredoc = 0
vim.g.php_sql_nowdoc = 0
vim.g.vim_markdown_folding_disabled = 1
vim.g.jsx_ext_required = 0
vim.g.javascript_plugin_jsdoc = 1
vim.g.dart_style_guide = 2
vim.g.dart_format_on_save = 1

-- ----------- SNIPPETS ----------- --
map('i', '<C-k>', '<Plug>(neosnippet_expand_or_jump)')
vim.g['neosnippet#enable_snipmate_compatibility'] = 1
vim.g['neosnippet#snippets_directory'] = '~/.vim/plugged/vim-snippets/snippets'

-- ----------- SEARCH ----------- --
map('n', '<Leader>s', ':grep -r --hidden --ignore composer.phar --ignore composer.lock --ignore-dir node_modules --ignore-dir vendor --ignore-dir php-app/fc/cdn_js/out --ignore-dir .git  --vimgrep --ignore tags "" ./<Left><Left><Left><Left>')
map('n', '<Leader>c', ':botright copen<CR>')

if vim.fn.executable('ag') == 1 then
  vim.opt.grepprg = 'ag --nogroup --nocolor'
end

-- ----------- Go NVIM ----------- --
local format_sync_grp = vim.api.nvim_create_augroup('GoFormat', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})

map('n', '<Leader>t', ':GoTest<CR>')

-- ----------- DEVDOCS ----------- --
map('n', '<Leader>k', '<Plug>(devdocs-under-cursor)')

-- ----------- COMMENTING ----------- --
map('n', '<Leader>/', '<Plug>(comment_toggle_linewise_current)')
map('x', '<Leader>/', '<Plug>(comment_toggle_linewise_visual)')
map('n', '<C-/>', '<Plug>(comment_toggle_linewise_current)')
map('x', '<C-/>', '<Plug>(comment_toggle_linewise_visual)')

-- ----------- NETRW ----------- --
vim.g.netrw_banner = 0
map('n', '-', '-') -- Override vim-vinegar map
map('n', '_', '<Plug>VinegarUp')

map('n', '<C-p>', ':GFiles<CR>')

-- ------------- LSP ------------ --
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    map('n', 'gd', vim.lsp.buf.definition, opts)
    map('n', 'gh', vim.lsp.buf.hover, opts)
    map('n', 'gr', vim.lsp.buf.references, opts)
    map('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    map('n', 'gq', function() vim.lsp.buf.format({ async = true }) end, opts)
  end,
})

map('n', 'gan', function() vim.diagnostic.jump({ count = 1, float = true }) end, { silent = true })
map('n', 'gap', function() vim.diagnostic.jump({ count = -1, float = true }) end, { silent = true })

local lsp_format_grp = vim.api.nvim_create_augroup('LspFormat', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
  group = lsp_format_grp,
})

_G.SmartInsertCompletion = function()
  -- Use the default CTRL-N in completion menus
  if vim.fn.pumvisible() == 1 then
    return '\14' -- <C-n>
  end
  -- Exit and re-enter insert mode, and use insert completion
  return '\3a\14' -- <C-c>a<C-n>
end

map('i', '<C-n>', 'v:lua.SmartInsertCompletion()', { expr = true, silent = true })

-- ------------- EDITOR CONFIG ------------ --
vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }

-- ------------- SnipMate ------------- --
vim.g.snipMate = { snippet_version = 1 }

-- ------------- FUNCTIONS ------------ --
-- vp doesn't replace paste buffer
local restore_reg
_G.RestoreRegister = function()
  vim.fn.setreg('"', restore_reg)
  return ''
end

-- Hack fix enter being bound wrong
map('n', '<CR>', '<CR>')

_G.HlIndent = function()
  local curr_line = vim.fn.getline('.')
  local matchs = vim.fn.matchstrpos(curr_line, [[^\(\s\+\)]])
  local regex = [[^\s\{]] .. matchs[3] .. '}'
  vim.cmd('normal! /' .. regex .. '\r')
end

_G.LineWidth = function()
  vim.cmd('vertical resize ' .. (vim.fn.strwidth(vim.fn.getline('.')) + 10))
end

map('n', 'gl', LineWidth)

_G.Wipeout = function()
  -- list of *all* buffer numbers
  local buffers = vim.fn.range(1, vim.fn.bufnr('$'))

  -- what tab page are we in?
  local current_tab = vim.fn.tabpagenr()

  -- go through all tab pages
  for tab = 1, vim.fn.tabpagenr('$') do
    -- go through all windows
    for win = 1, vim.fn.winnr('$') do
      -- whatever buffer is in this window in this tab, remove it from
      -- buffers list
      local thisbuf = vim.fn.winbufnr(win)
      local idx = vim.fn.index(buffers, thisbuf)
      if idx ~= -1 then
        table.remove(buffers, idx + 1)
      end
    end
  end

  -- if there are any buffers left, delete them
  if #buffers > 0 then
    vim.cmd('bwipeout ' .. table.concat(buffers, ' '))
  end

  -- go back to our original tab page
  vim.cmd('tabnext ' .. current_tab)
end

-- Makes it easier to deal with JS in PHP
_G.JSPHP = function()
  vim.opt_local.filetype = 'javascript'
  vim.opt_local.syntax = 'javascript'
  vim.opt_local.shiftwidth = 4
  vim.opt_local.expandtab = false
  vim.opt_local.tabstop = 4
end

_G.LightMode = function()
  vim.cmd.colorscheme('PaperColor')
  vim.opt.background = 'light'
end

_G.DarkMode = function()
  vim.opt.termguicolors = false
  -- vim.cmd.colorscheme('neonwave')
  vim.g.zenbones_compat = 1
  vim.cmd.colorscheme('PaperColor')
  vim.opt.background = 'dark'
  vim.api.nvim_set_hl(0, 'MatchParen', {})
  vim.opt.cursorline = true
end

vim.api.nvim_create_user_command('Wipeout', Wipeout, {})
vim.api.nvim_create_user_command('JSPHP', JSPHP, {})
vim.api.nvim_create_user_command('LightMode', LightMode, {})
vim.api.nvim_create_user_command('DarkMode', DarkMode, {})

-- DarkMode()
