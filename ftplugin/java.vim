if exists('g:ftplugin_java_loaded')
	finish
endif
let g:ftplugin_java_loaded = 1

" quickfix options for ant and javac
set makeprg=ant\ -emacs\ -q\ -find\ build.xml
set efm=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
