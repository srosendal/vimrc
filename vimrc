" SRO vimrc file
" Set OS Defaults {{{
if has("win32")
    cd C:\Users\BKIR\OneDrive - Novo Nordisk\Documents\gvim
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
    set guifont=Consolas:h16    " Set font type and size, used for gVimPortable

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
    "set textwidth=79		    " Line wrap (number of cols)
    "set linebreak	            " Break lines at word (requires Wrap lines)
    "set showbreak=+++ 		    " Wrap-broken line prefix
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
    " Default folding settings
    set foldlevel=99           " Don't fold by default when opening a file

    " Set fold dash character globally
    if !exists('&fillchars')
        set fillchars=fold:-
    else
        set fillchars+=fold:-
    endif

    " Custom fold text
    " This function creates a clean fold text display with the following format:
    " Level 1 folds: '+---  N lines: text --------'
    " Level 2 folds: '+---    +---  N lines: text --------'
    " - Shows nested folds with double prefix for clear hierarchy
    " - Includes line count for each fold
    function! CustomFoldText()
        " Get basic fold information
        let lines_count = v:foldend - v:foldstart + 1
        let lines_count_text = printf("%4d", lines_count)
        let indent = indent(v:foldstart)
        let width = winwidth(0)

        " Initialize variables
        let base_prefix = '+---'
        let text_line = getline(v:foldstart)

        " Clean the line text first
        let text_line = substitute(text_line, '\s*$', '', '')        " Remove trailing whitespace
        let text_line = substitute(text_line, '^\s*', '', '')        " Remove leading whitespace
        let text_line = substitute(text_line, '\%x00', '', 'g')      " Remove null bytes
        let text_line = substitute(text_line, '\n', '', 'g')         " Remove newlines
        let text_line = substitute(text_line, '\r', '', 'g')         " Remove carriage returns

        " Determine prefix based on fold level
        if exists('b:class_indent') && indent > b:class_indent
            let prefix = base_prefix . '    ' . base_prefix
        else
            let prefix = base_prefix
        endif

        " Construct the final fold text
        let fold_text = prefix . ' ' . lines_count_text . ' lines: ' . text_line

        " Clean the text
        return substitute(fold_text, '[^[:print:][:space:]]', '', 'g')
    endfunction

    " Custom Python fold expression
    " This creates a two-level folding hierarchy for Python files:
    " Level 1:
    " - Classes
    " - Standalone functions (outside classes)
    " - Import blocks
    " Level 2:
    " - Methods within classes
    function! GetPythonFold(lnum)
        let line = getline(a:lnum)
        let indent = indent(a:lnum)

        " Skip empty lines
        if line =~ '^\s*$'
            return '='
        endif

        " Start of import block
        if line =~ '^import\s' || line =~ '^from\s.*import'
            return 1
        endif

        " Class definitions start a fold at level 1
        if line =~ '^\s*class\s'
            let b:class_indent = indent
            return ">1"
        endif

        " Check if we're inside a class definition by comparing indent
        if exists('b:class_indent')
            " Function definitions within class indent should be level 2
            if line =~ '^\s*def\s' && indent > b:class_indent
                return ">2"
            endif
            " Content within class methods
            if indent > b:class_indent
                return "2"
            endif
        endif

        " Standalone functions (outside class) at level 1
        if line =~ '^\s*def\s' && (!exists('b:class_indent') || indent <= b:class_indent)
            return ">1"
        endif

        " Default case
        return "="
    endfunction

    " File type specific folding settings
    augroup folding_settings
        autocmd!
        " Vim files use marker folding
        autocmd FileType vim setlocal foldmethod=marker
        autocmd FileType vim setlocal foldlevel=0

        " Python files use custom folding
        autocmd FileType python setlocal foldmethod=expr
        autocmd FileType python setlocal foldexpr=GetPythonFold(v:lnum)
        autocmd FileType python setlocal foldtext=CustomFoldText()
        autocmd FileType python setlocal foldnestmax=2
        autocmd FileType python setlocal foldminlines=1
        " Ensure fillchars doesn't get overridden
        autocmd BufWinEnter *.py setlocal fillchars=fold:-
        autocmd BufRead *.py setlocal fillchars=fold:-
    augroup END

    " Force marker folding for vimrc specifically
    autocmd BufRead,BufNewFile *vimrc setlocal foldmethod=marker
    autocmd BufRead,BufNewFile *vimrc setlocal foldlevel=0
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
    set rtp+=C:\Vim\.vim\bundle\Vundle.vim
