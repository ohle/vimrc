if exists("g:loaded_plantuml_run") || &cp || v:version < 700
    finish
endif
let g:loaded_plantuml_run = 1

" Surround text by @startuml/@enduml if not already done
function! s:surround(text)
    if stridx(a:text, '@startuml') == 0
        return a:text
    endif
    return "@startuml\n" . a:text . "\n@enduml"
endfunction

function! s:getInput(type)
    call s:select(a:type)
    normal y
    return s:surround(@@)
endfunction

function! s:select(type)
    if a:type ==# 'visual'
        execute "normal! `<v`>"
    else
        execute "normal! `[v`]"
    endif
endfunction

function! s:show(type)
    let input=s:getInput(a:type)
    let outfile=tempname()
    silent call system("plantuml -p -tpng >" . outfile, input)
    call netrw#BrowseX(outfile, 0)
endfunction

function! s:convert(type)
    let input=s:getInput(a:type)
    let outfile=tempname()
    silent call system("plantuml -p -tutxt >" . outfile, input)
    execute "read " . outfile
endfunction



nnoremap <leader>u :set operatorfunc=<SID>show<cr>g@
vnoremap <leader>u :<c-u>call <SID>show("visual")<cr>

nnoremap <leader>U :set operatorfunc=<SID>convert<cr>g@
vnoremap <leader>U :<c-u>call <SID>convert("visual")<cr>
