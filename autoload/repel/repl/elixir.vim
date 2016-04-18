function! repel#repl#elixir#clear(...) dict
  call self.do(["clear\n"])
endfunction

function! repel#repl#elixir#load_file(path, ...) dict
  let relative_path = repel#repl#helpers#path_with_default(a:path)
  call self.do(["c(\"".expand(relative_path)."\")\n"])
endfunction

function! repel#repl#elixir#test_runner(...)
  return 'mix test'
endfunction

function! repel#repl#elixir#in_test_file(file,...)
  return a:file =~# '_test\.exs$'
endfunction

function! repel#repl#elixir#nearest_cmd()
  let file_with_line = expand("%").":".line(".")
  return repel#repl#elixir#test_runner()." ".file_with_line
endfunction