else
    if has("unix")
        set rtp+=~/.vim/bundle/Vundle.vim
    endif
endif
" Vundle {{{
call vundle#begin('C:\Vim\.vim\bundle')

Plugin 'gmarik/Vundle.vim' " Required

" 'Integrated Performance' Plugins
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-repeat'
Plugin 'tmhedberg/simpylfold'
Plugin 'godlygeek/tabular'
"Plugin 'townk/vim-autoclose'

" Appearance/Visual Plugins
Plugin 'flazz/vim-colorschemes'
Plugin 'mechatroner/rainbow_csv'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/goyo.vim'

" Add-on's Plugins
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
"Plugin 'Jeffrey-P-McAteer/vim-praktijk'
Plugin 'takac/vim-hardtime'
Plugin 'mhinz/vim-startify'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ivalkeen/nerdtree-execute' "Note: no spaces allowed in full path of gVimPortable
"Plugin 'kien/ctrlp.vim'

"" AI Plugins
"Plugin 'madox2/vim-ai'
Plugin 'pasky/claude.vim'

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
    "colorscheme nordisk
    "colorscheme molokai
    "colorscheme elflord
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
" Hardtime {{{
    let g:hardtime_default_on = 0  " Don't enable by default
    let g:hardtime_showmsg = 1     " Show messages when you do something inefficient
    let g:hardtime_ignore_quickfix = 1  " Don't enforce in quickfix windows
    let g:hardtime_maxcount = 3     " Allow 2 repeats before showing message
" }}}
" Claude {{{
let g:claude_api_key = 'YOUR_API_KEY_HERE'
let g:claude_map_implement = "<Leader>ci"
let g:claude_map_open_chat = "<Leader>co"
"let g:claude_map_send_chat_message = "<Leader>cj"
let g:claude_map_send_chat_message = "<C-CR>"
let g:claude_map_cancel_response = "<Leader>cx"
" }}}
" ELinks (Not Vundle Plugin){{{
" Set PATH for ELinks within Vim
let $PATH .= ';C:\elinks-0.11.6\'

" Set ELinks as the default browser for Vim
let g:netrw_browsex_viewer = "elinks"

" Existing ELinks setup
let $PATH .= ';C:\elinks-0.11.6\'
let g:netrw_browsex_viewer = "elinks"
" Improved ELinks command
command! -nargs=+ ELinks :call ELinksCommand(<q-args>)
function! ELinksCommand(args)
    let l:url = a:args
    if a:args !~ '^https\?://'
        let l:url = 'http://' . l:url
    endif
    execute '!C:\elinks-0.11.6\elinks.exe ' . shellescape(l:url)
endfunction

" New GoogleSearch command
command! -nargs=+ GoogleSearch :call GoogleSearchCommand(<q-args>)
function! GoogleSearchCommand(query)
    let l:encoded_query = substitute(a:query, ' ', '+', 'g')
    let l:url = 'https://www.google.com/search?q=' . l:encoded_query
    execute '!C:\elinks-0.11.6\elinks.exe ' . shellescape(l:url)
endfunction
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

"" Use + to jump to end of sentence
"nnoremap + $
"nnoremap d+ d$

" Navigate to Center of Line
map gm :call cursor(0, virtcol('$')/2)<CR>

"" Folding with spacebar
"nnoremap <space> za
" Folding mappings
nnoremap <space> za  " Toggle fold under cursor
nnoremap <leader>fd zM  " Close all folds (mnemonic: fold down)
nnoremap <leader>fg zR  " Open all folds (mnemonic: fold go/global)

" Split Windows
nnoremap <C-J> <C-W><C-J>   " Ctrl-j navigate to the split below
nnoremap <C-K> <C-W><C-K>   " Ctrl-k navigate to the split below
nnoremap <C-L> <C-W><C-L>   " Ctrl-l navigate to the split below
nnoremap <C-H> <C-W><C-H>   " Ctrl-h navigate to the split below

