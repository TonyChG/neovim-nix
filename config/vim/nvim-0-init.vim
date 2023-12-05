syntax on
filetype plugin indent on

let mapleader = " "
" colorscheme monokai-pro-spectrum
colorscheme rose-pine

" set list listchars=trail:~,tab:>-,nbsp:␣,eol:↲

tnoremap <silent> <C-p> <C-\><C-n>
nnoremap <silent> <leader>t :NvimTreeToggle<CR>

" fzf
nnoremap <silent> <C-f> <cmd>lua require('fzf-lua').files()<CR>
nnoremap <silent> <C-x> <cmd>lua require('fzf-lua').quickfix()<CR>
nnoremap <silent> <C-g> <cmd>lua require('fzf-lua').live_grep()<CR>

" telescope
nnoremap <silent> <C-b> :Telescope buffers<CR>
nnoremap <silent> <leader>b :Telescope builtin<CR>
nnoremap <silent> <leader>o :Telescope oldfiles<CR>
nnoremap <silent> <leader>p :lua require("telescope").extensions.ghq.list()<CR>

" toggleterm
nnoremap <silent> <leader>cc :ToggleTerm direction=tab<CR>
nnoremap <silent> <leader>* 2:ToggleTerm direction=vertical<CR>
nnoremap <silent> <leader>v 2:ToggleTerm direction=horizontal<CR>

" spectre
nnoremap <silent> <leader>S <cmd>lua require("spectre").toggle()<CR>
nnoremap <silent> <leader>sw <cmd>lua require("spectre").open_visual({select_word=true})<CR>
nnoremap <silent> <leader>sp <cmd>lua require("spectre").open_file_search({select_word=true})<CR>
nnoremap <silent> <leader>sr <cmd>Lspsaga rename<CR>
vnoremap <silent> <leader>sw <esc><cmd>lua require("spectre").open_visual()<CR>

" fugitive
let g:fugitive_pty = 0
nnoremap <silent> <leader>gs :Git<CR>
nnoremap <silent> <leader>gl :Gclog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gpf :Git push -f<CR>
nnoremap <silent> <leader>gP :Git pull<CR>
nnoremap <silent> <leader>gf :Git fetch --all<CR>
nnoremap <silent> <leader>gv :Gvdiffsplit<CR>
nnoremap <silent> <leader>gb :Git_blame<CR>
nnoremap <silent> <leader>gcc :Git commit<CR>
nnoremap <silent> <leader>grm :GDelete!<CR>

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
