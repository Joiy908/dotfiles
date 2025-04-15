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

" Set tab size for Python,go files
autocmd FileType python,go set tabstop=4
autocmd FileType python,go set shiftwidth=4
autocmd FileType python set expandtab

" auto close the preview window after autoCompletion
autocmd CompleteDone * pclose

" mappings
let mapleader = " "
nnoremap <leader><Space> :
nmap <leader>h :noh<CR>
imap jkjk <Esc>
" nmap Q <Nop>set noerrorbells visualbell t_vb=
set mouse+=a
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" open terminal in nvim
nnoremap <leader>t :w<CR>:term fish<CR>
" ...and in insert mode
" no, don't ban arrow in insert mode

" for C/C++ coding
autocmd FileType c,cpp imap fori for(int i = 0; i < LEN; i++)
autocmd FileType c,cpp imap forj for(int j = 0; j < LEN; j++)
autocmd FileType c,cpp imap fork for(int k = 0; k < LEN; k++)
autocmd FileType c,cpp imap ulog rc = scanf("",);<CR>assert(rc == );
autocmd FileType c nnoremap <buffer> <leader>log ^d$Iprintf("", );<ESC>hPF"i
autocmd FileType c nnoremap <buffer> <leader>x :w<CR>:!gcc % -lm && ./a.out<CR>
autocmd FileType cpp nnoremap <buffer> <leader>x :w<CR>:!g++ % && ./a.out<CR>
autocmd FileType c nnoremap <buffer> <leader>e :w<CR>:!gcc % -E<CR>
" for python
autocmd FileType python nnoremap <buffer> <leader>log ^d$Iprint()<ESC>P
autocmd FileType python nnoremap <buffer> <leader>x :w<CR>:!python3 temp.py<CR>
" for go
autocmd FileType go nnoremap <buffer> <leader>log ^d$Ifmt.Println()<ESC>P
autocmd FileType go nnoremap <buffer> <leader>x :w<CR>:GoRun %<CR>
autocmd FileType go noremap <leader>f :GoFmt<CR>
" autocmd FileType go nmap <leader>b <Plug>(go-build)


" yank to linux clipboard
vmap ;y "+y

if exists('g:vscode')
    " VSCode extension 
    
    " in vscode, forget <leader>go, use gd
    nnoremap <leader>fi <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
    vnoremap <leader>f <Cmd>call VSCodeCall('editor.action.formatSelection')<CR><Esc>
    nnoremap <leader>t <Cmd>call VSCodeNotify('workbench.action.terminal.toggleTerminal')<CR>

    " nnoremap K <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
    " nnoremap gh <Cmd>call VSCodeNotify('editor.action.showHover')<CR>
    " nnoremap gd 
    " nnoremap gD <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
    " above is defualt, to see more: 
    " https://github.com/vscode-neovim/vscode-neovim/blob/master/vim/vscode-code-actions.vim
else
    " ordinary Neovim
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

        Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

        " note: this slow down the vim start-up-time
        " Plug 'vim-airline/vim-airline'

        " === end import plugin
        call plug#end()
    endif
endif

