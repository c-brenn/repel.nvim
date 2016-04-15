if !has('nvim') || exists('g:loaded_repel')
  finish
endif
let g:loaded_repel = 1

function! repel#set_repl(repl)
  let b:repl_cmd = a:repl
endfunction

command! ReplOpen call repel#open_repl()
command! ReplShow call s:generic_repl_function(tolower('show'))
command! ReplHide call s:generic_repl_function(tolower('hide'))

function! repel#open_repl()
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
  call repl.open()
endfunction

function! s:generic_repl_function(func)
  if !exists('b:repl_cmd')
    echom "No repl for current file :("
    return ''
  endif

  if s:repl_exists()
    let repl = s:lookup_repl()
    call repl[a:func]()
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

let g:repel = {'repls': {}, 'id': 0}

function! s:new_repl(dir)
  let g:repel.id += 1
  return { 'key': s:key(a:dir),
        \  'command': b:repl_cmd,
        \  'dir': a:dir,
        \  'open': function('<sid>repl_open'),
        \  'switch': function('<sid>repl_switch'),
        \  'hide': function('<sid>repl_hide'),
        \  'show': function('<sid>repl_show'),
        \  'id': g:repel.id,
        \}
endfunction

function! s:key(dir)
  return a:dir . b:repl_cmd
endfunction

let s:open_cmd = "botright 15 split"

function! s:repl_open() dict
  if has_key(self, 'buffer') && bufexists(self.buffer)
    call self.switch()
  else
    exec s:open_cmd
    enew
    call termopen(self.command . ';#repel')
    startinsert
    let self.buffer = bufnr('%')
    let b:repl_cmd = self.command
  endif
endfunction

function! s:repl_switch() dict
  let repl_window = bufwinnr(self.buffer)
  if repl_window == -1
    exec s:open_cmd . " +buffer" . a:self.buffer
  else
    exec repl_window . "wincmd w"
  endif
  startinsert
endfunction

function! s:repl_hide() dict
  let repl_window = bufwinnr(self.buffer)
  if repl_window != -1
    exec repl_window . "close"
  endif
endfunction

function! s:repl_show() dict
  let repl_window = bufwinnr(self.buffer)
  if repl_window == -1
    exec s:open_cmd . " +buffer" . self.buffer
    wincmd w
  endif
endfunction
