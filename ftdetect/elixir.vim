aug neoshell_elxir
  au!
  au VimEnter,BufRead,BufNewFile *
        \ if filereadable('config/config.exs') |
        \   call neoshell#repl_add('iex -S mix') |
        \ elseif &filetype == 'elixir' |
        \   call neoshell#repl_add('iex') |
        \ endif
aug END
