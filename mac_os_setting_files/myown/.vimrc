" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" (Canceled)
" Better matching braces
" This way, whenever you type % you jump to the matching object,
" and you visually select all the text in between.
" It's useful for indenting a C/C++ method/class:
" go to opening/closing brace, and type '=%'
"noremap % v%

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F2>

" Easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv
vnoremap > >gv

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod

" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

" Useful settings
set history=700
set undolevels=700

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive only when a pattern contains lowercase letters only
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Vim will use the clipboard register '*' as well as the unnamed register
" for ordinary yank, delete, change and put operations.
" e.g. yy => stored both to clipboard register("*) and unnamed register("")
"      "*yy => stored both to "* and ""
"      ""yy => stored only to ""
"      "ayy => stored both to "a and ""
set clipboard=unnamed

" If "set clipboard=unnamed" in the above is NOT supported, the following key
" mappings can be used to use the system clipboard for ordinary yank, delete,
" change and put operations.
"nnoremap y "+y
"vnoremap y "+y
"nnoremap x "+x
"vnoremap x "+x
"nnoremap d "+d
"vnoremap d "+d
"nnoremap c "+c
"vnoremap c "+c
"nnoremap p "+p
"vnoremap p "+p
"nnoremap P "+P
"vnoremap P "+P

" Display line numbers
"set nu

" Use a non-blinking block cursor for all modes
set guicursor=a:block-blinkon0

" Paste from the clipboard when CTRL-V is pressed in Insert mode or
" Command-line mode on Windows platforms.
if has("win32")
  inoremap <C-V> <C-R>+
  cnoremap <C-V> <C-R>+
endif

" Apply a font on Windows platforms
if has("win32")
  set guifont=굴림체:h16:cHANGEUL:qDRAFT
endif

" Automatically append closing characters
inoremap        [          []<Left>
inoremap        [<CR>      [<CR>]<Esc>O
inoremap        <Leader>[  [
inoremap <expr> ]          strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"

inoremap        {          {}<Left>
inoremap        {<CR>      {<CR>}<Esc>O
inoremap        <Leader>{  {
inoremap <expr> }          strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"

inoremap        (          ()<Left>
inoremap        (<CR>      (<CR>)<Esc>O
inoremap        <Leader>(  (
inoremap <expr> )          strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

inoremap        <          <><Left>
inoremap        <<CR>      <<CR>><Esc>O
inoremap        <Leader><  <
inoremap <expr> >          strpart(getline('.'), col('.')-1, 1) == ">" ? "\<Right>" : ">"

inoremap <expr> '          strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
inoremap        '<CR>      '<CR>'<Esc>O
inoremap        <Leader>'  '

inoremap <expr> "          strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
inoremap        "<CR>      "<CR>"<Esc>O
inoremap        <Leader>"  "

inoremap        /*<CR>     /*<CR>*/<Esc>O
