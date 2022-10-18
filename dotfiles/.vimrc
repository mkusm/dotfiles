"""VUNDLE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim')

Plug 'christoomey/vim-tmux-navigator'   "integrate vim with tmux navigation
Plug 'Vimjas/vim-python-pep8-indent'    "python indenting
Plug 'tpope/vim-surround'               "cs]} to change [hello] to {hello}
Plug 'tpope/vim-fugitive'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) }}
Plug 'moll/vim-bbye'
Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'github/copilot.vim'
Plug 'jiangmiao/auto-pairs'             "close {, (, [ etc.
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsMoveCharacter = ''

Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

Plug 'justinmk/vim-sneak'
let g:sneak#label = 1

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <C-p> :Telescope git_files<CR>

Plug 'scrooloose/nerdtree'              "browse files
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in")
  \  | NERDTree | wincmd p | endif
" Exit Vim if the last window is a NERDTree window.
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") &&
  \  b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeQuitOnOpen = 1

Plug 'vim-airline/vim-airline'          "infoline at top and bottom
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 0
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
Plug 'vim-airline/vim-airline-themes'   "themes for airline
let g:airline_theme='term'

Plug 'embear/vim-localvimrc'            "use local .lvimrc files
"let g:localvimrc_whitelist='/home/mk/work/*'
let g:localvimrc_persistent = 1

Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_padding_left = 10

Plug 'marcopaganini/termschool-vim-theme' "colorscheme

" All of your Plugins must be added before the following line
call plug#end()

"""BASICS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set scrolloff=10 "keep 5 lines above and below cursor

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" move '~' and '.swp' files
" ~/.vim/backup/ dir needs to be created earlier!
set backupdir=~/.vim/backup/,~/.backup/
set directory=~/.vim/backup/,~/.backup/

" allow to have an unwritten buffer that's no longer visible
set hidden

" search is case insensitive
set ignorecase            

" remember copied text when pasting over
vnoremap p pgvy

"""VISUAL""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme termschool

" enable all Python syntax highlighting features
autocmd BufRead,BufNewFile *.py let python_highlight_all=1 
set number relativenumber    " show line numbers
set showmatch                " show the matching for [], {} and ()
set showcmd		               " display what you are writing as a command
set hlsearch                 " highlight string matched in search

"""INDENTATION"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd Filetype vim setlocal
  \ expandtab
  \ tabstop=2
  \ shiftwidth=2
  \ colorcolumn=80

autocmd Filetype python setlocal
  \ colorcolumn=120

autocmd Filetype html setlocal
  \ expandtab
  \ tabstop=2
  \ shiftwidth=2

autocmd Filetype cpp setlocal
  \ expandtab
  \ tabstop=4
  \ shiftwidth=4

let c_no_curly_error = 1

set expandtab
set tabstop=4
set shiftwidth=4

"""MAPPINGS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Swap ; and :
noremap ; :
noremap : ;

" Use 0 to go to the first non-blank character
nnoremap 0 ^
nnoremap ^ 0

" go to next buffer
nnoremap <silent> <tab> :bn<CR>

" go to previous buffer 
nnoremap <silent> <S-tab> :bp<CR>

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
nnoremap <C-k>    :resize +2<CR>
nnoremap <C-j>  :resize -2<CR>
nnoremap <C-h>  :vertical resize +2<CR>
nnoremap <C-l> :vertical resize -2<CR>

" Use CTRL-J to move to next suggestion in completion menu
inoremap <C-J> <C-N>

" Use CTRL-K to move to previous suggestion in completion menu
inoremap <C-K> <C-P>

" Movement
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

let g:tmux_navigator_no_mappings = 1

nnoremap <A-h> :TmuxNavigateLeft<cr>
nnoremap <A-j> :TmuxNavigateDown<cr>
nnoremap <A-k> :TmuxNavigateUp<cr>
nnoremap <A-l> :TmuxNavigateRight<cr>

"""LEADER""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set leader
noremap <Space> <Nop>
let mapleader = "\<Space>"

" open buffers list in CtrlP
nnoremap <Leader><C-p> :Telescope<CR>

" delete current buffer without closing split
nnoremap <Leader>b :Bwipeout!<CR>

" save session
nnoremap <Leader>s :mksession! s.vim<CR>

" toggle NERDTree
nnoremap <Leader>e :NERDTreeToggle<CR>

" find file in NERDTree
nnoremap <Leader>w :NERDTreeFind<CR>

" copy from clipboard
nnoremap <Leader>y "+y
vnoremap <Leader>y "+y

" paste from clipboard
nnoremap <Leader>p "+p
