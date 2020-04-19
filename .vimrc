filetype plugin indent on
syntax on
set number relativenumber
set splitbelow splitright
set cursorline
set expandtab
set fillchars+=vert:\ 
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
Plug 'preservim/nerdtree'
Plug 'ervandew/supertab'
Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --all' }

call plug#end()

colorscheme nord
let g:airline_powerline_fonts=1
let g:airline_theme='nord'

set encoding=utf-8

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nnoremap <leader>l :ls<CR>:b<space>

autocmd VimEnter * NERDTree
let g:NERDTreeWinSize=25
let g:NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" Start nerdtree if no files specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" And if vim opens a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Exit Vim if the only window open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

set completeopt-=preview
