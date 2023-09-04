
vim.cmd([[
    let g:fern#disable_default_mappings             = 1
    let g:fern#disable_drawer_auto_quit             = 1
    let g:fern#disable_viewer_hide_cursor           = 1
    let g:fern#mark_symbol                          = '●'
    let g:fern#renderer#default#collapsed_symbol    = '▷ '
    if empty(eval('$VTE_VERSION'))
    let g:fern#renderer#default#expanded_symbol = '◢ '
    else
    let g:fern#renderer#default#expanded_symbol = '▼ '
    endif
    let g:fern#renderer#default#leading             = ' '
    let g:fern#renderer#default#leaf_symbol         = ' '
    let g:fern#renderer#default#root_symbol         = '~ '

    noremap <silent> <Leader>n :Fern . -drawer -reveal=% -width=35 -toggle<CR><C-w>=
    noremap <silent> - :Fern %:h -reveal=%<CR>

    function! FernInit() abort
    nmap <buffer><expr>
    \ <Plug>(fern-my-open-expand-collapse)
    \ fern#smart#leaf(
      \   "\<Plug>(fern-action-open:select)",
      \   "\<Plug>(fern-action-expand)",
      \   "\<Plug>(fern-action-collapse)",
      \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
nmap <buffer> o <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> go <Plug>(fern-my-open-expand-collapse)<C-w>p
  " nmap <buffer> l <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> m <Plug>(fern-action-mark:toggle)
xmap <buffer> m <Plug>(fern-action-mark:toggle)
  " nmap <buffer> N <Plug>(fern-action-new-file)
  " nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> C <Plug>(fern-action-copy)
  nmap <buffer> A <Plug>(fern-action-new-path)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> R <Plug>(fern-action-rename)
  xmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> r <Plug>(fern-action-reload)
  nmap <buffer> Y <Plug>(fern-action-yank)
  nmap <buffer> <nowait> y <Plug>(fern-action-yank:path)
  nmap <buffer> <nowait> d <Plug>(fern-action-hidden:toggle)
  nmap <buffer> <nowait> h <Plug>(fern-action-leave)
nmap <buffer> <nowait> l <Plug>(fern-action-enter)
  " nmap <buffer> <nowait> <Enter> :set laststatus=2<CR><Plug>(fern-action-open:select):set laststatus=0<CR>
  nmap <buffer> <nowait> <Enter> <Plug>(fern-action-open:select)
nmap <buffer> <nowait> - <Plug>(fern-action-leave)
  endfunction

  augroup FernEvents
  autocmd!
autocmd FileType fern call FernInit()
  augroup END

  " Disable Netrw.
  let g:loaded_netrw             = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1
  let g:loaded_netrwFileHandlers = 1

  augroup my-fern-hijack
  autocmd!
  autocmd BufEnter * ++nested call s:hijack_directory()
  augroup END

  function! s:hijack_directory() abort
  let path = expand('%:p')
if !isdirectory(path)
  return
  endif
  bwipeout %
  execute printf('Fern %s', fnameescape(path))
  endfunction
  ]])
