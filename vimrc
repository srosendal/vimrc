" SRO vimrc file
" Set OS Defaults {{{
if has("win32")
    cd C:\Users\srosendal\Documents\gvim\ 
else
    if has("unix")
        runtime! debian.vim
    endif
endif
" }}}
" VIM General Settings{{{
    set nocompatible            " Use Vim settings, rather than Vi settings
    filetype off                " Required
    set title                   " Set Terminal Title
    set number			" Show line numbers
    set wildmenu                " Show completions of command line commands
    set ruler			" Show row and column ruler information
    set showcmd                 " Show (partial) command in status line
    set showmatch		" Highlight matching brace
    set noerrorbells            " No Beeping
    set visualbell              " Set Visual bell
    set t_vb=                   " Set the visual bell to empty (no flashing)
    set nostartofline           " Don't go to the first char of line (some movments)
    set laststatus=2            " Always displays status line, increase size
    set cmdheight=2             " Set command window height
    set confirm                 " Raise dialog to ask for save (instead of fail)
    set backspace=indent,eol,start	" Backspacing over everything, insert mode
    set hidden			        " Hide buffers when abandoned
    set nrformats-=octal        " Exclude octal formats
    set autochdir               " Automatic sets directory to current file
    set mousemodel=extend       " Use the mouse to search for all words using shift-leftclick

    if has("autocmd") " Vim jumps to the latest position, when reopening a file
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if has("win32")
        set lines=40                " Set Window Size
        set columns=120             " Set Window Size
        autocmd GUIEnter * set vb t_vb=
        autocmd VimEnter * set vb t_vb=
    endif
    
    " Maximize Window
    au GUIEnter * simalt ~x
" }}}
" Colorscheme {{{
    set t_Co=256                    " Set colors
    syntax on			    " Enable syntax highlighting
    set background=dark		    " If using dark background
    "colorscheme desert              " Set Color Scheme
" }}}
" Line Limits and Breaks {{{
    set textwidth=79		    " Line wrap (number of cols)
    set linebreak	            " Break lines at word (requires Wrap lines)
    set showbreak=+++ 		    " Wrap-broken line prefix
" }}}
" Tabs and Indentation {{{
    set autoindent	            " Auto-indent new lines
    set smartindent	            " Enable smart-indent
    set shiftwidth=4		    " Number of auto-indent spaces
    set softtabstop=4		    " Number of spaces per Tab
    set expandtab      	            " Use spaces instead of tabs
    set smarttab                    " Enable smart-tabs
" }}}
" Folding {{{
    set foldmethod=marker       " Fold section by markers, not indentation
    set foldlevel=0             " Close every fold by default
" }}}
" Search {{{
    set hlsearch	            " Highlight all search results
    set smartcase	            " Enable smart-case matching
    set ignorecase	            " Always case-insensitive
    set incsearch	            " Incremental Search
" }}}
" Undo and Backup {{{
    set history=50	            " Number of command line history
    set undolevels=100	            " Number of undo levels
    set nobackup                    " No Backup Files
    set nowritebackup               " No Backup File while editing
    set noswapfile                  " No Swap Files
    set autowrite                   " Auto save before com's like :next :make
" }}}
" Encoding {{{
    set encoding=utf-8              " Encoding Displayed
    set fileencoding=utf-8          " The Encoding written to file
    set fileformat=unix             " Set fileformat
" }}}
" Plugins {{{
if has("win32")
    set rtp+=$HOME/.vim/bundle/Vundle.vim/
else
    if has("unix")
        set rtp+=~/.vim/bundle/Vundle.vim
    endif
endif
" Vundle {{{
call vundle#begin('$HOME/.vim/bundle/')
Plugin 'gmarik/Vundle.vim' " Required

" 'Integrated Performance' Plugins
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'
Plugin 'tmhedberg/simpylfold'
"Plugin 'godlygeek/tabular'
"Plugin 'townk/vim-autoclose'

" Appearance/Visual Plugins
Plugin 'flazz/vim-colorschemes'
Plugin 'mechatroner/rainbow_csv'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'scrooloose/syntastic'

" Add-on's Plugins
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'mhinz/vim-startify'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ivalkeen/nerdtree-execute' "Note: no spaces allowed in full path of gVimPortable
"Plugin 'kien/ctrlp.vim'

" Box/Package Plugins
"Plugin 'klen/python-mode'
"Plugin 'latex-box-team/latex-box'
"Plugin 'vim-pandoc/vim-pandoc'
"Plugin 'vim-pandoc/vim-pandoc-syntax'

call vundle#end()
filetype plugin indent on
" }}}
" Plugin Settings {{{
" colorscheme {{{
    "colorscheme nord
    colorscheme nordisk
    "colorscheme molokai
" }}}
" Startify {{{
    let g:startify_custom_header=[strftime('%c')]
    let g:startify_custom_indices = ['f', 'g', 'h']
