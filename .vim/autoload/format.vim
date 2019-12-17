" Format the whole file using the formatprg.
"
" Improves on gggqG by preserving the view and being undo-friendly.
function! format#FormatFile()
  let l:curw = winsaveview()
  normal! ix
  normal! "_x
  let l:tmpfile = tempname()
  let l:shellredir_save = &shellredir
  let &shellredir = '>%s 2>'.l:tmpfile
  silent execute '%!' . &l:formatprg
  let &shellredir = l:shellredir_save
  if v:shell_error != 0
    silent undo
    let output = readfile(l:tmpfile)
    echo join(output, "\n")
  endif
  call winrestview(l:curw)
endfunction
