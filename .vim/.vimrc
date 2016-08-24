set nocompatible              " be iMproved
filetype off                  " required!

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set rtp+=~/.vim/bundle/vundle.vim/
call vundle#begin()

Plugin 'ervandew/supertab'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'jiangmiao/auto-pairs'
Plugin 'mbbill/undotree'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'} "colorscheme Tomorrow-Night-Eighties
Plugin 'morhetz/gruvbox'

call vundle#end()
filetype plugin indent on

syntax on
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox
set nu

if has("persistent_undo")
    set undodir='~/.undodir/'
    set undofile
endif

filetype on

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray

" Airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set t_Co=256
nnoremap <C-U> :UndotreeToggle<cr>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