nnoremap <leader>j <C-W>J   " leader-j move window to the split below
nnoremap <leader>k <C-W>K   " leader-l move window to the split above
nnoremap <leader>l <C-W>L   " leader-l move window to the split to the right
nnoremap <leader>h <C-W>H   " leader-h move window to the split to the left

nnoremap <silent> <leader>wo :only <CR>
nnoremap <silent> <leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>

nnoremap <silent> <leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <leader>= <C-W>=

" Remove all trailing whitespace
nnoremap <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Toggle highlighting on/off, and show current value.
noremap <F7> :set hlsearch! hlsearch?<CR>

" Editing
" Apply macros, qq: record, q: stop recording, Q: apply
nnoremap Å @q
vnoremap Å :norm @q<cr>

"Delete line above or under cursor
nnoremap <leader>d :-d<CR>
nnoremap <leader>D :+d<CR>

" Short-Cuts
" Show and Set Paths
nnoremap <silent> <leader>su :lcd C:\Users\BKIR\Desktop<CR>:pwd<CR>
nnoremap <leader>si :pwd<CR> " Show current path
nnoremap <silent> <leader>sp :cd %:p:h<CR> " Set path for all windows to current file path
nnoremap <silent> <leader>so :lcd %:p:h<CR> " Set path for current window to current file path

" vimrc settings
if has("win32")
    nnoremap <leader>ev :sp $MYVIMRC<CR>
    nnoremap <leader>rv :source $MYVIMRC<CR>
else
    if has("unix")
        nnoremap <leader>ev :e /etc/vim/vimrc<CR>
        nnoremap <leader>rv :source /etc/vim/vimrc<CR>
    endif
endif

" Replace visually marked text using Ctr-R
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Windows-Like Mappings
" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>

" Map Ctrl-Delete to delete the next word in insert mode.
inoremap <C-Del> <C-o>dE

" Indenting should include comments in for example python
vmap > >gv=

" Copy Paste to System clipboard with <Leader>p and <Leader>y
vmap <leader>y "+y
nmap <leader>p "+gp
nmap <leader>P "+gP
imap <leader>p <esc>"+gpi<esc>
imap <leader>P <esc>"+gPi<esc>
nmap <leader>å "+gP`[v`]
vmap <leader>x "+x

" Select all, delete and copy paste in from System clipboard
nmap <leader>o ggdG"+gP

" Plugin related KeyMappings
" leader n to switch NumberToggleTrigger
nnoremap <silent> <leader>n :set relativenumber!<cr>

" Open Startify
nnoremap <leader>s :Startify<CR>

" leader m to open/close NERDTree
map <leader>m :if exists("b:NERDTree") <Bar> NERDTreeClose <Bar> else <Bar> NERDTree %:p:h <Bar> endif<CR>

" OS and File dependent Run Commands
if has("win32")
    " Open Windows File explorer in external native window
    nnoremap <silent> <F10> :!start explorer /select,%:p<CR>
    " Run Python Code
    au BufEnter *.py map <leader>æ :!start cmd /c python %<CR>
    au BufEnter *.py map <leader>ø :!start cmd /c python -i %<CR>
    au BufEnter *.py vmap <leader>å :w !python<CR>
    " Compile tex/md to pdf
    au BufEnter *.tex map <leader>æ :!start cmd /c pdflatex %<CR>
    au BufEnter *.md map <leader>æ :!start cmd /c pandoc -V geometry:margin=3cm -o %:r.pdf<CR>
else
    if has("unix")
    " Run Python Code
    au BufEnter *.py map <leader>æ :!clear <CR> <esc>:w\|!python3 %<CR>
    au BufEnter *.py map <leader>ø :!clear <CR> <esc>:w\|!python3 -i %<CR>
    " Insert Breakpoint
    au BufEnter *.py imap <leader>b <CR>import pdb; pdb.set_trace()
    au BufEnter *.py map <leader>b oimport pdb; pdb.set_trace()<esc>
    " Compile tex/md Document to pdf
    au BufEnter *.tex map <leader>æ <esc>:w\|!pdflatex %<CR> <CR>
    au BufEnter *.md map <leader>æ <esc>:w\|!pandoc -V geometry:margin=3cm % -o %:r.pdf<CR>
    " Break all long lines in document
    au BufEnter *.tex map <leader>b <esc>:g/\%>79v/norm gww<CR><F7>
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
