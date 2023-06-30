autocmd BufRead,BufNewFile *.bbb call BlackBubble()

function BlackBubble()

	set filetype=blackbubble

	if !empty(glob("%.vim"))
		source %.vim
	endif

	set foldtext=v:folddashes | highlight Folded ctermfg=239

	nnoremap <buffer> <Leader>t1 :.!toilet -f bigmono12<CR>
	nnoremap <buffer> <Leader>t2 :.!toilet -f mono9<CR>
	nnoremap <buffer> <Leader>b1 :.!toilet -f term -F border<CR>

	nnoremap <buffer> <Leader><Leader> {zfgg}zfGk
	nnoremap <buffer> <silent> <Right> zE}zfgg}zfGk
	nnoremap <buffer> <silent> <Left> zE{{zfgg}zfGk

	function IColorize()
		let vword = expand ("<cword>")
		let vcolor = inputlist(['Color:', '1. Red', '2. Green', '3. Yellow',
				\'4. Blue', '5. Magenta', '6. Cyan', '7. Gray'])
		execute '!echo -e "syn match ' . vword . 'icolorize \"' . vword . '\"\nhi ' . vword .'icolorize ctermfg=' . vcolor . '" >> %.vim'
		source %:p.vim
	endfunction

	function Emphasize()
		let vword = expand ("<cword>")
		execute '!echo -e "syn match ' . vword . 'emphasize \"' . vword . '\"\nhi ' . vword .'emphasize cterm=bold" >> %.vim'
		source %:p.vim
	endfunction

	function Italicize()
		let vword = expand ("<cword>")
		execute '!echo -e "syn match ' . vword . 'italicize \"' . vword . '\"\nhi ' . vword .'italicize cterm=italic" >> %.vim'
		source %:p.vim
	endfunction

	function Underline()
		let vword = expand ("<cword>")
		execute '!echo -e "syn match ' . vword . 'underline \"' . vword . '\"\nhi ' . vword .'underline cterm=underline" >> %.vim'
		source %:p.vim
	endfunction

	nnoremap <buffer> <silent> <Leader>co :call IColorize()<CR>
	nnoremap <buffer> <silent> <Leader>em :call Emphasize()<CR>
	nnoremap <buffer> <silent> <Leader>it :call Italicize()<CR>
	nnoremap <buffer> <silent> <Leader>ul :call Underline()<CR>

endfunction
