if !has('nvim')
  finish
endif

let g:neoshell = {'repl': {}}

aug neoshell_setup
  au!
  au TermOpen term://*neoshell* setlocal nonumber norelativenumber
aug END

function! neoshell#repl_open()
  let dir = getcwd()

  if !has_key(g:neoshell.repl, s:repl_key(dir))
    call s:open_new_repl(dir)
    return ''
  endif
  
  let repl = g:neoshell.repl[s:repl_key(dir)]
  call s:open_existing_repl(repl)
endfunction

let s:open_cmd = "botright 15 split"
function! s:repl_key(dir)
  return a:dir . g:neoshell_repl
endfunction

function! s:open_new_repl(dir)
  let repl = g:neoshell_repl
  exec s:open_cmd
  enew
  call termopen(repl . ';#neoshell')
  startinsert
  let g:neoshell.repl[s:repl_key(a:dir)] = { 'buffer': bufnr('%'), 'dir': a:dir }
endfunction

function! s:open_existing_repl(repl)
  if !bufexists(a:repl.buffer)
    call s:open_new_repl(a:repl.dir)
    return ''
  endif

  let repl_window = bufwinnr(a:repl.buffer)
  if repl_window == -1
    exec s:open_cmd . " +buffer" . a:repl.buffer
  else
    exec repl_window . "wincmd w"
  endif
  startinsert
endfunction

function! neoshell#repl_add(repl)
  let g:neoshell_repl = a:repl
endfunction
