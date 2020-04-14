filetype plugin indent on
syntax on
set number relativenumber
set splitbelow splitright
set cursorline
set expandtab
colorscheme molokai
set fillchars+=vert:\ 
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
set encoding=utf-8

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

let g:NERDTreeWinSize=25
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
" Start nerdtree if no files specified
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" And if vim opens a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Exit Vim if the only window open is nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:SuperTabDefaultCompletionType="context"
let g:SuperTabContextDefaultCompletionType="<C-p>"
set wildmode=longest,list:longest
