if ! exists("g:loaded_telescope")
    finish
endif

nnoremap <leader><leader> <cmd>lua require"amirali.telescope".wrap(require("telescope.builtin").find_files, { hidden = true })()<CR>
nnoremap <leader>fb <cmd>lua require"amirali.telescope".wrap(require("telescope.builtin").file_browser)()<CR>
nnoremap <leader>fp <cmd>lua require"amirali.telescope".installed_plugins()<CR>
nnoremap <leader>pp <cmd>lua require"amirali.telescope".projects()<CR>
nnoremap <leader>ps <cmd>lua require"amirali.telescope".snapp()<CR>
nnoremap <C-p> <cmd>lua require"amirali.telescope".git_files()<CR>
nnoremap <C-q> <cmd>lua require"amirali.telescope".quickfix()<CR>
nnoremap ?? <cmd>lua require"amirali.telescope".wrap(require("telescope.builtin").live_grep)()<CR>
nnoremap ,c <cmd>lua require"amirali.telescope".edit_configs()<CR>
nnoremap <leader>ec <cmd>lua require"amirali.telescope".edit_configs()<CR>
nnoremap <leader>L  <cmd>lua require"amirali.telescope".telescope_commands()<CR>
nnoremap <leader>en <cmd>lua require"amirali.telescope".edit_neovim()<CR>
nnoremap ,n <cmd>lua require"amirali.telescope".edit_neovim()<CR>
nnoremap gd <cmd>Telescope lsp_definitions<CR>
nnoremap gr <cmd>Telescope lsp_references<CR>
nnoremap gi <cmd>Telescope lsp_implementations<CR>
nnoremap ?d <cmd>Telescope lsp_document_symbols<CR>
nnoremap ?w <cmd>Telescope lsp_workspace_symbols<CR>
nnoremap ?c <cmd>Telescope lsp_code_actions<CR>
