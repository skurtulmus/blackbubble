" Copyright (c) 2021 Sinan Kurtulmus
"
" Permission to use, copy, modify, and distribute this software for any
" purpose with or without fee is hereby granted, provided that the above
" copyright notice and this permission notice appear in all copies.
"
" THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
" WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
" MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
" ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
" WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
" ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
" OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

const s:SYNTAXFILE = "bbb.vim"
autocmd BufRead,BufNewFile *.bbb call BlackBubble()

function! BlackBubble()
    set filetype=blackbubble
    call BBB_Mappings()
    if !empty(glob(s:SYNTAXFILE))
        execute 'source ' . s:SYNTAXFILE
    endif
endfunction

function! BBB_Mappings()
    nnoremap <silent> <Right> :next<CR>
    nnoremap <silent> <Left> :previous<CR>
    nnoremap <silent> <Down> :first<CR>
    nnoremap <silent> <Up> :last<CR>
    nnoremap <silent> <C-f> :call BBB_Font()<CR>
    nnoremap <silent> <C-c> :call BBB_Color()<CR>
    nnoremap <silent> <C-b> :call BBB_Format()<CR>
endfunction

function! BBB_Font()
    let font_number = inputlist(['Ascii Font:',
        \ '1. Mono9 (Big Title)',
        \ '2. Smblock (Small Title)',
        \ '3. Future (Fancy)',
        \ '4. Border (Draw borders)'
        \ ])
    if font_number == 1
        let font_name = "mono9"
    elseif font_number == 2
        let font_name = "smblock"
    elseif font_number == 3
        let font_name = "future"
    elseif font_number == 4
        let font_name = "term -F border"
    else
        echohl WarningMsg
        echo "\nInvalid font. Please enter a number from 1 to 4."
        echohl None
        return
    endif
    execute '.!toilet -f ' . font_name
endfunction

function! BBB_Color()
    let current_line = BBB_GetLine()
    let current_selection = BBB_GetSelection()
    let group_name = BBB_GetGroupname(current_selection)
    let color_number = inputlist(['Color:',
        \ '1. Red',
        \ '2. Green',
        \ '3. Yellow',
        \ '4. Blue',
        \ '5. Magenta',
        \ '6. Cyan',
        \ '7. Gray'
        \ ])
    if color_number < 1 || color_number > 7
        echohl WarningMsg
        echo "\nInvalid color. Please enter a number from 1 to 7."
        echohl None
        return
    endif
    let syntax_items = [
        \ 'syntax match bbb_' . group_name . '_color "' . current_selection . '" contained',
        \ 'syntax match bbb_' . group_name . '_container "' . current_line . '" contains=ALL',
        \ 'highlight bbb_' . group_name . '_color ctermfg=' . color_number
        \ ]
    silent call writefile(syntax_items, s:SYNTAXFILE, 'a')
    execute 'source ' . s:SYNTAXFILE
endfunction

function! BBB_Format()
    let current_line = BBB_GetLine()
    let current_selection = BBB_GetSelection()
    let group_name = BBB_GetGroupname(current_selection)
    let format_number = inputlist(['Font:',
        \ '1. Bold',
        \ '2. Italic',
        \ '3. Underline'
        \ ])
    if format_number == 1
        let format_name = "bold"
    elseif format_number == 2
        let format_name = "italic"
    elseif format_number == 3
        let format_name = "underline"
    else
        echohl WarningMsg
        echo "\nInvalid format. Please enter a number from 1 to 3."
        echohl None
        return
    endif
    let syntax_items = [
        \ 'syn match bbb_' . group_name . '_font "' . current_selection . '" contained',
        \ 'syn match bbb_' . group_name . '_container "' . current_line . '" contains=ALL',
        \ 'hi bbb_' . group_name . '_font cterm=' . format_name
        \ ]
    silent call writefile(syntax_items, s:SYNTAXFILE, 'a')
    execute 'source ' . s:SYNTAXFILE
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
