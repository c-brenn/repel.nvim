aug repel_repl_detect
  au!
  " Elixir
  au VimEnter,BufRead,BufNewFile *
        \ if filereadable('config/config.exs') |
        \   call repel#set_repl('elixir', 'iex -S mix') |
        \ elseif &filetype == 'elixir' |
        \   call repel#set_repl('elixir', 'iex') |
        \ endif

  " Haskell
  au VimEnter,BufRead,BufNewFile *.hs
        \ if executable('ghci') |
        \   call repel#set_repl('haskell', 'ghci') |
        \ endif

  " Ruby
  au VimEnter,BufRead,BufNewFile *.rb,*.erb
        \ if executable('irb') |
        \   call repel#set_repl('ruby', 'irb') |
        \ endif

  " Rails
  au VimEnter,BufRead,BufNewFile *
        \ if filereadable('config/application.rb') |
        \   call repel#set_repl('ruby', 'bundle exec rails console') |
        \ endif

aug END
