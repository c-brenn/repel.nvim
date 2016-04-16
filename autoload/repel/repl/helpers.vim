function! repel#repl#helpers#system_clear()
  for cmd in ["clear", "cls"]
    if executable(cmd)| return cmd | endif
  endfor
  return ""
endfunction

function! repel#repl#helpers#path_with_default(args)
  if empty(a:args) || empty(a:args[0])
    return expand("%")
  else
    return a:args[0]
  endif
endfunction
