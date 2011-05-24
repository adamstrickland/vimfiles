"tabs and other goods taken from web
set hidden
set expandtab
set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number        " always show line numbers
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

"backup files go away
set nobackup
set noswapfile

"pretty stuff
syntax on
:colorscheme vividchalk
set list

"autocommand foo
:autocmd Filetype ruby set softtabstop=2
:autocmd Filetype ruby set sw=2
:autocmd Filetype ruby set ts=2

:autocmd Filetype feature set softtabstop=2
:autocmd Filetype feature set sw=2
:autocmd Filetype feature set ts=2

:autocmd Filetype haml set softtabstop=2
:autocmd Filetype haml set sw=2
:autocmd Filetype haml set ts=2
"set listchars
if has('autocmd')
    filetype plugin indent on
endif

"mappings
nnoremap <F4> :set invpaste paste?<CR>
set pastetoggle=<F4>
set showmode

map <F2> <C-W>w

