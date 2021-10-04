" Amirali Esfandiari's vimrc
" 
" [Hotkeys]
" <F3>  nexttab
" <F4>  previoustab
" <F5>  run/compile this file
" <F8>  spell check
" <F9>  NERDtree
" <c-T> open terminal
" <c-/> comment toggle
"
" vim-surround hotkeys:
" S: vim surround in visual mode
" cs'": replace ' with "
"
" Git: fugitive command for using git
"
" D*/Dviews/Dmodels/Durls: pony commands for access to django components
"
" <Leader>f: fzf
"
" <Leader>p: prettier

if empty(glob("~/.vim/autoload/plug.vim"))
	sil !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim' " Plugin for statusbar
Plug 'scrooloose/nerdtree' " Plugin for file manager
Plug 'Yggdroot/indentLine' " Plugin for indent guides
Plug 'tpope/vim-fugitive' " Plugin for git interigation
Plug 'jiangmiao/auto-pairs' " Plugin for match the second of (, [ and others
Plug 'skywind3000/asyncrun.vim' " Plugin for running commands in vim
Plug 'jmcomets/vim-pony' " Plugin for help in django projects
Plug 'ConradIrwin/vim-bracketed-paste' " Plugin for auto pastemode
Plug 'ryanoasis/vim-devicons' " Plugin for NERDTree Icons
Plug 'mattn/emmet-vim' " plugin for emmet
Plug 'alvan/vim-closetag'
Plug 'terryma/vim-multiple-cursors'
Plug 'kien/rainbow_parentheses.vim'
Plug 'cespare/vim-toml'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --go-completer' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'fatih/vim-go'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'ollykel/v-vim'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-commentary'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'prettier/vim-prettier', {
			\ 'do': 'yarn install',
			\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'vue', 'html'],
			\ 'branch': 'release/0.x'
			\ }
Plug 'wsdjeg/vim-todo'
Plug 'junegunn/goyo.vim'

call plug#end()


" Don't apply settings if plugins are not installed yet
if !empty(glob("~/.vim/plugged/"))

set number relativenumber
set ls=2
filetype plugin on
set tabstop=4
set softtabstop=4
set shiftwidth=4
setlocal foldmethod=indent
set nofoldenable
set termguicolors
set nowrap
set background=dark
colo nord
set nocp
set clipboard^=unnamed,unnamedplus
set autoindent
set cindent
set si
syn enable
set showmatch
set hlsearch
set ignorecase
set noswapfile
set mouse=a
set encoding=UTF-8
set splitbelow
set splitright

" Make backspace do its job again!
set backspace=2

" Change vim cursor in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" spell checking
map <F8> :setlocal spell! spelllang=en_us<CR>

" indentLine 
let g:indentLine_char = '|'

" toggle showing NERDTree with <F9>
map <F9> :NERDTreeToggle<CR>

" open a NERDTree automatically when vim starts up with no file 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Tabs Handle
noremap <silent> #3 :tabprevious<CR>
noremap <silent> #4 :tabnext<CR>

" lightline configs
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'nord',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
	\ 'mode_map': {
		\ 'n' : 'N',
		\ 'i' : 'I',
		\ 'R' : 'R',
		\ 'v' : 'V',
		\ 'V' : 'VL',
		\ "\<C-v>": 'VB',
		\ 'c' : 'C',
		\ 's' : 'S',
		\ 'S' : 'SL',
		\ "\<C-s>": 'SB',
		\ 't': 'T',
	\ },
    \ }

" Asyncrun.vim
let g:asyncrun_open = 8

" run/compile
aut FileType python :noremap <F5> :AsyncRun -raw python % <CR>
aut FileType go :noremap <F5> :AsyncRun go run % <CR>
aut FileType vim :noremap <F5> :so % <CR>
aut FileType cpp :noremap <F5> :!g++ % && ./a.out <CR>
aut FileType c :noremap <F5> :!gcc % && ./a.out <CR>
map <c-Z> :AsyncStop<CR>

" open terminal bind to <c-t>
map <c-t> :term<CR>

" Rainbow parentheses colors
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" YCM close in normal mode
let g:ycm_autoclose_preview_window_after_insertion = 1

" fzf configs
let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <leader>f :FzfFiles<CR>

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_template_autocreate = 0

" set tabsize for web files
au FileType javascript,css,html,vue set tabstop=2
au FileType javascript,css,html,vue set softtabstop=2
au FileType javascript,css,html,vue set shiftwidth=2

" vim-closetag configurations
let g:closetag_filenames = '*.html,*.vue'

" python Black format on save
au BufWritePre *.py execute ':Black'

" Enable emmet for html & css
let g:user_emmet_install_global = 0
au FileType html,css EmmetInstall

" Comment toggle bind to <c-/>
" & I still don't know why forward-slash is known as '_' :/
noremap <c-_> :Commentary<CR>

" vue
let g:vim_vue_plugin_config = { 
			\ 'syntax': {
			\    'template': ['html'],
			\    'script': ['javascript'],
			\    'style': ['css'],
			\ },
			\ 'full_syntax': [],
			\ 'initial_indent': [],
			\ 'attribute': 0,
			\ 'keyword': 0,
			\ 'foldexpr': 0,
			\ 'debug': 0,
			\ }
let g:vim_vue_plugin_load_full_syntax = 1

" temperary settings for showing whitespaces
set list
" set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
set listchars=tab:→\ ,eol:↲

noremap <silent> <leader>g :Goyo<CR>

" End if of applying condition (set your plugins configs before this)
endif
