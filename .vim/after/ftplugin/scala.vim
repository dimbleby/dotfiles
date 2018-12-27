" https://github.com/derekwyatt/vim-scala/pull/148
setlocal include=^\\s*import
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
