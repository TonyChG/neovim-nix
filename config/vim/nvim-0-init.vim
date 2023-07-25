syntax on
filetype plugin indent on

let mapleader = ";"
colorscheme monokai-pro-spectrum

set list listchars=trail:~,tab:>-,nbsp:␣,eol:↲

tnoremap <silent> <C-p> <C-\><C-n>
nnoremap <silent> <C-f> :Telescope find_files<CR>
nnoremap <silent> <C-b> :Telescope buffers<CR>
nnoremap <silent> <C-g> :Telescope live_grep<CR>
nnoremap <silent> <leader>b :Telescope builtin<CR>
nnoremap <silent> <leader>p :lua require("telescope").extensions.ghq.list()<CR>
nnoremap <silent> <space>e :NvimTreeToggle<CR>

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

