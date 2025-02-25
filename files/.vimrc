colorscheme pablo
filetype plugin indent on
highlight Comment cterm=italic gui=italic
set backspace=indent,eol,start
set clipboard=unnamedplus
set colorcolumn=80
set hlsearch
set number
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
map <C-Bslash> :NERDTreeToggle<CR>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
packloadall
silent! helptags ALL
call plug#begin()
Plug 'jremmen/vim-ripgrep'
call plug#end()
