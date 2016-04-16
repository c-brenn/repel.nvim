function! repel#repl#shell#clear() dict
  let clear_cmd = repel#repl#helpers#system_clear()
  call self.do([clear_cmd."\n"])
endfunction
