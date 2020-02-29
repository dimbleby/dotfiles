" Format the whole file using the formatprg.
"
" Improves on gggqG by preserving the view and being undo-friendly.
function! format#FormatFile() abort
  let curw = winsaveview()
  normal! ix
  normal! "_x
  let tmpfile = tempname()
  let shellredir_save = &shellredir
  let &shellredir = '>%s 2>'.tmpfile
  silent execute '%!' . &l:formatprg
  let &shellredir = shellredir_save
  if v:shell_error != 0
    silent undo
    let output = readfile(tmpfile)
    echo join(output, "\n")
  endif
  call delete(tmpfile)
  call winrestview(curw)
endfunction
