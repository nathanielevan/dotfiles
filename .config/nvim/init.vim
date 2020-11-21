filetype plugin indent on
syntax on
set number relativenumber
set splitbelow splitright
set cursorline
set nostartofline
set tabstop=4 expandtab
set incsearch
set hlsearch
set ignorecase
set smartcase
set fillchars+=vert:\│
set hidden
set showcmd
set mouse=a
set encoding=utf-8
set guicursor=

set title
set titlestring=NVIM:\ %-0.30F\%a%r%m

" Insert newline without entering insert mode
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" Keybinds for window navigation
" use :redraw! to force redraw the screen instead
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Clear last search with Ctrl+/
noremap <silent> <C-_> :let @/ = ""<CR>

" Keybind to insert in paste mode
nmap <F8> :set paste<CR>i
imap <F8> <ESC>:set paste<CR>i<Right>
au InsertLeave * set nopaste

" Keybind to delete buffer without closing the window
nnoremap <silent> <leader>d :bp\|bd #<CR>

" Workaround for resize bug on alacritty if launced as initial command
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

" Automatically download vim-plug if it doesn't exist
let autoload_plug_path = stdpath('data') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
    silent execute '!curl -fLo ' . autoload_plug_path . ' --create-dirs
        \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Load plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-fugitive'
Plug 'ervandew/supertab'
" Refer to https://github.com/neoclide/coc.nvim/wiki/Using-coc-extensions for
" how to install COC plugins
Plug 'neoclide/coc.nvim', { 'branch' : 'release' }
Plug 'junegunn/fzf', { 'do' : { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lambdalisue/fern.vim'
Plug 'vimwiki/vimwiki'

call plug#end()

colorscheme nord

" vim-airline configuration
let g:airline_powerline_fonts=1
let g:airline_theme='nord'
" let g:airline#extensions#tabline#enabled = 1

" fzf configuration
let $BAT_THEME = "base16"
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --no-ignore --glob '!.git/*'"
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" Put {'options': ['--no-unicode']} in with_preview() to disable unicode
let g:fzf_layout = { 'down': '~30%' }
" fzf.vim keybinds
nnoremap <leader>l :Buffers<CR>
nnoremap <leader>p :Files<CR>
" tip: use :cd to change directory

" fern.vim configuration
" Disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

let g:fern#drawer_width = 25
let g:fern#disable_default_mappings = 1

noremap <silent> <A-f> :Fern . -drawer -toggle<CR>

function! FernInit() abort
        nmap <buffer><expr>
                \ <Plug>(fern-cr-open-enter)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open:select)",
                \   "\<Plug>(fern-action-enter)",
                \ )
        nmap <buffer><expr>
                \ <Plug>(fern-mouse-open-expand-collapse)
                \ fern#smart#leaf(
                \   "\<Plug>(fern-action-open:select)",
                \   "\<Plug>(fern-action-expand)",
                \   "\<Plug>(fern-action-collapse)",
                \ )
        nmap <buffer> <2-LeftMouse> <Plug>(fern-mouse-open-expand-collapse)
        nmap <buffer> <CR> <Plug>(fern-cr-open-enter)
        nmap <buffer> l <Plug>(fern-action-expand)
        nmap <buffer> h <Plug>(fern-action-collapse)
        nmap <buffer> <Backspace> <Plug>(fern-action-leave)
        nmap <buffer> H <Plug>(fern-action-open:split)
        nmap <buffer> V <Plug>(fern-action-open:vsplit)
        nmap <buffer> R <Plug>(fern-action-rename)
        nmap <buffer> M <Plug>(fern-action-move)
        nmap <buffer> C <Plug>(fern-action-copy)
        nmap <buffer> F <Plug>(fern-action-new-file)
        nmap <buffer> D <Plug>(fern-action-new-dir)
        nmap <buffer> S <Plug>(fern-action-hidden-toggle)
        nmap <buffer> dd <Plug>(fern-action-trash)
endfunction

augroup FernGroup
        autocmd!
        autocmd Filetype fern call FernInit()
augroup END
