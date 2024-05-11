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
  nnoremap <silent> <Leader>bo :call BBB_Bold()<CR>
  nnoremap <silent> <Leader>it :call BBB_Italic()<CR>
  nnoremap <silent> <Leader>ul :call BBB_Underline()<CR>
endfunction

function! BBB_Color()
  let current_selection = BBB_GetSelection()
  let group_name = BBB_GetGroupname(current_selection)
  let selection_color = inputlist(['Color:', '1. Red', '2. Green', '3. Yellow',
    \'4. Blue', '5. Magenta', '6. Cyan', '7. Gray'])
  if selection_color < 1 || selection_color > 7
    echohl WarningMsg
    echo "\nInvalid color. Please enter a number from 1 to 7."
    echohl None
    return
  endif
  execute '!echo -e "syn match bbb_' . group_name . '_colorize \"' . current_selection . '\"\nhi bbb_' . group_name .'_colorize ctermfg=' . selection_color . '" >> bbb.vim'
  source bbb.vim
endfunction

function! BBB_Bold()
  let current_selection = BBB_GetSelection()
  execute '!echo -e "syn match bbb_' . current_selection . 'emphasize \"' . current_selection . '\"\nhi ' . current_selection .'emphasize cterm=bold" >> bbb.vim'
  source bbb.vim
endfunction

function! BBB_Italic()
  let current_selection = BBB_GetSelection()
  execute '!echo -e "syn match bbb_' . current_selection . 'italicize \"' . current_selection . '\"\nhi ' . current_selection .'italicize cterm=italic" >> bbb.vim'
  source bbb.vim
endfunction

function! BBB_Underline()
  let current_selection = BBB_GetSelection()
  execute '!echo -e "syn match bbb_' . current_selection . 'underline \"' . current_selection . '\"\nhi ' . current_selection .'underline cterm=underline" >> bbb.vim'
  source bbb.vim
endfunction

function! BBB_GetGroupname(str)
  let name = substitute(a:str[:10], '\s\+', '', 'g')
  return name
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

function! BBB_GetVisual()
  normal! gv"vy
  let visual = getreg("v")
  return visual
endfunction

function! BBB_GetCword()
  let cword = expand("<cword>")
  return cword
endfunction
