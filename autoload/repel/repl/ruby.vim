function! repel#repl#ruby#clear(...) dict
  let clear_cmd = repel#repl#helpers#system_clear()
  call self.do(["system \"".clear_cmd."\"\n"])
endfunction

function! repel#repl#ruby#load_file(...) dict
  call self.do(["require_relative '".expand("%")."'\n"])
endfunction
