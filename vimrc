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

"keep backups
set backup		" keep a backup file
set backupdir=~/.vim/backupfiles

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set textwidth=78

syntax on     " syntax highlighting
set hlsearch  " search highlighting
"C-N to clear search highlighting
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

" Tab-completion for filenames bash-style
set wildmode=longest,list

" Tab policy: 2 spaces, always expand to spaces
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" always change current dir to dir of currently edited file
set autochdir

" thesaurus and dictionary
set thesaurus+=~/.vim/mthesaur.txt
set dictionary+=/usr/share/dict/words
set noinfercase
set ignorecase
set smartcase
"set iskeyword+=32,-

" Activate skim for pdfsync
map ,v :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
map ,p :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
map ,m :w<CR>:silent !make <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
" Reactivate VIM
map ,r :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>
map ,t :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>

filetype plugin indent on

execute pathogen#infect()
