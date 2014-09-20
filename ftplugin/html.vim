if has("mac")
  let b:browsercmd = "open"
else
  let b:browsercmd = "google-chrome"
endif

function! s:fileurl()
  return "file://" . expand("%:p")
endfunction

nnoremap <buffer> <leader>v :call system(b:browsercmd . " " . <SID>fileurl() . " & ")<cr>
