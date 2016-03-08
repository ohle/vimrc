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

function! Convert(type)
    if a:type == 'v'
        execute "normal! `<v`>y"
    else
        execute "normal! `[v`]y"
    endif
    let input=s:surround(@@)
    let outfile=tempname()
    silent call system("plantuml -p -tpng >" . outfile, input)
    call netrw#BrowseX(outfile, 0)
endfunction

nnoremap <leader>p :set operatorfunc=Convert<cr>g@
vnoremap <leader>p :<c-u>call Convert(visualmode())<cr>
