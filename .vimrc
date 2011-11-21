" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible  " Surprise, I actually want Vim :-)

set backspace=indent,eol,start
set scrolloff=5  " have always 5 lines of context around the cursor

set history=50   " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set laststatus=2 " always show status bar
set showcmd      " display incomplete commands

set incsearch    " do incremental searching
set hlsearch     " show my search results
set ignorecase   " Ignore case when searching
set smartcase    " Ignore case when searching lowercase

set lbr          " long lines are wrapped on word boundaries

" modelines for tweaking behaviour on file-level
set modeline
set modelines=5  " this is the default, but i really want it that way

" Time to wait after ESC (default causes an annoying delay)
set timeout timeoutlen=1000 ttimeoutlen=100

" Spaces not Tabs.
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set encoding=utf-8   " Unicode is a beast, but...

" what to show
set list                  " show line-endings, tabs and trailing spaces
set lcs=trail:·,tab:»·    " trailing spaces and tabs are shown and eol not

set number         " show line-numbers
set wildmenu       " use funky wildmenu to display alternate findings

" windows, buffers, splits, ...
set winminheight=0

" Diffing
if &diff
  set diffopt=iwhite
  set wrap
else
endif

" STFU
set noerrorbells
set visualbell
set t_vb=" "

" Folding
set foldmethod=syntax
set foldlevelstart=1

" Backups & Files
set backup                   " Enable creation of backup file.
if has('unix')
  set backupdir=~/.vim/backups " Where backups will go.
  set directory=~/.vim/tmp     " Where temporary files will go."
endif
if has('win32')
  set backupdir=~/vimfiles/backups " Where backups will go.
  set directory=~/vimfiles/tmp     " Where temporary files will go."
endif

" activate bundled matchit.vim
runtime macros/matchit.vim

" Setting for Latexsuite
" use ack if available (credit: hukl)
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
else
  set grepprg=grep\ -nH\ $*
endif

" Setting for folding of php-files ( hopefully for historical reasons ;-) )
let php_folding=1

" Settings for NERDTree
let NERDChristmasTree=1   " Colorful output!!1!
" let NERDTreeChDirMode=2   " Always cd to the rootdir of the NERDTree
let NERDTreeHijackNetrw=1

" The OSX-keyboardlayout sucks, especially when you have \ as Leader...
" and this doesn't hurt on other OS either
let mapleader = ","
let maplocalleader = ","

" I want to *use* Vim, actually...
syntax on
filetype plugin indent on

" Vim should look good.
" so, at least use some dark theme
colo torte

" this translates to: TERM=xterm-256color (or mvim/gvim)
" or: use the more colorful colorscheme if possible
if &t_Co >= 256 || has('gui')
  colo railscasts
endif

" Tweak the GUI
if has('gui')
  set guioptions-=T               " no toolbar
  set guioptions-=m               " no menu

  set guifont=Monospace\ 9

  if has('win32')
    set guifont=Lucida_Console:h10
  endif

  if has('gui_macvim')
    set fuoptions=maxhorz,maxvert  " Let Fullscreen be really fullscreen
    " set transparency=8             " Mac selling point #1? transparent windows! :-)
    set guifont=Menlo\ Regular:h12
  endif
endif

if has('windows')
  " Always show the Tabline
  " set showtabline=2

  " Only show the Tabline if needed
  set showtabline=1
endif

" show git-branch in statusline if possible
" if exists('*fugitive#statusline()')
  set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" endif

" Functions
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" autocommands
if has('autocmd')
  " pde => arduino-files
  autocmd BufWritePre *.feature,*.erb,*.rb,*.js,*.pde,*.yml,*.sh :call <SID>StripTrailingWhitespaces()
  autocmd BufRead *.feature :setlocal fdm=indent fdl=1
  autocmd BufRead *.scss :setlocal fdm=indent
  autocmd BufRead *.md :setlocal noet
  autocmd BufRead .vimperatorrc :setlocal ft=vimperator
  autocmd BufRead *.yml :setlocal fdm=indent fdl=2 ai
  autocmd BufNewFile,BufRead *.feature inoremap <silent> <Bar>   <Bar><ESC>:call <SID>align()<CR>a
  autocmd WinEnter * wincmd _
  " don't clutter the bufferspace with fugitive-buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif

" Key-mappings
set pastetoggle=<F2>

" Key-mappings and extensions for plugins

" rails.vim
if has("autocmd")
  autocmd User Rails Rnavcommand feature features/ -glob=**/* -suffix=.feature
endif

" Tabularize
if has('autocmd')
  autocmd Vimenter AddTabularPattern colon  /:\zs/
  autocmd Vimenter AddTabularPattern rocket /=>\?/
endif
map <Leader>t= :Tabularize rocket<CR>
map <Leader>t: :Tabularize colon<CR>

" NERDtree
map <Leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

nmap <Tab> <C-W>w
nmap <S-Tab> <C-W>W
