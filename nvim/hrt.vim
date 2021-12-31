"set the python3.8 for shsys2
let g:python3_host_prog='/usr/local/bin/python3.8'
let g:tagbar_ctags_bin='/usr/bin/ctags'

" add a new file type
au BufRead,BufNewFile *.hrt setlocal ft=hrt
