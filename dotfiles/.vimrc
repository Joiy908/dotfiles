set ts=4
set expandtab
set autoindent
set nu
set ruler
syntax on
set nocompatible
set shortmess+=I
set number
set relativenumber
set laststatus=2
set backspace=indent,eol,start
set hidden
set ignorecase
set smartcase


" Set tab size for C/C++ files
autocmd FileType c,cpp,javascript set tabstop=2
autocmd FileType c,cpp,javascript set shiftwidth=2
autocmd FileType c,cpp,javascript set expandtab

" Set tab size for Python files
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set expandtab
" mappings
nmap <Space> :
imap jkjk <Esc>
nmap Q <Nop>set noerrorbells visualbell t_vb=
set mouse+=a
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
" no, don't ban arrow in insert mode

nnoremap <C-p>  :CtrlP<CR>

map <C-e> ::NERDTreeMirror<CR>
map <C-e> :NERDTreeToggle<CR>

" yank to windows clipboard
vmap ;y : !/mnt/c/Windows/System32/clip.exe<cr>u''

" theme
syntax enable
let g:gruvbox_italic=1
set background=dark


if system('uname') =~# 'Linux'
    colorscheme gruvbox


    " let ctrlp show hidden files
    let g:ctrlp_show_hidden = 1
    " 插件开始的位置
    call plug#begin('~/.vim/plugged')

    " 代码自动完成，安装完插件还需要额外配置才可以使用
    Plug 'ycm-core/YouCompleteMe'

    " 用来提供一个导航目录的侧边栏
    Plug 'scrooloose/nerdtree'

    " 可以使 nerdtree 的 tab 更加友好些
    Plug 'jistr/vim-nerdtree-tabs'

    " 可以在导航目录中看到 git 版本信息
    " Plug 'Xuyuanp/nerdtree-git-plugin'

    " 查看当前代码文件中的变量和函数列表的插件，
    " 可以切换和跳转到代码中对应的变量和函数的位置
    " 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
    Plug 'preservim/tagbar'

    " 自动补全括号的插件，包括小括号，中括号，以及花括号
    Plug 'jiangmiao/auto-pairs'

    " Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
    Plug 'vim-airline/vim-airline'

    " 可以在文档中显示 git 信息
    Plug 'airblade/vim-gitgutter'


    " 插件结束的位置，插件全部放在此行上面
    call plug#end()

endif
