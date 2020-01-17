" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
Plug 'skywind3000/vim-quickui'

call plug#end()

" configs
:set number " Display line numbers on the left side
:set ls=2 " This makes Vim show a status line even when only one window is shown
:filetype plugin on " This line enables loading the plugin files for specific file types
:set tabstop=4 " Set tabstop to tell vim how many columns a tab counts for. Linux kernel code expects each tab to be eight columns wide.
:set expandtab " When expandtab is set, hitting Tab in insert mode will produce the appropriate number of spaces.
:set softtabstop=4 " Set softtabstop to control how many columns vim uses when you hit Tab in insert mode. If softtabstop is less than tabstop and expandtab is not set, vim will use a combination of tabs and spaces to make up the desired spacing. If softtabstop equals tabstop and expandtab is not set, vim will always use tabs. When expandtab is set, vim will always use the appropriate number of spaces.
:set shiftwidth=4 " Set shiftwidth to control how many columns text is indented with the reindent operations (<< and >>) and automatic C-style indentation. 
:setlocal foldmethod=indent " Set folding method
:set t_Co=256 " makes Vim use 256 colors
:set nowrap " Don't Wrap lines!
:colorscheme  molokai "Set colorScheme
:set nocp " This changes the values of a LOT of options, enabling features which are not Vi compatible but really really nice
:set clipboard=unnamed
:set clipboard=unnamedplus
:set autoindent " Automatic indentation
:set cindent " This turns on C style indentation
:set si " Smart indent
:syntax enable " syntax highlighting
:set showmatch " Show matching brackets
:set hlsearch " Highlight in search
"":set ignorecase " Ignore case in search
:set noswapfile " Avoid swap files
:set mouse=a " Mouse Integration

" auto comment and uncooment with F6 and F7 key
:autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
:autocmd FileType sh,ruby,python   let b:comment_leader = '# '
:noremap <silent> #6 :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR> " commenting line with F6
:noremap <silent> #7 :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR> " uncommenting line with F7

" spell checking
:map <F8> :setlocal spell! spelllang=en_us<CR>

" paste mode with <F10>
:set pastetoggle=<F10>

" plugins
"indentLine 
:let g:indentLine_char = '|'
" autocomplpop setting
:set omnifunc=syntaxcomplete " This is necessary for ACP plugin


" airline plugin setting
:let g:airline_theme='wombat' " set airline plugin theme
:let g:airline#extensions#tabline#enabled = 1 " showing tabs 
:let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

 " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'

"vim-airline-clock 
:let g:airline#extensions#clock#format = '%c'

" NERDTree plugin setting
" toggle showing NERDTree with <F9>
:map <F9> :NERDTreeToggle<CR>

" open a NERDTree automatically when vim starts up with no file 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" open file in new tab with C-t
:let NERDTreeMapOpenInTab='<c-t>'

" Tabs Handle
:noremap <silent> #3 :tabprevious<CR>
:noremap <silent> #4 :tabnext<CR>

" lightline configs
:set noshowmode
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ }
