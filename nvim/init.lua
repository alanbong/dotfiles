require('config.lazy')

-- base
vim.cmd('set encoding=utf-8')
vim.cmd('syntax on')
vim.cmd('set mouse=a')

-- turn off error sounds
vim.cmd('set noerrorbells')
vim.cmd('set novisualbell')

-- paste settings
if vim.fn.has('unnamedplus') == 1 then
    vim.opt.clipboard:prepend('unnamedplus')
else
    vim.opt.clipboard:prepend('unnamed')
end

vim.cmd('filetype plugin indent on')

--turn off pyindent
vim.g.pyindent_open_paren = 'shiftwidth()'
vim.g.pyindent_nested_paren = 'shiftwidth()'
vim.g.pyindent_continue = 'shiftwidth()'

-- interface
vim.cmd('set number')
vim.cmd('set cursorline')
vim.cmd('set scrolloff=8')

-- tabs
vim.cmd('set expandtab')
vim.cmd('set tabstop=4')
vim.cmd('set softtabstop=4')
vim.cmd('set shiftwidth=4')

-- vim.cmd('set smartindent')

-- visual
-- set list
-- set listchars=tab:→\ ,trail:·,nbsp:◇,extends:▸,precedes:◂
-- if has("patch-8.2.5067")
--     set listchars+=leadmultispace:│\ \ \ 
-- endif
-- set t_Co=256
-- colorscheme slate

-- === FOLDING (Сворачивание) ===
-- set foldmethod=indent
-- set foldlevel=99

-- " set relativenumber " number of strings upper and down
-- " search
-- set smartcase
-- set incsearch
-- set hlsearch
-- 
-- 
-- " misc
-- set wildmenu
-- let mapleader = " "
-- noremap <leader>r :source $MYVIMRC<CR>:echo "Config Reloaded!"<CR>

