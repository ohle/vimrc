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

" system dependent settings
runtime 'python_host.vim'

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
set backupdir=~/.config/nvim/backupfiles
" directory for swap files (default has highest priority for '.')
set dir=~/tmp,/var/tmp,/tmp/,.

set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
if exists("g:gui_oni")
    set scrolloff=0 " workaround for ONI bug: https://github.com/extr0py/oni/issues/395
else
    set scrolloff=1   " keep a line above/below when scrolling
endif

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
set number
set relativenumber

if has('nvim')
    au TermOpen * setlocal nonumber
endif

set noequalalways

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
set expandtab

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
set formatoptions+=j

set clipboard=unnamed

" open URLs in chrome via <C-L>
if has("mac")
  nnoremap <C-L> yiW:!open <c-r>"&<cr>
else
  nnoremap <C-L> yiW:!google-chrome <c-r>"&<cr>
endif

filetype plugin indent on

" Use @ in visual mode to apply macro to matching selected lines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Manage plugins with vimplug
call plug#begin('~/.vim/bundle') " {{{
    Plug 'mhinz/vim-grepper'
    Plug 'tpope/vim-afterimage', { 'for': [ 'png', 'gif' ] }
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-dispatch'
    Plug 'radenling/vim-dispatch-neovim'
    Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
    Plug 'tpope/vim-salve'
    Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
    Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
    Plug 'tpope/vim-fugitive'
    Plug 'sjl/gundo.vim'
    Plug 'leshill/vim-json', { 'for': 'json' }
    Plug 'tpope/vim-markdown', { 'for': ['markdown', 'md', 'mkd'] }
    Plug 'tmhedberg/matchit'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-speeddating'
    Plug 'tpope/vim-surround'
    Plug 'kana/vim-textobj-lastpat'
    Plug 'kana/vim-textobj-user'
    Plug 'SirVer/ultisnips'
    Plug 'justinmk/vim-dirvish'
    Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
    Plug 'redacted/surface-evolver-vim', { 'for': 'evolver' }
    Plug 'lukerandall/haskellmode-vim', { 'for': 'haskell' }
    Plug 'airblade/vim-gitgutter'
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/vim-statline'
    Plug 'gregsexton/gitv'
    Plug 'tpope/vim-unimpaired'
    Plug 'pangloss/vim-javascript'
    Plug 'craigemery/vim-autotag'
    Plug 'ohle/vim-moin'
    Plug 'kablamo/vim-git-log'
    Plug 'sfiera/vim-emacsmodeline'
    Plug 'ohle/underscore-templates.vim'
    Plug 'groenewege/vim-less', { 'for': 'less' }
    Plug 'tpope/vim-eunuch'
    Plug 'terryma/vim-expand-region'
    Plug 'embear/vim-localvimrc'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'leafgarland/typescript-vim'
    Plug 'tpope/vim-scriptease'
    if exists('g:nyaovim_version')
        Plug 'rhysd/nyaovim-popup-tooltip'
        Plug 'rhysd/nyaovim-markdown-preview'
    endif
    Plug 'romainl/flattened'
    Plug 'justinmk/vim-sneak'
    Plug 'aklt/plantuml-syntax'
    Plug 'tommcdo/vim-lion'
    Plug 'jimsei/winresizer'
    if has('nvim')
        Plug 'tpope/vim-projectionist' " Projectionist seems to throw errors on normal vim
        Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
        Plug 'autozimu/LanguageClient-neovim', { 'do': 'UpdateRemotePlugins' }
    endif
    Plug 'davidhalter/jedi-vim'
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-lua-ftplugin'
    Plug 'wellle/targets.vim'
    Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    Plug 'tbabej/taskwiki'
    Plug 'vim-scripts/MultipleSearch'
    Plug 'xtal8/traces.vim'
    Plug 'kopischke/vim-fetch'
    Plug 'ohle/vmux'
    Plug 'w0rp/ale'
call plug#end() " }}}

"let g:solarized_termcolors=256
colorscheme flattened_dark
highlight clear SignColumn

