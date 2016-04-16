function! repel#repl#ruby#clear(...) dict
  let clear_cmd = repel#repl#helpers#system_clear()
  call self.do(["system \"".clear_cmd."\"\n"])
endfunction

function! repel#repl#ruby#load_file(path,...) dict
  let relative_path = repel#repl#helpers#path_with_default(a:path)
  call self.do(["require_relative '".expand(relative_path)."'\n"])
endfunction
