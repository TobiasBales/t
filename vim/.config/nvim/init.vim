call plug#begin(stdpath('data') . '/plugged')

Plug 'Raimondi/delimitMate'
Plug 'TimUntersberger/neogit'
Plug 'christoomey/vim-tmux-navigator'
Plug 'hrsh7th/nvim-compe'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'michaeljsmith/vim-indent-object'
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'

call plug#end()

set background=dark
colorscheme gruvbox

lua <<EOF
vim.o.completeopt = "menuone,noselect"
require("dotfiles")
EOF

let mapleader=" "
let maplocalleader="\\"
set nofoldenable
inoremap jk <esc>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fd :lua require('dotfiles.telescope').search_dotfiles()<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>gb :lua require('dotfiles.telescope').git_branches()<CR>
nnoremap <leader>gc :lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>
nnoremap <leader>gs <cmd>Neogit<cr>
nnoremap <leader>gw :lua require('telescope').extensions.git_worktree.git_worktrees()<CR>
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nocompatible
set synmaxcol=300
set ttyfast
set lazyredraw
silent !mkdir ~/.config/nvim/backup > /dev/null 2>&1
set backupdir=~/.config/nvim/backup
silent !mkdir ~/.config/nvim/swaps > /dev/null 2>&1
set directory=~/.config/nvim/swaps
silent !mkdir ~/.config/nvim/undo > /dev/null 2>&1
set undodir=~/.config/nvim/undo
set undofile
set clipboard=unnamed
set noerrorbells visualbell t_vb=
set encoding=utf-8
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:»·,trail:·
set hlsearch
set incsearch
set ignorecase
set smartcase
set rnu
set nu
set numberwidth=1
if has("mouse")
  set mouse=a
endif
set notimeout
set ttimeout
set timeoutlen=20
set backspace=indent,eol,start
set printfont=PragmataPro:h12
set fillchars+=vert:│
set scrolloff=3
set autoindent
set autoread
set showmode
set showcmd
set hidden
set nocursorline
set ruler
set laststatus=2
set concealcursor=""
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
