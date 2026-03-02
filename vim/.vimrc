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

"" ==========================================
"" === PYTHON FOLDING (EXPRESSION METHOD) ===
"" ==========================================
"
"" 1. ЛОГИКА: Используем выражение (expr) вместо indent/syntax
"" Это дает нам ПОЛНЫЙ контроль над тем, что считать фолдом
"set foldmethod=expr
"set foldexpr=PythonFoldExpr(v:lnum)
"
"function! PythonFoldExpr(lnum)
"    let line = getline(a:lnum)
"    let prev_line = getline(a:lnum - 1)
"
"    " 1. Классы и функции = Уровень 1
"    if line =~ '^\s*\(class\|def\)\s'
"        return '>1'
"    endif
"
"    " 2. Докстринги = Уровень 2
"    if line =~ '"""' || line =~ "'''"
"        if line =~ '^\s*"""\s*$' || line =~ "^\s*'''\s*$"
"            return '<2'
"        endif
"        return '>2'
"    endif
"
"    " 3. Скобки (Самое интересное)
"    " Если строка заканчивается открывающей скобкой: (, [, {
"    if line =~ '[([{]\s*$'
"        " Повышаем уровень вложенности (a1 = add 1)
"        return 'a1'
"    endif
"
"    " Если строка начинается с закрывающей скобки: ), ], }
"    if line =~ '^\s*[)\]}]'
"        " Понижаем уровень (s1 = subtract 1)
"        return 's1'
"    endif
"
"    " Для всего остального наследуем уровень от предыдущей строки
"    return '='
"endfunction
"
"
"" 2. UI: Красивый текст (как и раньше)
"set fillchars+=fold:\ 
"hi Folded ctermbg=NONE ctermfg=242 guibg=NONE guifg=#6c6c6c
"
"function! MyFoldText()
"    let line = getline(v:foldstart)
"    let n_lines = v:foldend - v:foldstart + 1
"    let indent = repeat(' ', indent(v:foldstart))
"    let clean_line = substitute(line, '^\s*\|\s*$', '', 'g')
"    return indent . clean_line . ' ... (' . n_lines . ' lines)'
"endfunction
"set foldtext=MyFoldText()
"
"" 3. НАСТРОЙКИ СТАРТА
"" foldlevel=1 означает:
"" Уровень 1 (классы/функции) - БУДУТ ОТКРЫТЫ
"" Уровень 2 (докстринги) - БУДУТ ЗАКРЫТЫ
"set foldlevel=1
"
"" 4. MAPPINGS
"nnoremap zz za
"
"" zD: Переключаем уровень отображения
"" Если level=1 (докстринги закрыты), ставим 99 (все открыто)
"" Если level=99, ставим 1 (закрываем докстринги)
"function! ToggleDocLevel()
"    if &foldlevel == 1
"        set foldlevel=99
"        echo "All Unfolded"
"    else
"        set foldlevel=1
"        echo "Docstrings Folded"
"    endif
"endfunction
"nnoremap zD :call ToggleDocLevel()<CR>
"
"
