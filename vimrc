" An example for a vimrc file.
" vim:foldmethod=marker ts=4
"
" Maintainer: Bram Moolenaar <Bram@vim.org>
" Last change:  2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"       for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"     for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set sm "showmatch (Klammern)
set aw "autowrite
set ar "autoread a changed file
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"keep backups
set backup    " keep a backup file
set backupdir=~/.vim/backupfiles
" directory for swap files (default has highest priority for '.')
set dir=~/tmp,/var/tmp,/tmp/,.

set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set scrolloff=1   " keep a line above/below when scrolling
set showcmd       " display incomplete commands
set wildmenu      " completion in window
set wildmode=longest,list,full " Tab-completion for filenames bash-style
set textwidth=80
set colorcolumn=+1
set cursorline
set winheight=5 " minimal height

syntax on       " syntax highlighting
set background=dark
set incsearch   " do incremental searching
set hlsearch    " search highlighting
set conceallevel=2
"C-N to clear search highlighting
nnoremap <silent> <C-N> :silent noh<CR>

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

  " rerun filetype detection on write
  augroup filetype_detect_on_rename
    autocmd!
    autocmd BufFilePost * filetype detect
  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")


set grepprg=grep\ -nH\ $*



" Tab policy: 4 spaces, always expand to spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4

" always change current dir to dir of currently edited file
" set autochdir

" thesaurus and dictionary
set thesaurus+=~/.vim/mthesaur.txt
set dictionary+=/usr/share/dict/words
set noinfercase
set ignorecase
set smartcase
"set iskeyword+=32,-

set nrformats=hex " no octal, please

" Activate skim for pdfsync
map ,v :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
map ,p :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
map ,m :w<CR>:silent !make <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR><CR>
" Reactivate VIM
map ,r :w<CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>
map ,t :w<CR>:silent !pdflatex -synctex=1 --interaction=nonstopmode %:p <CR>:silent !/Applications/Skim.app/Contents/SharedSupport/displayline -r <C-r>=line(".")<CR> %<.pdf %<CR>:silent !osascript -e "tell application \"MacVim\" to activate" <CR><CR>

" open URLs in chrome via <C-L>
if has("mac")
  nnoremap <C-L> yiW:!open <c-r>"&<cr>
else
  nnoremap <C-L> yiW:!google-chrome <c-r>"&<cr>
endif

filetype plugin indent on

" Manage plugins with vimplug
call plug#begin('~/.vim/bundle') " {{{
    Plug 'bkad/CamelCaseMotion'
    Plug 'mileszs/ack.vim'
    Plug 'tpope/vim-afterimage', { 'for': [ 'png', 'gif' ] }
    Plug 'corntrace/bufexplorer'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
    Plug 'tpope/vim-fugitive'
    Plug 'jaxbot/github-issues.vim'
    Plug 'sjl/gundo.vim'
    Plug 'Shougo/javacomplete', { 'for': 'java' }
    Plug 'leshill/vim-json', { 'for': 'json' }
    Plug 'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex', { 'for': 'json' }
    Plug 'tpope/vim-markdown', { 'for': ['markdown', 'md', 'mkd'] }
    Plug 'tmhedberg/matchit'
    Plug 'tpope/vim-projectionist'
    Plug 'tpope/vim-repeat'
    Plug 'mdreves/vim-scaladoc', { 'for': 'scala' }
    Plug 'tpope/vim-sleuth'
    Plug 'altercation/vim-colors-solarized'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/syntastic'
    Plug 'junegunn/vim-easy-align'
    Plug 'kana/vim-textobj-lastpat'
    Plug 'kana/vim-textobj-user'
    Plug 'SirVer/ultisnips'
    Plug 'tpope/vim-vinegar'
    Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
    Plug 'vim-scripts/ZoomWin'
    Plug 'redacted/surface-evolver-vim', { 'for': 'evolver' }
    Plug 'lukerandall/haskellmode-vim', { 'for': 'haskell' }
    Plug 'derekwyatt/vim-scala', { 'for': 'scala' }
    Plug 'fmoralesc/vim-pad', { 'on': 'Pad', 'branch': 'devel' }
    Plug 'airblade/vim-gitgutter'
    Plug 'bling/vim-airline'
    Plug 'scrooloose/vim-statline'
    Plug 'gregsexton/gitv'
    Plug 'tpope/vim-unimpaired'
    Plug 'pangloss/vim-javascript'
    Plug 'craigemery/vim-autotag'
    Plug 'ohle/vim-moin'
    Plug 'kablamo/vim-git-log'
    Plug 'sfiera/vim-emacsmodeline'
    " Plug '~/.vim/bundle/vim-sbt' " TODO: Move to external dir
    Plug 'groenewege/vim-less', { 'for': 'less' }
call plug#end() " }}}

"let g:solarized_termcolors=256
colorscheme solarized
highlight clear SignColumn

" Enable mouse in terminal mode (for resizing splits etc.)
set mouse=a

" persistent undo
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=10000

