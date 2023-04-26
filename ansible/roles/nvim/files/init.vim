set clipboard=unnamedplus " Enables the clipboard between Vim/Neovim and other applications.
set completeopt=noinsert,menuone,noselect " Modifies the auto-complete menu to behave more like an IDE.
set cursorline " Highlights the current line in the editor
set hidden " Hide unused buffers
set autoindent " Indent a new line
set inccommand=split " Show replacements in a split screen
set mouse=a " Allow to use the mouse in the editor
set relativenumber " Shows the line numbers
set splitbelow splitright " Change the split screen behavior
set title " Show file title
set wildmenu " Show a more advance menu
" set cc=120 " Show at 80 column a border for good code style
filetype plugin indent on   " Allow auto-indenting depending on file type
syntax on
set spell " enable spell check (may need to download language package)
set ttyfast " Speed up scrolling in Vim
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

let s:fontsize = 12


" Plug
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

call plug#end()

let NERDTreeQuitOnOpen=1

" themes
"colorscheme gruvbox
"colorscheme tokyonight-night
"colorscheme tokyonight-storm
"colorscheme tokyonight-day
colorscheme tokyonight-moon

