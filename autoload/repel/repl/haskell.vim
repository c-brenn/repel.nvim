function! repel#repl#haskell#clear(...) dict
  let clear_cmd = repel#repl#helpers#system_clear()
  call self.do([":! ".clear_cmd."\n"])
endfunction

function! repel#repl#haskell#load_file(path,...) dict
  let relative_path = repel#repl#helpers#path_with_default(a:path)
  call self.do([":l ".expand(relative_path)."\n"])
endfunction