set path=,,.,$PWD/src/**,$PWD/WebContent/**,$PWD/doc/**
set tags=tags,$PWD/src/tags,./tags

" tagfile handling
" tagfiles are called "tags" and are found by searching upwards from the
" current file's dir.
" Some filetypes get an autocommand to update the tagsfile in the background {{{
" set tags=tags;
function UpdateTagsFile()
  let tagfile = &tags
  if (strlen(tagfile) == 0)
    return
  endif
  let prefix = ""
  if (strpart(tagfile,0,1) ==# "/")
    let prefix="/"
  endif
  let tagpathcomponents = split(tagfile, "/")
  call remove(tagpathcomponents, -1)
  let tagpath = prefix . join(tagpathcomponents, "/")
  call system("cd " . tagpath . " && ctags -R -f tags.new . && mv tags.new tags &")
endfunction

nnoremap <leader>t call UpdateTagsFile()
"autocmd FileType {c,cpp,js,java,groovy,perl,scala} autocmd BufWritePost <buffer> call UpdateTagsFile()
"}}}

" whitespace display
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" marker for wrapped lines
let &showbreak="↪ "
if has('nvim')
  set breakindent
endif

" MAPPINGS {{{
" set this window's working directory to open file's parent
command Cd lcd %:p:h

let mapleader = ","

" Make Y behave like D and C
noremap Y y$

" shortcuts for dispatch.vim
nnoremap <leader>D :Dispatch<cr>
nnoremap <leader>S :Start<cr>

" user arrow keys for line-by-line scrolling
noremap <down> <c-e>
noremap <up> <c-y>

" split navigation
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" jk to leave insert mode
inoremap jk <Esc>

" duplicate current line and comment out one copy with commentary
nnoremap <leader>cd yyp:Commentary<cr>k
" toggle commented state of this line and the one below
nnoremap <leader>cj :Commentary<cr>j:Commentary<cr>k
" toggle commented state of this line and the one above
nnoremap <leader>ck :Commentary<cr>k:Commentary<cr>j

nnoremap <leader>q :call QuickFixToggle()<cr>
" quickfix toggle helper function {{{
let g:quickfix_is_open = 0
function! QuickFixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction
"}}}

" vim-pad
nnoremap <leader>pl :Pad ls<cr>
nnoremap <leader>ps :Pad new<cr>
nnoremap <leader>pt :Pad this<cr>

" Easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap ga      <Plug>(EasyAlign)
" }}}

"Calculations: pipe visually selected area through bc {{{
vnoremap <leader>bc "ey:call CalcBc()<CR>
function! CalcBc()
  let has_equal=0
  "remove newlines and trailing spaces
  let @e = substitute(@e, "\n", "", "g")
  let @e = substitute(@e, '\s*#', "", "g")
  " if we end with an equals sign, strip, and remember for output
  if @e =~ "=$"
    let @e = substitute(@e, '=$', "", "")
    let has_equal=1
  endif
  " use bc function names
  let @e = substitute(@e, '\csin\s*(', "s (", "")
  let @e = substitute(@e, '\ccos\s*(', "c (", "")
  let @e = substitute(@e, '\catan\s*(', "a (", "")
  let @e = substitute(@e, '\cln\s*(', "l (", "")
  " escape chars for shell
  let @e = escape(@e, '*()')
  " run bc, strip newline
  let answer = substitute(system("echo " . @e . " \| bc -l"), "\n", "", "")
  "append answer or echo
  if has_equal == 1
    normal `>
    exec "normal a" . answer
  else
    echo "answer = " . answer
  endif
endfunction
"}}}

let s:browserpath = system("bash -c 'which google-chrome'")

let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'java', 'python', 'latex', 'moinmoin']
" Plugin options {{{

" brolink
let g:bl_no_mappings=1
let g:bl_pagefiletypes = ['html', 'javascript', 'php', 'markdown']
vnoremap <silent><Leader> bj :BLEvaluateSelection<CR>
nnoremap <silent><Leader> bj :BLEvaluateBuffer<CR>

" UltiSnips
" most terminals don't forward <c-tab>
let g:UltiSnipsListSnippets = '<s-tab>'
let g:UltiSnipsEditSplit = 'horizontal'

" github-issues
runtime github-access-token.vim " g:github_access_token outsourced for security reasons

" projectionist heuristics
let g:projectionist_heuristics =
      \{
      \ "build.xml&src/main/" : {
      \     "src/main/*.java" : {
      \         "type": "source"
      \     },
      \     "src/main/*.groovy": {
      \         "type": "source"
      \     },
      \     "*": {
      \         "make": "ant",
      \         "start": "ant run"
      \     }
      \ }
      \}


" bufexplorer
let g:bufExplorerShowRelativePath=1
let g:bufExplorerShowTabBuffer=1

" gundo
nnoremap <leader>u :GundoToggle<CR>

" javacomplete
setlocal omnifunc=javacomplete#Complete
" setlocal completefunc=javacomplete#CompleteParamsInfo

" Synsastic
" disable for scala, since scala compilers are slow and sbt-quickfix does
" basically the same thing but asynchronously
let g:syntastic_mode_map =
            \ { 'mode': 'active',
                    \ 'active_filetypes': [],
                    \ 'passive_filetypes': ['sbt', 'scala']
                \}
" Always update the location list after a syntax check
let g:syntastic_always_populate_loc_list=1

" Configure checkers for filetypes
let g:syntastic_python_checkers = ['pyflakes']

" SLIME
let g:slime_target = "tmux"

" Vim-pad
let g:pad#dir = expand('~/Dropbox/vimpad')
let g:pad#local_dir = 'notes'
let g:pad#use_default_mappings = 0
let g:pad#default_file_extension = '.md'
let g:pad#default_format = 'mkd'
let g:pad#window_height = 40
let g:pad#highlight_query = 0

" Haskell
let g:haddock_browser=s:browserpath

" airline
let g:airline_powerline_fonts=1
let g:airline#extensions#default#section_truncate_width = {}
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
" }}} Plugin options
