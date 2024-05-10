autocmd BufRead,BufNewFile *.bbb call BlackBubble()

function! BlackBubble()
  set filetype=blackbubble
  call Mappings()
  if !empty(glob("bbb.vim"))
    source bbb.vim
  endif
endfunction

function! Mappings()
  nnoremap <Leader><Leader> :rew<CR>
  nnoremap <silent> <Right> :n<CR>
  nnoremap <silent> <Left> :N<CR>
  nnoremap <Leader>t1 :.!toilet -f mono9<CR>
  nnoremap <Leader>t2 :.!toilet -f smblock<CR>
  nnoremap <Leader>t3 :.!toilet -f future<CR>
  nnoremap <Leader>b1 :.!toilet -f term -F border<CR>
  nnoremap <silent> <Leader>co :call ColorizeWord()<CR>
  nnoremap <silent> <Leader>em :call EmphasizeWord()<CR>
  nnoremap <silent> <Leader>it :call ItalicizeWord()<CR>
  nnoremap <silent> <Leader>ul :call UnderlineWord()<CR>
endfunction

function! ColorizeWord()
  let current_word = expand ("<cword>")
  let word_color = inputlist(['Color:', '1. Red', '2. Green', '3. Yellow',
      \'4. Blue', '5. Magenta', '6. Cyan', '7. Gray'])
  execute '!echo -e "syn match ' . current_word . 'colorize \"' . current_word . '\"\nhi ' . current_word .'colorize ctermfg=' . word_color . '" >> bbb.vim'
  source bbb.vim
endfunction

function! EmphasizeWord()
  let current_word = expand ("<cword>")
  execute '!echo -e "syn match ' . current_word . 'emphasize \"' . current_word . '\"\nhi ' . current_word .'emphasize cterm=bold" >> bbb.vim'
  source bbb.vim
endfunction

function! ItalicizeWord()
  let current_word = expand ("<cword>")
  execute '!echo -e "syn match ' . current_word . 'italicize \"' . current_word . '\"\nhi ' . current_word .'italicize cterm=italic" >> bbb.vim'
  source bbb.vim
endfunction

function! UnderlineWord()
  let current_word = expand ("<cword>")
  execute '!echo -e "syn match ' . current_word . 'underline \"' . current_word . '\"\nhi ' . current_word .'underline cterm=underline" >> bbb.vim'
  source bbb.vim
endfunction
