nnoremap <space>p o<esc>p
" commend
inoremap jk <esc>
set noswapfile
syntax on
set number
set softtabstop=2
set expandtab
set showtabline=2
set splitbelow
set splitright
set ignorecase
filetype on
filetype plugin on
filetype indent on
set clipboard=unnamedplus
set encoding=utf8
set path+=**
set wildmenu
set relativenumber
set hlsearch
set incsearch
set cursorline

let mapleader=" "
let maplocalleader=" "
noremap <leader>n :nohl<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>


inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"inoremap <C-d> <DELETE>
inoremap <C-d> <C-h>
