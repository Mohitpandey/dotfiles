set nocompatible              " dont care about the old vim

set rtp+=~/.vim/bundle/vundle.vim/

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ervandew/supertab'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mbbill/undotree'
Plugin 'altercation/vim-colors-solarized'

call vundle#end()

syntax on
set background=dark
colorscheme solarized
set nu

set hlsearch

if has("persistent_undo")
    set undodir='~/.undodir/'
    set undofile
endif

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" Airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2

nnoremap <C-U> :UndotreeToggle<cr>
