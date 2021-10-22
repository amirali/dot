if ! exists("g:loaded_fzf_vim")
   finish 
endif

" Set layout
let g:fzf_layout = { 'down': '40%' }


" Key maps
nnoremap <leader><leader> :Files<CR>
nnoremap ?? :Rg<CR>
nnoremap <C-p> :GitFiles<CR>
nnoremap ,c :Files ~/src/github.com/amirali/dot<CR>
nnoremap <leader>ec :Files ~/src/github.com/amirali/dot<CR>
nnoremap <leader>en :Files ~/.config/nvim<CR>
nnoremap <leader>fp :Files ~/.local/share/nvim/site/pack/packer/opt<CR>
