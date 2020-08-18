"""VUNDLE""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " vundle required
filetype off                  " vundle required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'christoomey/vim-tmux-navigator'   "integrate vim with tmux navigation
Plugin 'tmhedberg/SimpylFold'             "python docstrings and import folding
Plugin 'Vimjas/vim-python-pep8-indent'    "python indenting
Plugin 'jiangmiao/auto-pairs'             "close {, (, [ etc.
Plugin 'scrooloose/nerdtree'              "browse files
Plugin 'tpope/vim-surround'               "cs]} to change [hello] to {hello}
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'AndrewRadev/splitjoin.vim'

Plugin 'ctrlpvim/ctrlp.vim'               "file finder
let g:ctrlp_user_command = 
  \ ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_working_path_mode = 0

Plugin 'ycm-core/YouCompleteMe'           "autocompletion
" don't show preview with documentation when not asked
set completeopt-=preview
" show popup with documentation when going through suggestion list
set completeopt+=popup
" don't show popup when hovering over word
let g:ycm_auto_hover=''
" increase preview height when focused
"set previewheight=50
"au BufEnter ?* call PreviewHeightWorkAround()
"func PreviewHeightWorkAround()
"    if &previewwindow
"        exec 'setlocal winheight='.&previewheight
"    endif
"endfunc

Plugin 'vim-airline/vim-airline'          "infoline at top and bottom
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 0
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
Plugin 'vim-airline/vim-airline-themes'   "themes for airline
let g:airline_theme='term'

Plugin 'zirrostig/vim-schlepp'            "move visual blocks around
vmap <up>    <Plug>SchleppUp
vmap <down>  <Plug>SchleppDown
vmap <left>  <Plug>SchleppLeft
vmap <right> <Plug>SchleppRight
vmap D <Plug>SchleppDup

Plugin 'embear/vim-localvimrc'            "use local .lvimrc files
"let g:localvimrc_whitelist='/home/mk/work/*'
let g:localvimrc_persistent = 1

Plugin 'mhinz/vim-startify'
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_padding_left = 10

Plugin 'marcopaganini/termschool-vim-theme' "colorscheme

" All of your Plugins must be added before the following line
call vundle#end()             " vundle required

"""BASICS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" scrolling without flicker 
if (&term =~ '^xterm' && &t_Co == 256)
  set t_ut=""
  set ttyscroll=1
endif

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
  \ colorcolumn=80

autocmd Filetype html setlocal
  \ expandtab
  \ tabstop=2
  \ shiftwidth=2

"""MAPPINGS""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Swap ; and :
noremap ; :

" Disable arrow movement, resize splits instead.
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

"""LEADER""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set leader
noremap <Space> <Nop>
let mapleader = "\<Space>"

" open buffers list in CtrlP
nnoremap <Leader><C-p> :CtrlPBuffer<CR>

" go to next buffer
nnoremap <Leader>l :bn<CR>

" go to previous buffer 
nnoremap <Leader>h :bp<CR>

" delete current buffer without closing split
nnoremap <Leader>b :bp\|bd #<CR>

" show documentation
nnoremap <Leader>d :YcmCompleter GetDoc<CR>

" save session
nnoremap <Leader>s :mksession! s.vim<CR>
