autocmd BufRead,BufNewFile *.bbb call BlackBubble()

function BlackBubble()

	set filetype=blackbubble

	if !empty(glob("%.vim"))
		source %.vim
	endif

	set foldtext=v:folddashes | highlight Folded ctermfg=239

	nnoremap <buffer> <Leader>t1 :.!toilet -f mono9<CR>
	nnoremap <buffer> <Leader>t2 :.!toilet -f smblock<CR>
	nnoremap <buffer> <Leader>t3 :.!toilet -f future<CR>
	nnoremap <buffer> <Leader>b1 :.!toilet -f term -F border<CR>

	nnoremap <buffer> <Leader><Leader> {zfgg}zfGk
	nnoremap <buffer> <silent> <Right> zE}zfgg}zfGk
	nnoremap <buffer> <silent> <Left> zE{{zfgg}zfGk

	function WordColorize()
		let current_word = expand ("<cword>")
		let word_color = inputlist(['Color:', '1. Red', '2. Green', '3. Yellow',
				\'4. Blue', '5. Magenta', '6. Cyan', '7. Gray'])
		execute '!echo -e "syn match ' . current_word . 'icolorize \"' . current_word . '\"\nhi ' . current_word .'icolorize ctermfg=' . word_color . '" >> %.vim'
		source %:p.vim
	endfunction

	function WordEmphasize()
		let current_word = expand ("<cword>")
		execute '!echo -e "syn match ' . current_word . 'emphasize \"' . current_word . '\"\nhi ' . current_word .'emphasize cterm=bold" >> %.vim'
		source %:p.vim
	endfunction

	function WordItalicize()
		let current_word = expand ("<cword>")
		execute '!echo -e "syn match ' . current_word . 'italicize \"' . current_word . '\"\nhi ' . current_word .'italicize cterm=italic" >> %.vim'
		source %:p.vim
	endfunction

	function WordUnderline()
		let current_word = expand ("<cword>")
		execute '!echo -e "syn match ' . current_word . 'underline \"' . current_word . '\"\nhi ' . current_word .'underline cterm=underline" >> %.vim'
		source %:p.vim
	endfunction

	nnoremap <buffer> <silent> <Leader>co :call WordColorize()<CR>
	nnoremap <buffer> <silent> <Leader>em :call WordEmphasize()<CR>
	nnoremap <buffer> <silent> <Leader>it :call WordItalicize()<CR>
	nnoremap <buffer> <silent> <Leader>ul :call WordUnderline()<CR>

endfunction