"{{{ Solarized-dark terminal colors (mostly for NyaoVim)
let g:terminal_color_0  = '#073642'
let g:terminal_color_1  = '#dc322f'
let g:terminal_color_2  = '#859900'
let g:terminal_color_3  = '#b58900'
let g:terminal_color_4  = '#268bd2'
let g:terminal_color_5  = '#d33682'
let g:terminal_color_6  = '#2aa198'
let g:terminal_color_7  = '#eee8d5'
let g:terminal_color_8  = '#002b36'
let g:terminal_color_9  = '#cb4b16'
let g:terminal_color_10 = '#586e75'
let g:terminal_color_11 = '#657b83'
let g:terminal_color_12 = '#839496'
let g:terminal_color_13 = '#6c71c4'
let g:terminal_color_14 = '#93a1a1'
let g:terminal_color_15 = '#fdf6e3'
"}}}
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
  set guicursor=
endif

" MAPPINGS {{{
" set this window's working directory to open file's parent
command Cd lcd %:p:h

let mapleader = ","
let maplocalleader = ","

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

if has("nvim")
    tnoremap <leader>h <c-\><c-n><c-w>h
    tnoremap <leader>j <c-\><c-n><c-w>j
    tnoremap <leader>k <c-\><c-n><c-w>k
    tnoremap <leader>l <c-\><c-n><c-w>l

    tnoremap <Esc> <c-\><c-n>
endif

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


" Window zooming
function! s:ZoomToggle() abort
  if exists('t:zoomed') && t:zoomed
    execute t:zoom_winrestcmd
    let t:zoomed = 0
  else
    let t:zoom_winrestcmd = winrestcmd()
    resize
    vertical resize
    let t:zoomed = 1
  endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-W>z :ZoomToggle<CR>

" grepper
nmap gs <plug>Grepper
vmap gs <plug>Grepper

" expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
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

let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'java', 'python', 'tex', 'moin', 'clojure', 'plantuml']
" Plugin options {{{

" ALE
let g:ale_sign_error = '✗'
let g:ale_sign_warning = 'i'

" netrw
let g:netrw_altfile = 1

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


" gundo
nnoremap <leader>u :GundoToggle<CR>

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
let g:airline_theme='solarized'
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

" fireplace
" Enable starting a leiningen repl outside a project for files in /tmp
autocmd User FireplacePreConnect call fireplace#register_port_file(expand('~/.lein/repl-port'), '/tmp')

" ipython
let g:ipy_perform_mappings = 0
map  <buffer> <silent> <C-Return>     <Plug>(IPython-RunFile)
map  <buffer> <silent> <C-s>          <Plug>(IPython-RunLine)
imap <buffer> <silent> <C-s>          <C-o><Plug>(IPython-RunLine)
xmap <buffer> <silent> <C-S>          <Plug>(IPython-RunLines)
xmap <buffer> <silent> <M-s>          <Plug>(IPython-RunLinesAsTopLevel)

" grepper
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" winresizer
let g:winresizer_vert_resize=1
let g:winresizer_horiz_resize=1

" sneak
let g:sneak#streak = 1
let g:sneak#map_netrw = 0

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni#functions = {} " to be filled by other plugin options

" NotationalVelocity
let g:nv_directories = ['~/Dropbox/vimpad']

" LangueageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'python': [ '/usr/local/bin/pyls' ]
    \}

" lua
let g:lua_check_syntax = 0
let g:lua_complete_omni = 1
let g:lua_complete_dynamic = 0
let g:lua_define_completion_mappings = 0
let g:deoplete#omni#functions.lua = 'xolox#lua#omnifunc'

" vimwiki
let g:vimwiki_list = [{'path': '~/vimwiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]

" fugitive
" Recognize empty buffers
autocmd BufWinEnter * if empty(expand('<afile>'))|call fugitive#detect(getcwd())|endif
" Recognize directory buffers
autocmd FileType netrw call fugitive#detect(@%)
autocmd FileType dirvish call fugitive#detect(@%)
command -nargs=* Glg Git! log --graph --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>

" }}} Plugin options
"
if has('mac')
    let s:browse_cmd = 'open'
else
    let s:browse_cmd = 'xdg-open'
endif

if has('nvim')
    set inccommand=split
endif

command BrowseBug call system(s:browse_cmd . ' https://bugzilla.berlin.jpk.com/show_bug.cgi?id=' . expand('<cword>'))
" command BrowseBug call system(s:browse_cmd . expand(' https://bugzilla.berlin.jpk.com/show_bug.cgi?id=<cword>'))
nnoremap gb :BrowseBug<cr>

" }}}

let $PAGER=''

runtime local-settings.vim
