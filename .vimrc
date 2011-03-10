" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set nocompatible  " Surprise, I actually want Vim :-)

set backspace=indent,eol,start
set scrolloff=5   " have always 5 lines of context around the cursor

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
set softtabstop=2
set shiftwidth=2
set expandtab

set encoding=utf-8   " Unicode is a beast, but...

" what to show
set list                  " show line-endings, tabs and trailing spaces
set lcs=trail:·,tab:»·    " trailing spaces and tabs are shown and eol not

set number         " show line-numbers
set wildmenu       " use funky wildmenu to display alternate findings

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

" use ack instead of grep? might need to custimize the grepprg for
" tex-files...
"
" install ack: (given you have perl)
" curl http://betterthangrep.com/ack-standalone > ~/bin/ack && chmod 0755 !#:3
"
" use ack if available (credit: hukl)
" if executable("ack")
"   set grepprg=ack\ -H\ --nogroup\ --nocolor
" endif

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
  set guioptions-=T                " no menu

  if has('win32')
    set guifont=Lucida_Console:h10
  endif

  if has('gui_macvim')
    set fuoptions=maxhorz,maxvert  " Let Fullscreen be really fullscreen
    " set transparency=8             " Mac selling point #1? transparent windows! :-)
    set guifont=Menlo\ Regular:h12
  endif
endif

" Always show the Tabline
if has('windows')
  set showtabline=2
endif


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
  autocmd BufWritePre *.feature,*.erb,*.rb,*.js,*.pde :call <SID>StripTrailingWhitespaces()
  autocmd BufRead *.feature :setlocal fdm=indent fdl=1
  autocmd BufRead *.scss :setlocal fdm=indent
  autocmd BufRead *.md :setlocal noet
  autocmd BufRead .vimperatorrc :setlocal ft=vimperator
  autocmd BufNewFile,BufRead *.feature inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
endif

" Key-mappings for plugins
if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

" rails.vim
" map <F5> <ESC>:w:Rake

" NERDtree
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
