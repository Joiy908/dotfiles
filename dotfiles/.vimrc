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

" auto close the preview window after autoCompletion
autocmd CompleteDone * pclose

" mappings
nmap <Space> :
imap jkjk <Esc>
nmap Q <Nop>set noerrorbells visualbell t_vb=
set mouse+=a
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" for c coding
imap ffor for(int i = 0; i < LEN; i++)
nnoremap <leader>x :w<CR>:!gcc % -lm && ./a.out<CR>
nnoremap <leader>e :w<CR>:!gcc % -E<CR>
nnoremap <leader>cp :w<CR>:!/bin/cp % ~/d-src/temp<CR>
" ...and in insert mode
" no, don't ban arrow in insert mode


" yank to windows clipboard
vmap ;y : !/mnt/c/Windows/System32/clip.exe<cr>u''


if system('uname') =~# 'Linux'
    " === start import plugin
    call plug#begin('~/.vim/plugged')

    " theme
    Plug 'morhetz/gruvbox'
    syntax enable
    let g:gruvbox_italic=1
    set background=dark
    autocmd vimenter * ++nested colorscheme gruvbox

    Plug 'jiangmiao/auto-pairs'

    Plug 'ycm-core/YouCompleteMe'
    nnoremap <leader>go :YcmCompleter GoTo<CR>
    nnoremap <leader>fi :YcmCompleter FixIt<CR>
    vnoremap <leader>f :YcmCompleter Format<CR>

    " file explorer in sidebar 
    Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
    map <C-e> :NERDTreeToggle<CR>

    Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
    nmap <F8> :TagbarToggle<CR>
    let g:tagbar_autofocus = 1

    Plug 'kien/ctrlp.vim'
    nnoremap <C-p>  :CtrlP<CR>
    let g:ctrlp_show_hidden = 1

    " note: this slow down the vim start-up-time
    " Plug 'vim-airline/vim-airline'

    " === end import plugin
    call plug#end()
endif
