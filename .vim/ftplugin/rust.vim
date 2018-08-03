" Reformat Rust code
nmap <buffer> <localleader>= :RustFmt<CR>

let b:ale_linters = ['rls']
let b:ale_rust_rls_toolchain = 'stable'
let b:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
