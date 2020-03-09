" Amirali Esfandiari's vimrc
" 
" [Hotkeys]


" vim-plug
call plug#begin('~/vimfiles/plugged')

Plug 'dracula/vim', { 'as': 'dracula' } " Dracula theme
Plug 'itchyny/lightline.vim' " Plugin for bottom statusbar
Plug 'scrooloose/nerdtree' " Plugin for file manager
Plug 'Yggdroot/indentLine' " Plugin for indent guides
Plug 'tpope/vim-fugitive' " Plugin for git interigation
Plug 'jiangmiao/auto-pairs' " Plugin for match the second of (, [ and others
Plug 'ollykel/v-vim' " Plugin for support Vlang
Plug 'mattn/gist-vim' " Plugin for make github gist
Plug 'mattn/webapi-vim' " Plugin for req Gist-Vim
Plug 'skywind3000/asyncrun.vim' " Plugin for running commands in vim
Plug 'jmcomets/vim-pony' " Plugin for help in django projects
" Plug 'FredKSchott/CoVim' " Co Operate with vim
Plug 'junegunn/goyo.vim' " Plugin for writing mode
Plug 'ConradIrwin/vim-bracketed-paste' " Plugin for auto pastemode
Plug 'ryanoasis/vim-devicons' " Plugin for NERDTree Icons
Plug 'lifepillar/vim-mucomplete' " plugin for autocompletion
Plug 'mitsuhiko/vim-jinja' " plugin for jinja
Plug 'mattn/emmet-vim' " plugin for emmet

call plug#end()

" configs
set number " Display line numbers on the left side
set ls=2 " This makes Vim show a status line even when only one window is shown
filetype plugin on " This line enables loading the plugin files for specific file types
set tabstop=4 " Set tabstop to tell vim how many columns a tab counts for. Linux kernel code expects each tab to be eight columns wide.
set expandtab " When expandtab is set, hitting Tab in insert mode will produce the appropriate number of spaces.
set softtabstop=4 " Set softtabstop to control how many columns vim uses when you hit Tab in insert mode. If softtabstop is less than tabstop and expandtab is not set, vim will use a combination of tabs and spaces to make up the desired spacing. If softtabstop equals tabstop and expandtab is not set, vim will always use tabs. When expandtab is set, vim will always use the appropriate number of spaces.
set shiftwidth=4 " Set shiftwidth to control how many columns text is indented with the reindent operations (<< and >>) and automatic C-style indentation. 
setlocal foldmethod=indent " Set folding method
set t_Co=256 " makes Vim use 256 colors
set nowrap " Don't Wrap lines!
colorscheme dracula "Set colorScheme
set nocp " This changes the values of a LOT of options, enabling features which are not Vi compatible but really really nice
set clipboard=unnamed
set clipboard=unnamedplus
set autoindent " Automatic indentation
set cindent " This turns on C style indentation
set si " Smart indent
syntax enable " syntax highlighting
set showmatch " Show matching brackets
set hlsearch " Highlight in search
set ignorecase " Ignore case in search
set noswapfile " Avoid swap files
set mouse=a " Mouse Integration
set encoding=UTF-8

" auto comment and uncooment with F6 and F7 key
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
noremap <silent> #6 :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR> " commenting line with F6
noremap <silent> #7 :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR> " uncommenting line with F7

" spell checking
map <F8> :setlocal spell! spelllang=en_us<CR>

" paste mode with <F10>
set pastetoggle=<F10>

" plugins
"indentLine 
let g:indentLine_char = '|'

" NERDTree plugin setting
" toggle showing NERDTree with <F9>
map <F9> :NERDTreeToggle<CR>

" open a NERDTree automatically when vim starts up with no file 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open file in new tab with C-t
let NERDTreeMapOpenInTab='<c-t>'

" Tabs Handle
noremap <silent> #3 :tabprevious<CR>
noremap <silent> #4 :tabnext<CR>

" lightline configs
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'wombat',
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

" mucomplete configs
set completeopt+=menuone,noselect

" gvim configs
if has('gui_running')
    " Set Gvim font
    set guifont=Consolas:h11
    " Copy/Paste 
    source $VIMRUNTIME\mswin.vim
    behave mswin
    " Remove top bars
    set guioptions-=T
    " set startup size
    set lines=45 columns=125
endif

