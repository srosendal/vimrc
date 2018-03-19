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
    colorscheme desert              " Set Color Scheme
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
        set rtp+=/home/pi/.vim/bundle/Vundle.vim
    endif
endif
" Vundle {{{
call vundle#begin('$HOME/.vim/bundle/')
Plugin 'gmarik/Vundle.vim' " Required

" Plugin 'tomasr/molokai'
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'jnurmine/Zenburn'

Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'godlygeek/tabular'
Plugin 'tpope/vim-speeddating'
Plugin 'townk/vim-autoclose'

Plugin 'mhinz/vim-startify'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ivalkeen/nerdtree-execute' "Note: no spaces allowed in full path of gVimPortable
Plugin 'kien/ctrlp.vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
" Plugin 'sirver/ultisnips'
" Plugin 'hlissner/vim-multiedit'
" Plugin 'paradigm/vim-multicursor'
" Plugin 'davidhalter/jedi-vim'
" Plugin 'valloric/youcompleteme'

" Plugin 'chrisbra/csv.vim'
Plugin 'mechatroner/rainbow_csv'
Plugin 'klen/python-mode'
Plugin 'latex-box-team/latex-box'
" Plugin 'gerw/vim-latex-suite'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
call vundle#end()
filetype plugin indent on
" }}}
" Plugin Settings {{{
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
let g:tex_flavor='latex'
autocmd FileType tex set spell wrap linebreak
let g:LatexBox_latexmk_async=1
let g:LatexBox_latexmk_preview_continuously=1
let g:LatexBox_quickfix=2
let g:LaTeXBox_output_type='' "Let latexmkrc choose the type "
" }}}
" Vim-Latex Suite {{{
" set shellslash
" set grepprg=grep\ -nH\ $*
" let g:tex_flavor='latex'
" let g:Tex_DefaultTargetFormat='pdf'
" let g:Tex_CompileRule_pdf='pdflatex -interaction=nonstopmode $*'
" let g:Tex_ViewRule_pdf='C:\Program Files (x86)\SumatraPDF\SumatraPDF.exe'
" }}}
" }}}
"}}}
" Key Mappings {{{
let mapleader = ","
let maplocalleader = "-"

" use jj or jk as Escape
inoremap jj <Esc>
inoremap jk <Esc>

nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>si :pwd<CR> " Show current path
nnoremap <silent> <leader>sp :cd %:p:h<CR> " Set path for all windows to current file path
nnoremap <silent> <leader>so :lcd %:p:h<CR> " Set path for current window to current file path

" Use ' to jump to the exact mark location
nnoremap ' `
" Use + to jump to end of sentence
nnoremap + $
nnoremap d+ d$
" Use 9 to jump to first non-blank character
nnoremap 9 ^
nnoremap d9 d^

nnoremap <leader>sr "=strftime("%Y/%m/%d %H:%M:%S")<CR>P
inoremap <leader>sr <C-R>=strftime("%Y/%m/%d %H:%M:%S")<CR>
nnoremap <leader>sd "=strftime("%Y/%m/%d")<CR>P
inoremap <leader>sd <C-R>=strftime("%Y/%m/%d")<CR>
nnoremap <leader>st "=strftime("%H:%M:%S")<CR>P
inoremap <leader>st <C-R>=strftime("%H:%M:%S")<CR>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>a :qall<CR>

nnoremap <C-J> <C-W><C-J>   " Ctrl-j navigate to the split below
nnoremap <C-K> <C-W><C-K>   " Ctrl-k navigate to the split below
nnoremap <C-L> <C-W><C-L>   " Ctrl-l navigate to the split below
nnoremap <C-H> <C-W><C-H>   " Ctrl-h navigate to the split below

nnoremap <leader>j <C-W>J   " leader-j move window to the split below
nnoremap <leader>k <C-W>K   " leader-l move window to the split above
nnoremap <leader>l <C-W>L   " leader-l move window to the split to the right
nnoremap <leader>h <C-W>H   " leader-h move window to the split to the left

nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <leader>= <C-W>=

nnoremap <space> za         " Folding with spacebar
nnoremap K i<CR><Esc>       " Split two lines

" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>
" Map Ctrl-Delete to delete the next word in insert mode.
inoremap <C-Del> <C-o>dE

" Copy Paste to System clipboard with <Leader>p and <Leader>y
vmap <leader>y "+y
nmap <leader>p "+gP
vmap <leader>x "+x

" leader n to switch NumberToggleTrigger
nnoremap <silent> <leader>n :set relativenumber!<cr>

" leader m to open/close NERDTree
map <leader>m :NERDTreeToggle<CR>
" Open Windows File explorer in external native window
nnoremap <silent> <F10> :!start explorer /select,%:p<CR>

" Compile Latex Document to pdf
nnoremap <silent> <F1> :!start cmd /c pdflatex %<CR>
" Compile Latex Document to Markdown
nnoremap <silent> <F2> :!start cmd /c pandoc -s % -o %:r.md<CR>
" Create Markdown file then compile this file to pdf
nnoremap <silent> <F3> :!start cmd /c pandoc -s % -o %:r_md.md<CR> :!start cmd /c pandoc -s -V geometry:margin=1in -o %:r_md.pdf %:r_md.md<CR> " Compile Latex Document to Markdown
" Compile Latex Document to docx
nnoremap <silent> <F4> :!start cmd /c pandoc -s % -o %:r.docx<CR>
" Run Python Code Inside VIM
nnoremap <silent> <F5> :!python %<CR>
" Compile Markdown to pdf
nnoremap <silent> <F6> :!start cmd /c pandoc -s -V geometry:margin=1cm -o %:r.pdf %:r.md<CR>
" Press F7 to toggle highlighting on/off, and show current value.
:noremap <F7> :set hlsearch! hlsearch?<CR>

" Arduino Inotool keymappings, linux only
if has("unix")
    nnoremap <silent> <leader>io :cd %:p:h<CR> :cd ..<CR> :!ino build<CR>
    nnoremap <silent> <leader>iu :cd %:p:h<CR> :cd ..<CR> :!ino upload<CR>
    nnoremap <silent> <leader>ip :cd %:p:h<CR> :cd ..<CR> :!ino serial<CR>
    nnoremap <silent> <F8> :cd %:p:h<CR> :cd ..<CR> :!ino build<CR> :!ino upload<CR> :!ino serial<CR>
endif
"}}}
