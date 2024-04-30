syntax on
filetype plugin indent on

let mapleader = " "
xnoremap <silent> <leader>p "_dP

tnoremap <silent> <C-p> <C-\><C-n>
" nnoremap <silent> <C-d> <C-d>zz
" nnoremap <silent> <C-u> <C-u>zz
" nnoremap <silent> <C-f> <C-f>zz
" nnoremap <silent> <C-b> <C-b>zz

" fasd
function! s:Go(pattern)
    let match = system('fasd '.a:pattern)

    execute ":lcd ".match
endfunction

" Change working directory to the current file directory
function! s:GoCurrent()
    execute ":lcd %:p:h"
endfunction

command! -nargs=1 Z call s:Go(<f-args>)
command! Gc call s:GoCurrent()

set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m

autocmd FileType sql setlocal tabstop=4 shiftwidth=4
