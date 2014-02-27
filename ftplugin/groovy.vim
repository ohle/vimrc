" quickfix options for ant and javac
set makeprg=ant\ -emacs\ -q\ -find\ build.xml
set efm=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
