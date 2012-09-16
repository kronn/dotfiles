" vim:foldmethod=marker:foldlevel=0
set nocompatible  " Surprise, I actually want Vim :-)

" plugins {{{
  " setup vundle {{{
  filetype off                   " required!
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  " let Vundle manage Vundle
  " required!
  Bundle 'gmarik/vundle'
  " }}}

" activate bundled matchit.vim
runtime macros/matchit.vim

" maybe remove and learn netrw
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'

Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-cucumber'
Bundle 'tsaleh/vim-supertab'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'Raimondi/delimitMate'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-ragtag'
" Bundle 'tpope/vim-afterimage'

Bundle 'ajf/puppet-vim'
Bundle 'tpope/vim-rake'
Bundle 'tobiassvn/vim-gemfile'
Bundle 'vim-ruby/vim-ruby'
" Bundle "korin/ri.vim"
Bundle 'timcharper/textile.vim'

Bundle 'tpope/vim-fugitive'
Bundle 'mileszs/ack.vim'

Bundle 'tpope/vim-eunuch'

" Bundle 'edsono/vim-dbext'
Bundle 'TailMinusF'

Bundle 'Lokaltog/vim-powerline'
" Bundle 'leshill/vim-json'
" Bundle 'vim-scripts/nginx.vim'
" Bundle 'gerw/vim-latex-suite'

" have a ruby-block text-object ( r )
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'

" maybe change to ultisnips or so
Bundle 'honza/snipmate-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'tomtom/tlib_vim'
Bundle 'MarcWeber/vim-addon-mw-utils'

" colorschemes
Bundle 'kronn/vim-colorschemes'
" Bundle 'altercation/vim-colors-solarized'

" }}}

" settings {{{
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

" The OSX-keyboardlayout sucks, especially when you have \ as Leader on a
" German keyboard...
" and this doesn't hurt on other OS either
let mapleader = ","
let maplocalleader = ","

" I want to *use* Vim, actually...
syntax on
filetype plugin indent on
" }}}

" settings for plugins {{{

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

" Setting for ctrl_p
" 'file': '\.exe$\|\.so$\|\.dll$',
" 'link': 'SOME_BAD_SYMBOLIC_LINKS',
let g:ctrlp_custom_ignore = { 'dir': '\.git$\|\.hg$\|\.svn$' }

" settings for powerline
" let g:Powerline_symbols = "unicode"
let g:Powerline_symbols = "fancy"
" }}}

" user interface {{{
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
  " no scrollbars: not left, not right nor bottom. just none.
  set guioptions-=L
  set guioptions-=l
  set guioptions-=R
  set guioptions-=r
  set guioptions-=B
  set guioptions-=b

  " set guifont=Monospace\ 9
  " set guifont=Inconsolata\ 9
  set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 8

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

" }}}

" functions {{{
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
" }}}

" autocommands {{{
if has('autocmd')
  " pde => arduino-files
  autocmd BufWritePre *.feature,*.erb,*.rb,*.js,*.pde,*.yml,*.sh,*.php,*.sql,*.haml :call <SID>StripTrailingWhitespaces()
  autocmd BufRead *.feature :setlocal fdm=indent fdl=1
  autocmd BufRead *.scss :setlocal fdm=indent
  autocmd BufRead *.md :setlocal noet
  autocmd BufRead .vimperatorrc :setlocal ft=vimperator
  autocmd BufNewFile,BufRead *.mobile.erb :setlocal ft=eruby.html
  autocmd BufRead *.yml :setlocal fdm=indent fdl=2 ai
  autocmd BufNewFile,BufRead *.feature inoremap <silent> <Bar>   <Bar><ESC>:call <SID>align()<CR>a
  autocmd WinEnter * wincmd _
  " don't clutter the bufferspace with fugitive-buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete
endif
" }}}

" key-mappings {{{
map <F2> :set invpaste<CR>
set pastetoggle=<F2>
map <Leader>n :nohlsearch<CR>

" quickly toggle between current and previous buffer
" nnoremap <Leader><Leader> <dunno dude>

" go to next window with tab
nmap <Tab> <C-w><C-w>
" go to previous window with shift-tab
nmap <S-Tab> <C-w>W


" Key-mappings and extensions for plugins {{{

" rails.vim
if has("autocmd")
  autocmd User Rails Rnavcommand feature features/ -glob=**/* -suffix=.feature
  autocmd User Rails Rnavcommand steps features/step_definitions/ -glob=**/* -suffix=.rb
  autocmd User Rails Rnavcommand config config/ -glob=* -suffix=
endif

" Tabularize
map <Leader>t= :Tabularize /=>\?/<CR>
map <Leader>t: :Tabularize /:\zs/<CR>
map <Leader>t, :Tabularize /,\zs/<CR>
" map <Leader>tt :Tabularize /|\(_.\)\?/<CR>

" NERDtree
map <Leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" }}}
" }}}
