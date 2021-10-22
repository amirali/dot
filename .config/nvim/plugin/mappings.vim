nnoremap <C-j> <C-w>
nnoremap <C-k> <C-w>
nnoremap <C-l> <C-w>
nnoremap <C-h> <C-w>

nnoremap Q <NOP>
nnoremap ; :
nnoremap q; q:

nnoremap <M-l> :tabprevious<CR>
nnoremap <M-h> :tabnext<CR>
nnoremap <M-t> :tabnew<CR>

tnoremap <Esc> <C-\\><C-n>
tnoremap jk <C-\\><C-n>
tnoremap kj <C-\\><C-n>

inoremap jk <Esc>
inoremap kj <Esc>

nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==

inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi

vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv

nnoremap Y y$
nnoremap n nzz
nnoremap N Nzz

nnoremap <expr><CR> {-> v:hlsearch ? ":nohl\<CR>" : "\<CR>"}()
