autocmd BufRead,BufNewFile *.bbb call BlackBubble()

function! BlackBubble()
  set filetype=blackbubble
  call BBB_Mappings()
  if !empty(glob("bbb.vim"))
    source bbb.vim
  endif
endfunction

function! BBB_Mappings()
  nnoremap <Leader><Leader> :rew<CR>
  nnoremap <silent> <Right> :n<CR>
  nnoremap <silent> <Left> :N<CR>
  nnoremap <Leader>t1 :.!toilet -f mono9<CR>
  nnoremap <Leader>t2 :.!toilet -f smblock<CR>
  nnoremap <Leader>t3 :.!toilet -f future<CR>
  nnoremap <Leader>b1 :.!toilet -f term -F border<CR>
  nnoremap <silent> <Leader>co :call BBB_Color()<CR>
  nnoremap <silent> <Leader>ft :call BBB_Font()<CR>
endfunction

function! BBB_Color()
  let current_line = BBB_GetLine()
  let current_selection = BBB_GetSelection()
  let group_name = BBB_GetGroupname(current_selection)
  let selection_color = inputlist(['Color:',
    \ '1. Red',
    \ '2. Green',
    \ '3. Yellow',
    \ '4. Blue',
    \ '5. Magenta',
    \ '6. Cyan',
    \ '7. Gray'
    \ ])
  if selection_color < 1 || selection_color > 7
    echohl WarningMsg
    echo "\nInvalid color. Please enter a number from 1 to 7."
    echohl None
    return
  endif
  execute '!echo -e "syn match bbb_' . group_name . '_color \"' . current_selection . '\" contained\nsyn match line_' . group_name . '_container \"'. current_line . '\" contains=ALL\nhi bbb_' . group_name .'_color ctermfg=' . selection_color . '" >> bbb.vim'
  source bbb.vim
endfunction

function! BBB_Font()
  let current_line = BBB_GetLine()
  let current_selection = BBB_GetSelection()
  let group_name = BBB_GetGroupname(current_selection)
  let selection_number = inputlist(['Font:',
    \ '1. Bold',
    \ '2. Italic',
    \ '3. Underline'
    \ ])
  if selection_number == 1
    let selection_font = "bold"
  elseif selection_number == 2
    let selection_font = "italic"
  elseif selection_number == 3
    let selection_font = "underline"
  else
    echohl WarningMsg
    echo "\nInvalid font. Please enter a number from 1 to 3."
    echohl None
    return
  endif
  execute '!echo -e "syn match bbb_' . group_name . '_font \"' . current_selection . '\" contained\nsyn match line_' . group_name . '_container \"'. current_line . '\" contains=ALL\nhi bbb_' . group_name .'_font cterm=' . selection_font . '" >> bbb.vim'
  source bbb.vim
endfunction

function BBB_GetLine()
let line = getline('.')
return line
endfunction

function! BBB_GetGroupname(selection)
  let group_name = substitute(a:selection[:10], '\s\+', '', 'g')
  return group_name
endfunction

function! BBB_GetSelection()
  let selection_type = inputlist(['Selection to highlight:',
    \'1. Word under cursor', '2. Last selection in visual mode'])
  if selection_type < 1 || selection_type > 2
    echohl WarningMsg
    echo "\nInvalid selection. Please choose 1 or 2."
    echohl None
    return
  elseif selection_type == 1
    let selection = BBB_GetCword()
  elseif selection_type == 2
    let selection = BBB_GetVisual()
  endif
  return selection
endfunction

function BBB_GetCword()
let cword = expand("<cword>")
return cword
endfunction

function! BBB_GetVisual()
  normal! gv"vy
  let visual = getreg("v")
  return visual
endfunction
