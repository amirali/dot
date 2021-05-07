" Amirali Esfandiari's vimrc
" 
" [Hotkeys]
" <F2>  pastemode
" <F3>  nexttab
" <F4>  previoustab
" <F5>  run/compile this file
" <F6>  comment
" <F7>  uncomment
" <F8>  spell check
" <F9>  NERDtree
" <F10> pylint
" <c-T> open terminal

" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim' " Plugin for bottom statusbar
Plug 'scrooloose/nerdtree' " Plugin for file manager
Plug 'Yggdroot/indentLine' " Plugin for indent guides
Plug 'tpope/vim-fugitive' " Plugin for git interigation
Plug 'jiangmiao/auto-pairs' " Plugin for match the second of (, [ and others
Plug 'mattn/gist-vim' " Plugin for make github gist
Plug 'mattn/webapi-vim' " Plugin for req Gist-Vim
Plug 'skywind3000/asyncrun.vim' " Plugin for running commands in vim
" Plug 'jmcomets/vim-pony' " Plugin for help in django projects
" Plug 'FredKSchott/CoVim' " Co Operate with vim
Plug 'ConradIrwin/vim-bracketed-paste' " Plugin for auto pastemode
" Plug 'ryanoasis/vim-devicons' " Plugin for NERDTree Icons
" Plug 'lifepillar/vim-mucomplete' " plugin for autocompletion
" Plug 'mitsuhiko/vim-jinja' " plugin for jinja
" Plug 'mattn/emmet-vim' " plugin for emmet
Plug 'realamirali/hashemi.vim'
Plug 'maxboisvert/vim-simple-complete'
" Plug 'metakirby5/codi.vim' " plugin for real-time and interactive scratchpad
" Plug 'davidhalter/jedi-vim', { 'for': 'python' } " Jedi Plugin for python
Plug 'terryma/vim-multiple-cursors'
"Plug 'SirVer/ultisnips'
Plug 'kien/rainbow_parentheses.vim'
Plug 'cheap-glitch/vim-v', { 'for': 'v' } " Vlang plugin
Plug 'cespare/vim-toml'
Plug 'ycm-core/YouCompleteMe'
Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'codota/tabnine-vim'
Plug 'fatih/vim-go'

call plug#end()


" Display line numbers on the left side
set number relativenumber

" This makes Vim show a status line even when only one window is shown
set ls=2

" This line enables loading the plugin files for specific file types
filetype plugin on

" Set tabstop to tell vim how many columns a tab counts for. Linux kernel code expects each tab to be eight columns wide.
set tabstop=4

" When expandtab is set, hitting Tab in insert mode will produce the appropriate number of spaces.
set expandtab

" Set softtabstop to control how many columns vim uses when you hit Tab in insert mode. If softtabstop is less than tabstop and expandtab is not set, vim will use a combination of tabs and spaces to make up the desired spacing. If softtabstop equals tabstop and expandtab is not set, vim will always use tabs. When expandtab is set, vim will always use the appropriate number of spaces.
set softtabstop=4

" Set shiftwidth to control how many columns text is indented with the reindent operations (<< and >>) and automatic C-style indentation. 
set shiftwidth=4

" Set folding method
setlocal foldmethod=indent
set nofoldenable

" makes Vim use 256 colors
" set t_Co=256
set termguicolors

" Don't Wrap lines!
set nowrap

"Set Dark background
set background=dark

"Set colorScheme
colo dracula

" Not compatible with VI
set nocp

" Set clipboard for linux, windows, mac
set clipboard^=unnamed,unnamedplus

" Automatic indentation
set autoindent

" This turns on C style indentation
set cindent

" Smart indent
set si

" syntax highlighting
syn enable

" Show matching brackets
set showmatch

" Highlight in search
set hlsearch

" Ignore case in search
set ignorecase

" Avoid swap files
set noswapfile

" Mouse Integration
set mouse=a

" Set UTF-8 encode
set encoding=UTF-8

" Set for new split it open blow of current buffer
set splitbelow

" Set for new vsplit it open right of current buffer
set splitright

" Make backspace do his job again!
set backspace=2

" Change vim cursor in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" auto comment and uncooment with F6 and F7 key
autocmd FileType c,cpp,java,go let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
noremap <silent> #6 :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR> " commenting line with F6
noremap <silent> #7 :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR> " uncommenting line with F7


" spell checking
map <F8> :setlocal spell! spelllang=en_us<CR>


" paste mode with <F2>
set pastetoggle=<F2>

" Disable quote concealing in JSON files
let g:vim_json_conceal = 0

" indentLine 
let g:indentLine_char = '|'


" NERDTree plugin setting
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
    \ 'colorscheme': 'dracula',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbrach': 'FugitiveHead'
    \ }
    \ }


"" V for vim
" disable highlight whitespace after `[]`
let g:v_highlight_array_whitespace_error = 0

" Disable highlight white space around the communications operator that don't follow the standard style.
let g:v_highlight_chan_whitespace_error = 0

" Disable highlight instances of tabs following spaces.
let g:v_highlight_space_tab_error = 0

" Disable highlight trailing white space.
let g:v_highlight_trailing_whitespace_error = 0

" Disable highlight function calls.
let g:v_highlight_function_calls = 0

let g:v_highlight_fields = 0


" Asyncrun.vim
let g:asyncrun_open = 8


"" Vim Gist config
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'xclip -selection clipboard'


" gvim configs
if has('gui_running')
    if has('win32')
        " Set Gvim font
        set guifont=Cascadia\ Mono:h11
    endif
    " Remove top bars
    set guioptions=
    " set startup size
    set lines=45 columns=125
endif


" run/compile
aut FileType python :noremap <F5> :AsyncRun -raw python % <CR>
aut FileType go :noremap <F5> :AsyncRun go run % <CR>
aut FileType vim :noremap <F5> :so % <CR>
aut FileType cpp :noremap <F5> :!g++ % && ./a.out <CR>
aut FileType c :noremap <F5> :!gcc % && ./a.out <CR>

map <c-Z> :AsyncStop<CR>


" check pylint with <F10>
aut FileType python :noremap <F10> :AsyncRun pylint ./% <CR><CR>


" simple-complete config
set complete-=t
set complete-=i


" set powershell as term shell for windows use
if has('win32')
    set shell=powershell.exe
endif


map <c-t> :term<CR>

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

let g:ycm_autoclose_preview_window_after_insertion = 1


let g:fzf_command_prefix = 'Fzf'
nnoremap <silent> <leader>f :FzfFiles<CR>

" autocmd FileType javascript colo gruvbox
"
" " vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
