aug repel_repl_detect
  au!
  " Elixir
  au VimEnter,BufRead,BufNewFile *
        \ if filereadable('config/config.exs') |
        \   call repel#set_repl('iex -S mix') |
        \ elseif &filetype == 'elixir' |
        \   call repel#set_repl('iex') |
        \ endif

  " Haskell
  au VimEnter,BufRead,BufNewFile *.hs
        \ if executable('ghci') |
        \   call repel#set_repl('ghci') |
        \ endif

  " Ruby
  au VimEnter,BufRead,BufNewFile *.rb,*.erb
        \ if executable('irb') |
        \   call repel#set_repl('irb') |
        \ endif

  " Rails
  au VimEnter,BufRead,BufNewFile *
        \ if filereadable('config/application.rb') |
        \   call repel#set_repl('bundle exec rails console') |
        \ endif

  " Python
  au VimEnter,BufRead,BufNewFile *.py,
        \ if executable('ipython') |
        \   call repel#set_repl('ipython') |
        \ elseif executable('python') |
        \   call repel#set_repl('python') |
        \ end
aug END
