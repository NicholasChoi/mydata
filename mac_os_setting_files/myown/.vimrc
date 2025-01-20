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

" TABs are needed in specific kinds of documents
"set tabstop=8
"set shiftwidth=8
"set noexpandtab

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

" Apply a font
if has("win32")
  set guifont=굴림체:h16:cHANGEUL:qDRAFT
else
  set guifont=Menlo:h18
endif

" Disable the Input Method (IM)
set noimd

" Set a linespace
set linespace=16

" Make whitespaces visible
set list
set listchars=tab:\ \ 
"set listchars=tab:>-
"set listchars+=space:_
"set listchars+=trail:@

" Automatic completion
let snippets = []

" (The function below is currently unused)
"function! AddSnippetOfWordWithRoundBracketedWords()
"    let line = getline('.')
"    let start = col('.') - 1
"    while start > 0 && line[start - 1] != '('
"        let start -= 1
"    endwhile
"    if start > 0
"        let start -= 1
"    endif
"    while start > 0 && line[start - 1] =~ '\S'
"        let start -= 1
"    endwhile
"    let extractedString = strpart(getline('.'), start, col('.') - 1 - start)
"    if extractedString != ''
"        let targetedSnippet = extractedString .. ')'
"        if index(g:snippets, targetedSnippet) == -1
"            call add(g:snippets, targetedSnippet)
"        endif
"    endif
"    return 0
"endfunction

" (The mapping below is currently unused) automatic completion to the word followed by a number in round brackets
"inoremap $$ <Esc>maviW"cy?<Space><C-R>c\S*([0-9]\+\(,<Space>[0-9]\+\)*)<CR>lyf)`aviWpa

function! AddSnippet()
    let line = getline('.')
    let start = col('.') - 1
    " finding one of '(', ')', '{', '}', '[', ']', ':', ';' or a whitespace
    while start > 0 && line[start - 1] !~ '[(){}[\]:;]\|\s'
        let start -= 1
    endwhile
    let targetedSnippet = strpart(getline('.'), start, col('.') - 1 - start)
    if strlen(targetedSnippet) >= 2 && index(g:snippets, targetedSnippet) == -1
        call add(g:snippets, targetedSnippet)
    endif
    return 0
endfunction

function! AutoindentOnCR()
    if strpart(getline('.'), col('.') - 2, 2) == '{}'
        return "\<CR>\<Esc>O"
    " (The two lines below are currently unused)
    "elseif strpart(getline('.'), col('.') - 3, 2) == '/*'
    "    return "\<CR>/\<Esc>O"
    endif
    return "\<CR>"
endfunction

function! CompleteSnippet(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        " finding one of '(', ')', '{', '}', '[', ']', ':', ';' or a whitespace
        while start > 0 && line[start - 1] !~ '[(){}[\]:;]\|\s'
            let start -= 1
        endwhile
        return start
    else
        " find snippet candidates matching with the base
        let candidates = []
        for item in g:snippets
            if item =~ '^' . a:base
                call add(candidates, item)
            endif
        endfor
        return candidates
    endif
endfunction
set completefunc=CompleteSnippet

function! AutocompleteOnTab()
    if pumvisible() != 0
        return "\<C-N>"
    " if the cursor is on the first character of the line or the preceding character of the cursor is one of '(', ')', '{', '}', '[', ']', ':', ';' or a whitespace
    elseif col('.') == 1 || strpart(getline('.'), col('.') - 2, 1) =~ '[(){}[\]:;]\|\s'
        return "\<Tab>"
    endif
    return "\<C-X>\<C-U>"
endfunction

function! HandleKeyInput(key, whetherKeyInputIsWithMapleader = 0)
    " (The line below is currently unused; <Tab> preceded by a word is to be used for a shortcut for automatic completion) if the key is one of ')', '}', ']', ':', ';', a carriage return or a whitespace
    "if a:key =~ '[)}\]:;\r]\|\s'
    " if the key is one of ')', '}', ']', ':', ';', a space or a carriage return
    if a:key =~ '[)}\]:; \r]'
        call AddSnippet()
    endif

    if a:key == '}' && a:whetherKeyInputIsWithMapleader != 0 && strpart(getline('.'), col('.') - 1, 1) == '}'
        return "\<Right>"
    elseif a:key == "\r"
        return AutoindentOnCR()
    elseif a:key == "\t"
        return AutocompleteOnTab()
    endif
    return a:key
endfunction

inoremap <expr> ) HandleKeyInput(')')
inoremap <expr> } HandleKeyInput('}')
inoremap <expr> <Leader>} HandleKeyInput('}', 1)
inoremap <expr> ] HandleKeyInput(']')
inoremap <expr> : HandleKeyInput(':')
inoremap <expr> ; HandleKeyInput(';')
inoremap <expr> <CR> HandleKeyInput("\<CR>")
inoremap <expr> <Space> HandleKeyInput("\<Space>")
inoremap <expr> <Tab> HandleKeyInput("\<Tab>")

function! AddSnippetUsingVisualBlock()
    let tempContainer = @a
    normal gv"ay
    if index(g:snippets, @a) == -1
        call add(g:snippets, @a)
    endif
    let @a = tempContainer
endfunction

vnoremap <silent> as :<C-U>call AddSnippetUsingVisualBlock()<CR>

" Automatically append closing characters upon key inputs with mapleaders
inoremap <Leader>{ {}<Left>
inoremap <expr> <Leader>' strpart(getline('.'), col('.') - 1, 1) != "\'" ? "\'\'\<Left>" : "\<Right>"
inoremap <expr> <Leader>" strpart(getline('.'), col('.') - 1, 1) != "\"" ? "\"\"\<Left>" : "\<Right>"
inoremap <Leader><Leader> <Leader>