" }}}
" Airline {{{
" Airline Colour settings: github.com/vim-airline/vim-airline/wiki/screenshots
let g:airline_powerline_fonts=0
let g:airline_theme='kolor'
" }}}
" NERDTree {{{
let g:nerdtree_tabs_open_on_gui_startup=0
let NERDTreeIgnore=['\.pyc$', '\~$']    " ignore files in NERDTree
" }}}
" Latex-box {{{
"let g:tex_flavor='latex'
"autocmd FileType tex set spell wrap linebreak
"let g:LatexBox_latexmk_async=1
"let g:LatexBox_latexmk_preview_continuously=1
"let g:LatexBox_quickfix=2
"let g:LaTeXBox_output_type='' "Let latexmkrc choose the type "
" }}}
" }}}
"}}}
" Key Mappings {{{
" Fundamentals
let mapleader = ","
let maplocalleader = "-"

" Use alternatives as Escape
inoremap jj <Esc>
inoremap jk <Esc>
inoremap ´ <Esc>
inoremap ¨ <Esc>

" Save and Quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>a :qall<CR>

" Navigation
" Use ' to jump to the exact mark location
nnoremap ' `

" Use + to jump to end of sentence
nnoremap + $
nnoremap d+ d$

" Navigate to Center of Line
map gm :call cursor(0, virtcol('$')/2)<CR>

" Folding with spacebar
nnoremap <space> za

" Split Windows
nnoremap <C-J> <C-W><C-J>   " Ctrl-j navigate to the split below
nnoremap <C-K> <C-W><C-K>   " Ctrl-k navigate to the split below
nnoremap <C-L> <C-W><C-L>   " Ctrl-l navigate to the split below
nnoremap <C-H> <C-W><C-H>   " Ctrl-h navigate to the split below

nnoremap <leader>j <C-W>J   " leader-j move window to the split below
nnoremap <leader>k <C-W>K   " leader-l move window to the split above
nnoremap <leader>l <C-W>L   " leader-l move window to the split to the right
nnoremap <leader>h <C-W>H   " leader-h move window to the split to the left

nnoremap <silent> <leader>o :only <CR>
nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>

nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <leader>= <C-W>=

" Toggle highlighting on/off, and show current value.
:noremap <F7> :set hlsearch! hlsearch?<CR>

" Editing
" Apply macros, qq: record, q: stop recording, Q: apply
nnoremap Å @q
vnoremap Å :norm @q<cr>

"Delete line above or under cursor
nnoremap <leader>d :-d<CR>
nnoremap <leader>D :+d<CR>

" Short-Cuts
" Show and Set Paths
nnoremap <leader>si :pwd<CR> " Show current path
nnoremap <silent> <leader>sp :cd %:p:h<CR> " Set path for all windows to current file path
nnoremap <silent> <leader>so :lcd %:p:h<CR> " Set path for current window to current file path

" vi settings
nnoremap <leader>ev :e /etc/vim/vimrc<CR>

" Replace visually marked text using Ctr-R
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Windows-Like Mappings
" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>

" Map Ctrl-Delete to delete the next word in insert mode.
inoremap <C-Del> <C-o>dE

" Copy Paste to System clipboard with <Leader>p and <Leader>y
vmap <leader>y "+y
nmap <leader>p "+gP
vmap <leader>x "+x

" Plugin related KeyMappings
" leader n to switch NumberToggleTrigger
nnoremap <silent> <leader>n :set relativenumber!<cr>

" leader m to open/close NERDTree
map <leader>m :NERDTreeToggle<CR>

" OS and File dependent Run Commands
if has("win32")
    " Open Windows File explorer in external native window
    nnoremap <silent> <F10> :!start explorer /select,%:p<CR>
    " Compile Latex Document to pdf
    au BufEnter *.tex map <silent> <F1> :!start cmd /c pdflatex %<CR>
    au BufEnter *.tex map <leader>æ :!start cmd /c pdflatex %<CR>
    " Compile Markdown to pdf
    au BufEnter *.tex map <silent> <F2> :!start cmd /c pandoc -s -V geometry:margin=1cm -o %:r.pdf %:r.md<CR>
    au BufEnter *.tex map <leader>ø :!start cmd /c pandoc -s -V geometry:margin=1cm -o %:r.pdf %:r.md<CR>
else
    if has("unix")
    " Run Python Code
    au BufEnter *.py map <silent> <F1> :!clear <CR> <esc>:w\|!python3 %<CR>
    au BufEnter *.py map <leader>æ :!clear <CR> <esc>:w\|!python3 %<CR>
    au BufEnter *.py map <leader>ø :!clear <CR> <esc>:w\|!python3 -i %<CR>
    " Compile Latex Document to pdf
    au BufEnter *.tex map <silent> <F1> <esc>:w\|!pdflatex %<CR> <CR>
    au BufEnter *.tex map <leader>æ <esc>:w\|!pdflatex %<CR> <CR>
    endif
endif

"" Arduino Inotool keymappings; linux only
"if has("unix")
    "nnoremap <silent> <leader>io :cd %:p:h<CR> :cd ..<CR> :!ino build<CR>
    "nnoremap <silent> <leader>iu :cd %:p:h<CR> :cd ..<CR> :!ino upload<CR>
    "nnoremap <silent> <leader>ip :cd %:p:h<CR> :cd ..<CR> :!ino serial<CR>
    "nnoremap <silent> <F9> :cd %:p:h<CR> :cd ..<CR> :!ino build<CR> :!ino upload<CR> :!ino serial<CR>
"endif
"}}}
