"" appear
syntax on
set nu
set hlsearch
set nowrap
set linebreak
"set showtabline=2
set splitbelow
set splitright
set showcmd
set scrolloff=3
set ruler

"" search
set ignorecase
set incsearch
set smartcase

"" specification
set softtabstop=2
set shiftwidth=2
filetype on
filetype indent on
filetype plugin on

"" shotkey
let mapleader=','
nnoremap <esc> :noh<return><esc>
inoremap <leader>w <Esc>:w<cr>
nnoremap <leader>w <Esc>:w<cr>
inoremap kj <Esc>
nnoremap <C-x> :qa<Cr>
set pastetoggle=<F2>

"" other
set noswapfile	

"plugin********************************************************************************************************************************************************************************************
call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
call plug#end()

" gruvbox
autocmd vimenter * ++nested colorscheme gruvbox
set bg=dark

" easymotion
map ss <Plug>(easymotion-s2)
