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
" try 'tpope/vinegar'
Bundle 'scrooloose/nerdtree'
" Bundle 'kien/ctrlp.vim'

" general editor extensions
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-endwise'
Bundle 'Raimondi/delimitMate'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-ragtag'
Bundle 'AndrewRadev/splitjoin.vim'

" UI candy
Bundle 'bling/vim-airline'

" rails, ruby and related things
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-cucumber'
Bundle 'tpope/vim-rake'
Bundle 'tobiassvn/vim-gemfile'
Bundle 'vim-ruby/vim-ruby'
Bundle 'edsono/vim-dbext'
Bundle 'TailMinusF'
Bundle 'rking/vim-ruby-refactoring'

" for emulating a neckbeard
Bundle 'tpope/vim-fugitive'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-eunuch'

" various filetypes
" search for 'official' puppet-plugin
Bundle 'ajf/puppet-vim'
" Bundle 'timcharper/textile.vim'
Bundle 'gerw/vim-latex-suite'
" Bundle 'leshill/vim-json'
" Bundle 'vim-scripts/nginx.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
" Bundle 'tpope/vim-afterimage'
Bundle 'plasticboy/vim-markdown'
Bundle 'Keithbsmiley/rspec.vim'

" not proud, just using sometimes
" Bundle 'php.vim-for-php5'

" have a ruby-block text-object ( r )
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'kana/vim-textobj-user'

" snippets
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'

" colorschemes
" Bundle 'kronn/vim-colorschemes'
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'rking/vim-detailed'
Bundle 'flazz/vim-colorschemes'
Bundle 'biskark/vim-ultimate-colorscheme-utility'

" experiments
" execute code directly from vim
" Bundle 'nielsmadan/venom'
" Bundle 'nielsmadan/mercury'

" run rspec from vim
" Bundle 'thoughtbot/vim-rspec'
" Bundle 'tpope/vim-dispatch'

" source-code navigation w/o ctags
" Bundle 'malkomalko/projections.vim'

" }}}

" settings {{{
set backspace=indent,eol,start
set scrolloff=5  " have always 5 lines of context around the cursor

set history=9001 " because vim-berlin said so
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
set hidden         " don't warn on unsaved changes when changing buffers

" Diffing
if &diff
  set diffopt=iwhite
  set wrap
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

" Latexsuite {{{
" use ack if available (credit: hukl)
if executable("ack-grep")
  set grepprg=ack-grep\ -H\ --nogroup\ --nocolor
else
  set grepprg=grep\ -nH\ $*
endif

" Run latex, then dvipdf, then refresh the xpdf window.
let g:Tex_FormatDependency_pdf = 'dvi,pdf'
let g:Tex_CompileRule_pdf = 'dvipdf $*.dvi'
" let g:Tex_CompileRule_pdf = 'dvipdf $*.dvi; xpdf -remote 127.0.0.1 -reload -raise'
" let g:Tex_ViewRule_pdf = 'xpdf -remote 127.0.0.1'
let g:Tex_DefaultTargetFormat = 'pdf' " Set the target format to pdf.
" }}}

" on Ubuntu, ack is called ack-grep
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Setting for folding of php-files ( hopefully for historical reasons ;-) )
let php_folding=1

" NERDTree {{{
let NERDChristmasTree=1   " Colorful output!!1!
" let NERDTreeChDirMode=2   " Always cd to the rootdir of the NERDTree
let NERDTreeHijackNetrw=1
" }}}

let g:rspec_command = "!rspec --drb --color -f documentation {spec}"

" splitjoin {{{
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
" }}}

let g:airline_powerline_fonts = 1

" rails.vim {{{
" projections - typing `:Rfactory users` will open the users factory
let g:rails_projections = {
      \ "test/factories/*.rb": {
      \   "command":   "factory",
      \   "affinity":  "collection",
      \   "alternate": "app/models/%i.rb",
      \   "related":   "db/schema.rb#%s",
      \   "test":      "test/models/%i_test.rb",
      \   "template":  "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \   "keywords":  "factory sequence"
      \ },
      \ "spec/factories/*.rb": {
      \   "command":   "factory",
      \   "affinity":  "collection",
      \   "alternate": "app/models/%i.rb",
      \   "related":   "db/schema.rb#%s",
      \   "test":      "spec/models/%i_test.rb",
      \   "template":  "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \   "keywords":  "factory sequence"
      \ },
      \ "features/*.feature": {
      \   "command": "feature",
      \   "affinity":  "collection"
      \ },
      \ "features/step_definitions/*.rb": {
      \   "command": "steps",
      \   "affinity":  "collection"
      \ },
      \ "Gemfile": {
      \   "command": "gemfile",
      \   "alternate": "Gemfile.lock",
      \   "related": "Gemfile.lock"
      \ }
      \}
" }}}

" }}}

