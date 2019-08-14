" Format the whole file using the formatprg.
"
" Improves on gggqG by preserving the view and being undo-friendly.
function! format#FormatFile()
  let l:curw = winsaveview()
  normal! ix
  normal! x
  silent execute '%!' . &l:formatprg
  call winrestview(l:curw)
endfunction
