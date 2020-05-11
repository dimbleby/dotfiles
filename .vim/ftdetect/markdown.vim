" Vim used to recognise .md as modula2.
if v:version < 800
    autocmd! filetypedetect BufRead,BufNewFile *.md
endif

autocmd BufRead,BufNewFile *.md setfiletype markdown
