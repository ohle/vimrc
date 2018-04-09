" complete function for mutt aliases from ~/.mutt/aliases
" Yes, the completefunction API requires two completely different sets of
" behavior depending on an argument instead of requiring two functions.
function! CompleteMuttAliases(findstart, base)
	if a:findstart
		" locate start of the word
		let line = getline('.')
		let start = col('.')-1
		while start > 0 && line[start - 1] !~ '\s\|:'
			let start -= 1
		endwhile
		return start
	else
		" find aliases matching with a:base
		let result = []
		let file = expand('~/.mutt/aliases')
		for line_alias in readfile(file)
			let words = split(line_alias, '\s')
			if words[0] == "alias" && len(words) >= 3
				echom 'matching '.a:base.' against '.words[1]
				if words[1] =~ '^' . a:base
					let alias = substitute(join(words[2:-1], ' '), '\\', '', 'g')
					let dict = {
							\ 'word': alias,
							\ 'abbr': words[1],
							\ 'menu': alias
							\ }
					call add(result, dict)
				endif
			endif
		endfor
		return result
	endif
endfunction

setlocal completefunc=CompleteMuttAliases
normal gg}
