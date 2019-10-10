let s:g_openimport_go_root_path = ""

function! openimport#open_if_found(path) abort
  if isdirectory(a:path)
    execute ":tabnew"
    execute ":open " . a:path
    return v:true
  endif
  return v:false
endfunction

function! openimport#open_by_env(pkg) abort
  if s:g_openimport_go_root_path != ""
    return openimport#open_if_found(s:g_openimport_go_root_path . "/src/" . a:pkg)
  endif
  if executable("go") == 0
    echo "golang is not installed"
    return v:false
  endif
  let logs = split(system("go env"), "\n")
  for line in logs
    if match(line, "^set GOROOT=.*") != -1
      let s:g_openimport_go_root_path = split(line, "=")[1]
      return openimport#open_if_found(s:g_openimport_go_root_path . "/src/" . a:pkg)
    endif
  endfor
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
  if openimport#open_by_env(pkg)
    return
  endif
  echo pkg . " NOT FOUND"
endfunction

