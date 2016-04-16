function! repel#repl#elixir#clear(...) dict
  call self.do(["clear\n"])
endfunction

function! repel#repl#elixir#load_file(...) dict
  call self.do(["c(\"".expand("%")."\")\n"])
endfunction
