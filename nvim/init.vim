" Disable compatibility to old-time vi
set nocompatible
set encoding=UTF-8
" Enable syntax highlighting
syntax on
" Enable line numbers
set number

set guifont=JetBrainsMono\ Nerd\ Font\ Semi\ Bold\ Italic:h18
" Set tabs and indentation
set tabstop=4
set shiftwidth=4
set expandtab

" Enable mouse support
set mouse=a

" Set clipboard to use system clipboard
set clipboard=unnamedplus

" Enable true color support
set termguicolors

call plug#begin('~/.config/nvim/plugged')

" List your plugins here, e.g.
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'nvim-treesitter/nvim-treesitter'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neovim/nvim-lspconfig' 
Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }
Plug 'nvim-telescope/telescope.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
Plug 'romgrk/barbar.nvim'
Plug 'morhetz/gruvbox'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}
Plug 'nvim-lua/plenary.nvim'
Plug 'ms-jpq/chadtree', {'do': ':UpdateRemotePlugins'}
Plug 'vim-airline/vim-airline'

Plug 'folke/todo-comments.nvim'

" main one
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

" lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
" Need to **configure separately**

Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc
call plug#end()

"colorscheme moonfly
"colorscheme gruvbox
colorscheme gruvbox-baby


nnoremap <C-Space> :Files<CR>

" Move to previous/next
nnoremap <silent>    <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <A-.> <Cmd>BufferNext<CR>

" Re-order to previous/next
nnoremap <silent>    <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <A->> <Cmd>BufferMoveNext<CR>

" Goto buffer in position...
nnoremap <silent>    <S-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent>    <S-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent>    <S-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent>    <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent>    <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent>    <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent>    <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent>    <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent>    <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent>    <A-0> <Cmd>BufferLast<CR>

" Pin/unpin buffer
nnoremap <silent>    <A-p> <Cmd>BufferPin<CR>

" Goto pinned/unpinned buffer
"                          :BufferGotoPinned
"                          :BufferGotoUnpinned

" Close buffer
nnoremap <silent>    <A-c> <Cmd>BufferClose<CR>
" Restore buffer
nnoremap <silent>    <A-s-c> <Cmd>BufferRestore<CR>

" Wipeout buffer
"                          :BufferWipeout
" Close commands
"                          :BufferCloseAllButCurrent
"                          :BufferCloseAllButVisible
"                          :BufferCloseAllButPinned
"                          :BufferCloseAllButCurrentOrPinned
"                          :BufferCloseBuffersLeft
"                          :BufferCloseBuffersRight

" Magic buffer-picking mode
nnoremap <silent> <C-p>    <Cmd>BufferPick<CR>
nnoremap <silent> <C-s-p>  <Cmd>BufferPickDelete<CR>

" Sort automatically by...
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bn <Cmd>BufferOrderByName<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used
"
"
" Enable nvim-treesitter for Python syntax highlighting and indentation
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "c" },  -- Install the Python parser
  highlight = {
    enable = true,    -- Enable Tree-sitter-based highlighting
    additional_vim_regex_highlighting = false,  -- Disable traditional regex-based highlighting
  },
  indent = {
    enable = true,    -- Enable Tree-sitter-based indentation
  },
}
EOF



lua << EOF
  require('todo-comments').setup {
    -- Configuration options for the plugin
    signs = true,            -- Show signs in the sign column
    keywords = {
      TODO = { icon = "", color = "info" },
      FIX = { icon = "", color = "error" },
      DONE = { icon = "✔", color = "hint" },
      -- Add other keywords as needed
    },
    highlight = {
      keyword = "bg",        -- Highlight the background of comments
    },
  }
EOF

nnoremap <leader>td :TodoTelescope<CR>


lua << EOF
  require('telescope').setup({
    defaults = {
      prompt_prefix = "> ",
      selection_caret = "> ",
      layout_strategy = "horizontal",
      layout_config = { width = 0.75, height = 0.75 },
    },
    pickers = {
      find_files = {
        hidden = true,  -- Include hidden files

      },
      buffers = {
        ignore_current_buffer = true,  -- Ignore the current buffer
      },
    },
  })
EOF



nnoremap <C-SPACE> :lua require('telescope.builtin').find_files()<CR>

" Live grep (search text)
nnoremap <leader>fg :lua require('telescope.builtin').live_grep()<CR>

" List buffers
nnoremap <leader>fb :lua require('telescope.builtin').buffers()<CR>

" Search help tags
nnoremap <leader>fh :lua require('telescope.builtin').help_tags()<CR>

lua << EOF
  require('telescope').setup({
    defaults = {
      file_ignore_patterns = {
        "*/.venv/*",
        "node_modules/.*",    -- Ignore files inside the node_modules directory
        ".git/.*",            -- Ignore files inside the .git directory
        ".*%.tmp",            -- Ignore all files with a .tmp extension
        "dist/.*",            -- Ignore files inside dist folder
        "*/venv/*",     -- Ignore venv directories
        "*/env/*",      -- Ignore env directories
        "*/.venv/*",    -- Ignore .venv directories
        "*.pyc",        -- Optionally, ignore Python bytecode files
        "*.pyo",        -- Optionally, ignore Python optimized files
      },
      ripgrep_arguments = {
        'rg',
        '--hidden',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case'
    },
    }
  })
EOF

nnoremap <C-e> :CHADopen<CR>


" Ensure COQ starts automatically
let g:coq_settings = {
  \ 'auto_start': 'shut-up',
  \ 'keymap': {
  \   'manual_complete': '<C-l>',
  \ }
\ }
" LSP configuration for Pyright
lua << EOF
  local nvim_lsp = require('lspconfig')
  nvim_lsp.pyright.setup{
    on_attach = function(client, bufnr)
      -- Ensure COQ.nvim is integrated with the LSP server
      require('coq').lsp_ensure_capabilities(client)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
    end
  }
EOF

let g:mkdp_command_for_global = 1

