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
    if a:type ==# 'visual'
        execute "normal! `<v`>y"
    else
        execute "normal! `[v`]y"
    endif
    return s:surround(@@)
endfunction

function! s:showImage(type)
    let input=s:getInput(a:type)
    let outfile=tempname()
    silent call system("plantuml -p -tpng >" . outfile, input)
    call netrw#BrowseX(outfile, 0)
endfunction

function! s:showText(type)
    let input=s:getInput(a:type)
    let outfile=tempname()
    silent call system("plantuml -p -tutxt >" . outfile, input)
    execute "pedit " . outfile
endfunction



nnoremap <leader>U :set operatorfunc=<SID>showImage<cr>g@
vnoremap <leader>U :<c-u>call <SID>showImage("visual")<cr>

nnoremap <leader>u :set operatorfunc=<SID>showText<cr>g@
vnoremap <leader>u :<c-u>call <SID>showText("visual")<cr>
