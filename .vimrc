filetype on
filetype indent on
set autoindent
syntax on

" SYSTEM
set encoding=utf-8
set nocompatible
set noswapfile
set nobackup
set nowritebackup
set undofile
set hidden
set autowrite
set autoread

" Enable 24-bit true colors if your terminal supports it.
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors
endif

set mouse=a
set clipboard=unnamedplus,unnamed


" APPEARANCE
set cursorline
set colorcolumn=80
set scrolloff=8
set sidescrolloff=8
set number relativenumber
set numberwidth=4
set smartcase ignorecase

set hlsearch
set laststatus=2
set matchpairs+=<:>
set modelines=2
set ruler
set nostartofline


" TABS
set nowrap
set smartindent
set expandtab smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4

set incsearch

set showmatch

set wildmenu
set wildmode=list:longest

set backspace=indent,eol,start " backspacing over everything in insert mode


" KEYMAPS
let mapleader = " "
nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>
nnoremap c "_c
nnoremap x "_x
map Y y$

" Move to first, last line
nnoremap $ ^
nnoremap 0 g_

" Centers cursor
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Move 1 more lines up or down in normal and visual selection modes.
nnoremap <A-k> :m .-2<CR>==
nnoremap <A-j> :m .+1<CR>==
vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap <A-j> :m '>+1<CR>gv=gv

" Append line below to current line and keep cursor position
nnoremap J mzJ`z

vnoremap < <gv
vnoremap > >gv

" Move line up and down
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
vnoremap p "_dP

" Others --
" Replace the word that cursor is on
nnoremap <leader>s [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
" Tmux sessionizer
nnoremap <C-f> :silent !tmux neww tmux-sessionizer<CR>

" AUTOCMD
hi CursorLine cterm=NONE ctermbg=242
hi CursorLineNR cterm=NONE ctermbg=242
au FocusGained,BufEnter * checktime
