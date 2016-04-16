if !has('nvim') || exists('g:loaded_repel')
  finish
endif
let g:loaded_repel = 1

let g:repel = { 'repls': {},
              \ 'id': 0}

function! repel#set_repl(type, cmd)
  let b:repl_type = a:type
  let b:repl_cmd = a:cmd
endfunction

" REPL Commands
command! -nargs=* Ropen call repel#open_repl(<q-args>)
command! Rshow call s:generic_repl_function('show')
command! Rhide call s:generic_repl_function('hide')
command! -nargs=+ Rdo call s:generic_repl_function('do', [<q-args>, ""])
command! -range Rsend call s:generic_repl_function('do', s:getLines(<line1>, <line2>))
command! Rclear call s:generic_repl_function('clear')
command! Rload call s:generic_repl_function('load')

" Shell Commands
command! -nargs=* -complete=shellcmd Sopen call repel#open_shell(<q-args>)
command! Sshow call s:generic_shell_function('show')
command! Shide call s:generic_shell_function('hide')
command! -nargs=+ -complete=shellcmd Sdo call s:generic_shell_function('do', [<q-args>, ""])
command! -range Ssend call s:generic_shell_function('do', s:getLines(<line1>, <line2>))
command! Sclear call s:generic_shell_function('clear')

" {{{ REPL

function! repel#open_repl(cmd)
  if !exists('b:repl_cmd')
    echom "No repl for current file :("
    return ''
  endif

  let dir = getcwd()
  let key = s:key(dir)

  if !has_key(g:repel.repls, key)
    let g:repel.repls[key] = s:new_repl(dir)
  endif

  let repl = g:repel.repls[key]
  call repl.open(a:cmd)
  startinsert
endfunction

function! s:generic_repl_function(func, ...)
  if !exists('b:repl_cmd')
    echom "No repl for current file :("
    return ''
  endif

  if s:repl_exists()
    let repl = s:lookup_repl()
    call repl[a:func](a:000)
  else
    echom "No repl for this buffer/project :("
  endif
endfunction

function! s:repl_exists()
  let key = s:key(getcwd())
  return has_key(g:repel.repls, key)
endfunction

function! s:lookup_repl()
  let key = s:key(getcwd())
  return g:repel.repls[key]
endfunction

function! s:new_repl(dir)
  let g:repel.id += 1
  return { 'key': s:key(a:dir),
        \  'command': b:repl_cmd,
        \  'type': b:repl_type,
        \  'dir': a:dir,
        \  'open': function('repel#repl_open'),
        \  'do': function('repel#repl_do'),
        \  'switch': function('repel#repl_switch'),
        \  'hide': function('repel#repl_hide'),
        \  'show': function('repel#repl_show'),
        \  'clear': function('repel#repl#'.b:repl_type.'#clear'),
        \  'load': function('repel#repl#'.b:repl_type.'#load_file'),
        \  'id': g:repel.id,
        \}
endfunction

function! s:key(dir)
  return a:dir . b:repl_cmd
endfunction

let s:open_cmd = "botright 15 split"

function! repel#repl_open(...) dict
  if has_key(self, 'buffer') && bufexists(self.buffer)
    call self.switch()
  else
    exec s:open_cmd
    enew
    let job_id =  termopen(self.command . ';#repel')
    startinsert
    let self.buffer = bufnr('%')
    let self.job_id = job_id
    let b:repl_cmd = self.command
    let b:repl_type = self.type
  endif
  if a:0 > 0 && !empty(a:1)
    call self.do([a:1."\n", ""])
  endif
endfunction

function! repel#repl_switch(...) dict
  let repl_window = bufwinnr(self.buffer)
  if repl_window == -1
    exec s:open_cmd . " +buffer" . self.buffer
  else
    exec repl_window . "wincmd w"
  endif
endfunction

function! repel#repl_hide(...) dict
  let repl_window = bufwinnr(self.buffer)
  if repl_window != -1
    exec repl_window . "close"
  endif
endfunction

function! repel#repl_show(...) dict
  let repl_window = bufwinnr(self.buffer)
  if repl_window == -1
    exec s:open_cmd . " +buffer" . self.buffer
    wincmd w
  endif
endfunction

function! repel#repl_do(args) dict
  if empty(a:args)
    echom "No lines sent to REPL"
    return ''
  endif

  let lines = a:args[0]

  let repl_window = bufwinnr(self.buffer)
  if repl_window == -1
    call self.switch()
  endif
  call jobsend(self.job_id, lines)
  if repl_window == -1
    wincmd p
  endif
endfunction

function! s:getLines(line1, line2)
  return add(getline(a:line1, a:line2), "")
endfunction

" }}}

" {{{ Shell

function! repel#open_shell(cmd)
  if !has_key(g:repel, 'shell')
    let g:repel['shell'] = s:new_shell()
  endif
  let cmd = b:repl_cmd
  let type = b:repl_type
  call g:repel.shell.open(a:cmd)
  startinsert
  let b:repl_cmd = cmd
  let b:repl_type = type
endfunction

function! s:generic_shell_function(func, ...)
  if has_key(g:repel, 'shell')
    call g:repel['shell'][a:func](a:000)
  else
    echom "No shell open :("
  endif
endfunction

function! s:new_shell()
  if !exists('b:repl_cmd')
    let b:repl_type = 'shell'
    let b:repl_cmd = &sh
  endif
  return extend(s:new_repl(""), {"command": &sh, "type": "shell"}, "force")
endfunction

" }}}
