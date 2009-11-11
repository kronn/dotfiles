set nocompatible  " Surprise, I actually want Vim :-)

set backspace=indent,eol,start

set history=50    " keep 50 lines of command line history
set ruler         " show the cursor position all the time
set laststatus=2  " always show status bar
set showcmd       " display incomplete commands

set incsearch     " do incremental searching
set hlsearch      " show my search results
set ignorecase    " Ignore case when searching
set smartcase     " Ignore case when searching lowercase

set lbr           " long lines are wrapped on word boundaries

" Time to wait after ESC (default causes an annoying delay)
set timeout timeoutlen=1000 ttimeoutlen=100

" Spaces not Tabs.
set tabstop=2
set shiftwidth=2
set expandtab

set encoding=utf-8   " Unicode is a beast, but...

set list                  " show line-endings, tabs and trailing spaces
set lcs=trail:·,tab:\ \   " trailing spaces are shown, tabs and eol not

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

" Setting for Latexsuite
set grepprg=grep\ -nH\ $*

" Setting for folding of php-files ( hopefully for historical reasons ;-) )
let php_folding=1

" Settings for NERDTree
let NERDChristmasTree=1   " Colorful output!!1!
let NERDTreeChDirMode=2   " Always cd to the rootdir of the NERDTree
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
  set guioptions-=T                " no menu

	if has('win32')
		set guifont=Lucida_Console:h10
	endif

	if has('gui_macvim')
		set fuoptions=maxhorz,maxvert  " Let Fullscreen be really fullscreen
		set transparency=8             " Mac selling point #1? transparent windows! :-)
	endif
endif

" Always show the Tabline
if has('windows')
	set showtabline=2
endif

" common Key-mappings (parantheses et al.)
imap {} {}<ESC>i
imap [] []<ESC>i
imap () ()<ESC>i
imap '' ''<ESC>i
imap "" ""<ESC>i

" Key-mappings for plugins

" rails.vim
map <F5> <ESC>:w:Rake

" NERDtree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
