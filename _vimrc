" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

set t_Co=256
:colorscheme railscasts

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set pastetoggle=<F2>
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Prevents my source tree from being trashed by silliness
set backupskip=/tmp/*,/private/tmp/*" 
set backupdir=~/.vimbackup
set dir=~/.vimswap

" Tabs ************************************************************************
"set sta " a <Tab> in an indent inserts 'shiftwidth' spaces

function! Tabstyle_tabs()
  " Using 4 column tabs
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set noexpandtab
  autocmd User Rails set softtabstop=4
  autocmd User Rails set shiftwidth=4
  autocmd User Rails set tabstop=4
  autocmd User Rails set noexpandtab
endfunction

function! Tabstyle_spaces()
  " Use 2 spaces
  set softtabstop=2
  set shiftwidth=2
  set tabstop=2
  set expandtab
endfunction

call Tabstyle_spaces()


" Indenting *******************************************************************
set ai " Automatically set the indent of a new line (local to buffer)
set si " smartindent    (local to buffer)


" Scrollbars ******************************************************************
set sidescrolloff=2
set numberwidth=4

" Window switch
map <F2> <C-w>w

" fuzzy file finder
map ,f :FuzzyFinderTextMate <CR>

"taglist
map ,t :TlistToggle <CR>
let Tlist_Use_Right_Window = 1

" nerd tree
noremap ,n :NERDTreeToggle <CR>
map ,cd :cd %:p:h<CR>

"paste from web toggle
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode

" Ruby stuff ******************************************************************
compiler ruby         " Enable compiler support for rjmuby
map <F5> :!ruby %<CR>

" validates ruby syntax while in the file
map ,ruby :!ruby -c %<CR>

" extract to method
noremap ,e :call Ruby_extract_method()<CR>
function! Ruby_extract_method() range
  let name = inputdialog("Name of new method:")
  normal! '<d'>
  exe "normal! kocaller = " . name
  exe "normal! GO\<CR>def " . name . "\<CR>end"
  normal! koRUBY_EXTRACT_METHOD
  normal! ]pkdd
endfunction


" Omni Completion
" *************************************************************
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
" " May require ruby compiled in
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete 
"

" Invisible characters *********************************************************
set listchars=trail:.,tab:>-,eol:$
set nolist
:noremap ,i :set list!<CR> " Toggle invisible chars

" Snipmate author variable
let g:snips_author = 'Ryan Svihla'

" gherkin syntax highlighting 
"au! Syntax gherkin source ~/.vim/syntax/cucumber.vim
"
"sql utils
vmap <silent>sf        <Plug>SQLU_Formatter<CR>
nmap <silent>scl       <Plug>SQLU_CreateColumnList<CR>
nmap <silent>scd       <Plug>SQLU_GetColumnDef<CR>
nmap <silent>scdt      <Plug>SQLU_GetColumnDataType<CR>
nmap <silent>scp       <Plug>SQLU_CreateProcedure<CR> 



set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

" Bundles:
