set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
            \ 'filename':'/tmp/{hostname}_{pathname%10}.{extension}',
        \ },
    \ }
\ }

function! OnUIEnter(event) abort
  if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
    set laststatus=0
    let g:airline_theme='firenvim'
    :AirlineToggle
    set guifont=Cascadia\ Code:h9
    :NERDTreeToggle
  else
    Plug 'tmhedberg/SimpylFold'             "python docstrings and import folding
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
