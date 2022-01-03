autocmd BufNewFile,BufRead ~/.config/ion/initrc set filetype=ion
autocmd BufNewFile,BufRead *.ion set filetype=ion

autocmd BufNewFile,BufRead,StdinReadPost *
    \ if getline(1) =~ '^#!.*\Wion\s*$' |
    \   set ft=ion |
    \ endif
