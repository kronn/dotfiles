set nocompatible
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

set tabstop=2
set shiftwidth=2

set encoding=utf-8

set list " show line-endings, tabs and trailing spaces
set lcs=trail:·,tab:\ \   " trailing spaces are shown, tabs and eol not

" STFU
set noerrorbells
set visualbell
set t_vb=" "

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

" Setting for folding of php-files
let php_folding=1

" Setting for extended %-Matching
let loaded_matchit = 1

" Settings for NERDTree
let NERDChristmasTree=1
let NERDTreeChDirMode=2
let NERDTreeHijackNetrw=1

" The OSX-keyboardlayout sucks when you have \ as Leader...
" and this doesn't hurt on other OS either
let mapleader = ","
let maplocalleader = ","

" I want to *use* Vim, actually...
syntax on
filetype plugin indent on

colo torte
if has( 'gui' )
	colo railscasts

	if has('win32')
		set guifont=Lucida_Console:h10
	endif

	if has('gui_macvim')
		set fuoptions=maxhorz,maxvert  " Let Fullscreen be really fullscreen
		set transparency=8
	endif
end

if has('windows')
	set showtabline=2
endif

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

