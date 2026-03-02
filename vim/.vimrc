" base
set encoding=utf-8
syntax on
set mouse=a
set noerrorbells
set novisualbell

if has('unnamedplus')
    set clipboard^=unnamedplus
else
    set clipboard^=unnamed
endif

filetype plugin indent on

" interface
set number
set cursorline
set scrolloff=8

" tabs
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent

" visual
set list
set listchars=tab:→\ ,trail:·,nbsp:◇,extends:▸,precedes:◂
if has("patch-8.2.5067")
    set listchars+=leadmultispace:│\ \ \ 
endif
set t_Co=256
colorscheme sorbet
" colorsheme retroblox
" colorsheme habamax

" === FOLDING (Сворачивание) ===
set foldmethod=indent
set foldlevel=99

" set relativenumber " number of strings upper and down

" search
set smartcase
set incsearch
set hlsearch


" misc
set wildmenu
let mapleader = " "
noremap <leader>r :source $MYVIMRC<CR>:echo "Config Reloaded!"<CR>
