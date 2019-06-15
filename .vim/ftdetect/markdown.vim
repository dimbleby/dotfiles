" Before this patch, vim used modula2 for .md.
if !has('patch-7.4.480')
    autocmd! filetypedetect BufRead,BufNewFile *.md
endif

" And before this patch, vim set anything it didn't recognize to `conf`, with
" no notion of fallback.
if has('patch-8.0.0613')
    autocmd BufRead,BufNewFile *.md setfiletype=markdown
else
    autocmd BufRead,BufNewFile *.md set filetype=markdown
endif
