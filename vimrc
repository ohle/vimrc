" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set sm "showmatch (Klammern)
set aw "autowrite
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set textwidth=78

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.

" if &term =~ "xterm"
"	 if has ("terminfo")
"		 set t_Co=8
"		 set t_Sf=[3%p1%dm
"		 set t_Sb=[4%p1%dm
"	else
"		set t_Co=8
"		set t_Sf=[3%dm
"		set t_Sb=[4%dm
"	endif
"endif

  syntax on
  set hlsearch
  nmap <silent> <C-N> :silent noh<CR>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype indent plugin on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


set grepprg=grep\ -nH\ $*

 " Build ctags database recursively
 map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
 map <F11> :TlistToggle<CR>

 let Tlist_WinWidth=50

" Tab-completion for filenames bash-style
set wildmode=longest,list

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=gitcommit

"Surface evolver filetypes
autocmd BufRead,BufNewFile *.fe set filetype=evolver
au! Syntax evolver source ~/.vim/syntax/evolver.vim

"if has("gui_running") 
"	colorscheme darkspectrum
"endif

set autochdir

let g:tex_flavor='latex'

set thesaurus+=/home/ohle/.vim/mthesaur.txt
set dictionary+=/usr/share/dict/words
set noinfercase
set ignorecase
set smartcase
"set iskeyword+=32,-
" Activate skim
map ,v :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
map ,p :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
map ,m :w<CR>:silent !make <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
" Reactivate VIM
map ,r :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>
map ,t :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>

"Haskell stuff
au BufEnter *.hs compiler ghc
:let g:haddock_browser="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
:let g:haddock_docdir="/usr/local/share/doc/ghc/html/"
filetype plugin indent on

execute pathogen#infect()
