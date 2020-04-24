filetype plugin indent on
syntax on
set number relativenumber
set splitbelow splitright
set cursorline
set expandtab
set fillchars+=vert:\│
set hidden

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
" Refer to https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions for
" how to install COC plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

colorscheme nord
let g:airline_powerline_fonts=1
let g:airline_theme='nord'

set encoding=utf-8

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" use :redraw! to force redraw the screen instead

nnoremap <leader>l :ls<CR>:b<space>

nmap <F8> :set paste<CR>i
imap <F8> <ESC>:set paste<CR>i<Right>
au InsertLeave * set nopaste
