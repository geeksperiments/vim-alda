if !exists("g:alda_command")
  let g:alda_command = "alda"
endif

function! s:OpenClosableClojureSplitBuffer(cmd)
  vsplit __alda_buffer__
  setlocal buftype=nofile
  " enable 'q' = close buffer
  nnoremap <buffer> q :bd<CR>

  normal! ggdG
  call append(0, ["Parsing score. Please wait..."])
  redraw

  let result = system(a:cmd)

  if v:shell_error == 0
    setlocal filetype=clojure
  endif

  normal! ggdG
  call append(0, split(result, '\v\n'))
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! AldaParseFileIntoLispCode()
  let cmd = g:alda_command . " parse --lisp --file " . bufname("%")
  call <SID>OpenClosableClojureSplitBuffer(cmd)
endfunction

command! AldaParseFileIntoLispCode call AldaParseFileIntoLispCode()
nnoremap <buffer> <localleader>l :call AldaParseFileIntoLispCode()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! AldaParseFileIntoScoreMap()
  let cmd = g:alda_command . " parse --map --file " . bufname("%")
  call <SID>OpenClosableClojureSplitBuffer(cmd)
endfunction

command! AldaParseFileIntoScoreMap call AldaParseFileIntoScoreMap()
nnoremap <buffer> <localleader>m :call AldaParseFileIntoScoreMap()<CR>

