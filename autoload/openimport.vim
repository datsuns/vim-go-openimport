function! openimport#open_if_found(path) abort
  if isdirectory(a:path)
    execute ":tabnew"
    execute ":open " . a:path
    return v:true
  endif
  return v:false
endfunction

function! openimport#open() abort
  let line = getline('.')
  let wk = substitute(line, "\"", "", 'g')
  let pkg = substitute(wk, "\\s", "", 'g')
  if pkg[0:1] == "//"
    let pkg = pkg[2:]
  endif
  if openimport#open_if_found($GOROOT . "/src/" . pkg)
    return
  endif
  if openimport#open_if_found($GOPATH . "/src/" . pkg)
    return
  endif
  echo pkg . " NOT FOUND"
endfunction

