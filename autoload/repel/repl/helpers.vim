function! repel#repl#helpers#system_clear()
  for cmd in ["clear", "cls"]
    if executable(cmd)| return cmd | endif
  endfor
  return ""
endfunction
