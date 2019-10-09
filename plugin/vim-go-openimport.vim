if exists('g:loaded_vim_go_openimport')
  finish
endif
let g:loaded_vim_go_openimport = 1

let s:save_cpo = &cpo
set cpo&vim

let &cpo = s:save_cpo
unlet s:save_cpo
