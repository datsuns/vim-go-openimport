if exists('g:loaded_vim_go_openimport')
  finish
endif
let g:loaded_vim_go_openimport = 1

let s:save_cpo = &cpo
set cpo&vim

augroup vim-go-openimport
  autocmd!
  autocmd FileType go command! GoOpenImport call openimport#open()
  autocmd FileType go nnoremap <Space>gf :GoOpenImport<Enter>
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
