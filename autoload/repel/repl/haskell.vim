function! repel#repl#haskell#clear(...) dict
  let clear_cmd = repel#repl#helpers#system_clear()
  call self.do([":! ".clear_cmd."\n"])
endfunction

function! repel#repl#haskell#load_file(...) dict
  call self.do([":l ".expand("%")."\n"])
endfunction
