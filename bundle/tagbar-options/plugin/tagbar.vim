nnoremap <c-o> :TagbarToggle<cr>

let g:tagbar_type_groovy = {
      \ 'ctagstype' : 'groovy',
      \ 'kinds' : [
          \ 'p:package',
          \ 'c:class',
          \ 'i:interface',
          \ 'f:function',
          \ 'v:variables'
      \]
    \}

let g:tagbar_type_scala = {
      \ 'ctagstype' : 'Scala',
      \ 'kinds' : [
      \   'c:classes',
      \   'T:types',
      \   'm:methods',
      \   'l:vals',
      \   'v:vars'
      \]
      \}
