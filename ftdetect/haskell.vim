aug neoshell_repl_haskell
  au!
  au VimEnter,BufRead,BufNewFile *
        \ if &filetype == 'haskell' && executable('ghci') |
        \   call neoshell#repl_add('ghci') |
        \ endif
aug END
