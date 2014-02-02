" Always update the location list after a syntax check
let g:syntastic_always_populate_loc_list=1

" select and configure checkers
" scala
let g:syntastic_scala_checkers=['fsc']
" javascript
let g:syntastic_javascript_checkers=['jslint']
let g:syntastic_javascript_jslint_conf = "--undef --regexp --plusplus"

" mapping for manual syntax checking
nmap <leader>s :SyntasticCheck<cr>