" user interface {{{
" Vim should look good.
" this translates to: TERM=xterm-256color (or mvim/gvim)
" or: use the more colorful colorscheme if possible
if &t_Co >= 256 || has('gui')
  colo railscasts
else
  " so, at least use some dark theme
  colo torte
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

function! OpenPhpFunction (keyword)
  let proc_keyword = substitute(a:keyword , '_', '-', 'g')
  exe '5 split'
  exe 'enew'
  exe 'set buftype=nofile'
  exe 'silent r!links -dump http://www.php.net/manual/en/print/function.'.proc_keyword.'.php'
  exe 'norm gg'
  exe 'call search ("Description")'
  exe 'norm jdgg'
  exe 'call search("User Contributed Notes")'
  exe 'norm dGgg'
  exe 'norm V'
endfunction

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning = '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    else
      let b:statusline_tab_warning = ''
    endif
  endif
  return b:statusline_tab_warning
endfunction

command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78
" }}}

" autocommands {{{
if has('autocmd')
  " pde => arduino-files
  autocmd BufWritePre *.feature,*.erb,*.rb,*.js,*.pde,*.yml,*.sh,*.php,*.sql,*.haml,*.coffee,*.java :call <SID>StripTrailingWhitespaces()
  autocmd BufWritePre *.rake,*.pp :call <SID>StripTrailingWhitespaces()
  autocmd BufRead *.feature setlocal fdm=indent fdl=1
  autocmd BufRead *.scss setlocal fdm=indent
  autocmd BufRead *.pp setlocal fdm=indent
  autocmd BufRead *.md setlocal noet
  autocmd BufNewFile,BufRead *.mobile.erb setlocal ft=eruby.html
  autocmd BufRead *.yml setlocal fdm=indent fdl=2 ai
  autocmd BufNewFile,BufRead *.feature inoremap <silent> <Bar>   <Bar><ESC>:call <SID>align()<CR>a
  autocmd BufNewFile,BufReadPost *.coffee setlocal fdm=indent sw=2 ts=2 et

  autocmd FileType gitconfig setlocal noet

  if &diff
  else
    " maximine every window vertically upon entering
    autocmd WinEnter * wincmd _
  endif

  " don't clutter the bufferspace with fugitive-buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " thanks to @lucapette for pointing the usefulness of this one out
  autocmd BuFRead *.haml,*.sass setlocal cursorcolumn

  " recalculate the tab warning flag when idle and after writing
  autocmd cursorhold,BufWritePost * unlet! b:statusline_tab_warning

  " sigh, I wish I wouldn't need those anymore
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP
  autocmd FileType php noremap K :call OpenPhpFunction(expand('<cword>'))<CR>
endif
" }}}

" key-mappings {{{
" pasting
map <F3> :set invpaste<CR>
set pastetoggle=<F3>

map <F2> *:AckFromSearch<CR>

" quickly un-highlight search results
map <Leader>n :nohlsearch<CR>

" go to next window with tab
nmap <Tab> <C-w><C-w>
" go to previous window with shift-tab
nmap <S-Tab> <C-w>W

" arrow keys are a more visual movement
map <down> gj
map <up> gk

" shorten the commands for quickfix-lists
" map <C-Right> :cn<CR>
" map <C-Left> :cp<CR>
" a little hacky, those are my local escape-sequences...
map Oc :cn<CR>
map Od :cp<CR>

" " presentations
" map <C-Right> :next<CR>
" map <C-Left> :previous<CR>

" Key-mappings and extensions for plugins {{{

" nmap <Leader>j :SplitjoinJoin<cr>
" nmap <Leader>s :SplitjoinSplit<cr>
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

" Rspec.vim mappings
map <Leader>st :call RunCurrentSpecFile()<CR>
map <Leader>ss :call RunNearestSpec()<CR>
map <Leader>sl :call RunLastSpec()<CR>
map <Leader>sa :call RunAllSpecs()<CR>

" Tabularize
map <Leader>t= :Tabularize /=>\?/<CR>
map <Leader>t: :Tabularize /:\zs/<CR>
map <Leader>t, :Tabularize /,\zs/<CR>
" map <Leader>tt :Tabularize /|\(_.\)\?/<CR>

" NERDtree
map <Leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

" rubyrefactoring
let g:ruby_refactoring_map_keys=0
nnoremap <leader>fap  :RAddParameter<cr>
nnoremap <leader>fcpc :RConvertPostConditional<cr>
nnoremap <leader>fel  :RExtractLet<cr>
vnoremap <leader>fec  :RExtractConstant<cr>
vnoremap <leader>felv :RExtractLocalVariable<cr>
nnoremap <leader>fit  :RInlineTemp<cr>
vnoremap <leader>frlv :RRenameLocalVariable<cr>
vnoremap <leader>friv :RRenameInstanceVariable<cr>
vnoremap <leader>fem  :RExtractMethod<cr>

" }}}
" }}}
