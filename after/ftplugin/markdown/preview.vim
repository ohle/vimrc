" Language: Markdown
" Author:   joclaussen@gmail.com
"
" automatically translate to html on write, looking for a suitable css file to
" include. Also refresh browser if browserlink is installed.

if exists('b:did_markdown_preview_ftplugin')
    finish
endif
let b:did_markdown_preview_ftplugin = 1

if !exists('g:markdown_preview_browser')
    let g:markdown_preview_browser = 'google-chrome'
endif

let s:basedir = expand('%:p:h')
let s:basename = expand('%:t:r')

" find a suitable css file from a list of candidate file names, looking up to
" one subdirectory deep from the current directory, and falling back to a
" built-in default
let b:cssFiles = [ s:basename.'.css', 'markdown.css', 'style.css', 'styles.css' ]
call    map(b:cssFiles, 'findfile(v:val, "**1")')
call    add(b:cssFiles, expand('<sfile>:p:h') . '/markdown.css') " fallback
call filter(b:cssFiles, 'v:val != ""')
let b:cssFile = b:cssFiles[0]

let b:htmlFile = '/tmp/'.s:basename.'-preview.html'

if !exists("*s:MarkdownPreviewCompile")
    function s:MarkdownPreviewCompile()
        call system('pandoc -c '.b:cssFile.' '.expand('%:p').' -o '.b:htmlFile)
    endfunction
endif

if !exists("*s:MarkdownPreview")
    function s:MarkdownPreview()
        call s:MarkdownPreviewCompile()
        call system(g:markdown_preview_browser . " " . b:htmlFile . "&")
    endfunction
endif

" commands
command -buffer MarkdownPreviewCompile call s:MarkdownPreviewCompile()
command -buffer MarkdownPreview call s:MarkdownPreview()

autocmd BufWritePost <buffer> :MarkdownPreviewCompile

" mappings
if (!hasmapto('<Plug>OpenMarkdownPreview'))
    map <buffer> <unique> <LocalLeader>P <Plug>OpenMarkdownPreview
endif
nnoremap <buffer> <unique> <Plug>OpenMarkdownPreview :MarkdownPreview<cr>

" browserlink integration
if exists(':BLReloadPage')
    autocmd BufWritePost <buffer> :BLReloadPage
endif
