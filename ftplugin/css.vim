function! s:FormatBlock()
	" capture block
	normal va{"xy
	let block = @x
	" insert newlines
	let block = substitute(block, "{ *\\ze[^ ]", "{\n", "g")
	let block = substitute(block, "; *\\ze[^ ]", ";\n", "g")
	let @x = block
	" replace in buffer
	normal gv"xp
	" find boundaries
	let start = line('.') + 1
	normal %
	let end = line('.') - 1
	" call commands for formatting and sorting
	execute start.','.end.'Tab /:'
	execute start.','.end.'sort'
	silent execute 'normal! vi{='
	"remove empty lines
	silent execute start.','.end.'g/^$/d'
endfunction

nnoremap <leader>f :call <SID>FormatBlock()<cr>
