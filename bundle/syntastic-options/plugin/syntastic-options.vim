" disable for scala, since scala compilers are slow and sbt-quickfix does
" basically the same thing but asynchronously
let g:syntastic_mode_map = 
			\ { 'mode': 'active',
					\ 'active_filetypes': [],
					\ 'passive_filetypes': ['sbt', 'scala'] 
				\}
" Always update the location list after a syntax check
let g:syntastic_always_populate_loc_list=1

" select and configure checkers
" scala
" I use sbt-quickfix nowadays
" let g:syntastic_scala_checkers=['fsc']
" javascript
let g:syntastic_javascript_checkers=['jslint']
let g:syntastic_javascript_jslint_args = "--undef --regexp --plusplus --white --vars"
