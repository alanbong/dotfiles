require('config.lazy')

-- Base settings
vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"

-- Turn off error sounds
vim.opt.errorbells = false
vim.opt.visualbell = false

-- Clipboard sync (Requires wl-clipboard for Wayland or xclip for X11 on Linux)
vim.opt.clipboard = "unnamedplus"

-- Python indentation overrides
vim.g.pyindent_open_paren = 'shiftwidth()'
vim.g.pyindent_nested_paren = 'shiftwidth()'
vim.g.pyindent_continue = 'shiftwidth()'

-- Interface settings
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8

-- Tabs and spaces (4 spaces layout)
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Custom keys
vim.keymap.set('n', '<F5>', ':w | sp | term python3 %<CR>')
vim.keymap.set('n', '<leader>r', function()
    package.loaded['plugins'] = nil
    vim.cmd('source $MYVIMRC')
    vim.notify('Reload configuration', vim.log.levels.INFO)
end, { desc = 'Reload configuration' })

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

