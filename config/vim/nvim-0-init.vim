syntax on
filetype plugin indent on

let mapleader = ";"
colorscheme monokai-pro-spectrum

set list listchars=trail:~,tab:>-,nbsp:␣,eol:↲

tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <silent> <C-f> :Telescope find_files<CR>
nnoremap <silent> <C-b> :Telescope buffers<CR>
nnoremap <silent> <C-g> :Telescope live_grep<CR>
nnoremap <silent> <C-p> :Telescope builtin<CR>
nnoremap <silent> <space>e :NvimTreeToggle<CR>

let g:copilot_no_tab_map = v:true
let g:copilot_filetypes = {
      \ '*': v:true,
      \ }
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
