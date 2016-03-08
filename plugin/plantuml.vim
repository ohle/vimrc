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

function! s:show(type)
    let input=s:getInput(a:type)
    let outfile=tempname()
    silent call system("plantuml -p -tpng >" . outfile, input)
    call netrw#BrowseX(outfile, 0)
endfunction


nnoremap <leader>p :set operatorfunc=<SID>show<cr>g@
vnoremap <leader>p :<c-u>call <SID>show("visual")<cr>
