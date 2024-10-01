" -------------------------------------------------------------------------------
" Basic Developer IDE
" -------------------------------------------------------------------------------

syntax on                          " Allow color
set termguicolors                  " Almost 24-bit colors
set background=dark                " Color theme is dark
colorscheme gruvbox                " Recommended for c programming

set tabstop=4                      " Tab key is 4 characters wide
set expandtab                      " Tab key inserts spaces
set shiftwidth=4                   " Indentation is 4 characters
set ai                             " Auto-indenting
set backspace=indent,eol,start     " Allows deleting prior to insert
set wildmenu                       " Display completion matches in status line
autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespace

" Return to the line when exited
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif



" Columns and Rows
" -------------------------------------------------------------------------
set nu                                   " Line numbering
set relativenumber                       " Line numbering
hi ColorColumn guibg=blue                " Highlight vertical line
set cursorline                           " Highlight cursor line
set textwidth=100                        " Max line width
set colorcolumn=+0                       " Show line
set viminfo='100,f1                      " Save marks and djumps
set scrolloff=5                          " Scroll padding
autocmd InsertEnter * set cursorcolumn!  " Insert mode show vertical highlighting
autocmd InsertLeave * set cursorcolumn!  " Normal mode removes vertical highlighting
" -------------------------------------------------------------------------


" Search and spell
" -------------------------------------------------------------------------
set hlsearch                   " Highlight search results
set smartcase                  " Better searching
set nu                         " Line numbering
" Spelling highlight
hi SpellBad ctermfg=white ctermbg=lightmagenta guifg=white guibg=green
" Allow c-x c-k autocomplete to dictionary
set dictionary+=/usr/share/dict/words
" -------------------------------------------------------------------------


" Tabs and Buffers
" -------------------------------------------------------------------------
set hidden    " Allows switching buffers w/o saving
" -------------------------------------------------------------------------

" Status line
" -------------------------------------------------------------------------
let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'NormalÂ·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'VÂ·Line',
    \ '^V' : 'VÂ·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'SÂ·Line',
    \ '^S' : 'SÂ·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'VÂ·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

set laststatus=2
let b = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
set statusline=%{b}
set statusline+=%4*\ %{toupper(g:currentmode[mode()])}\  " The current mode
set statusline+=%2*\ (%n)\ %t\ %m%r[%3*%l,%v%2*]\ [%p%%\ of\ %L]
set statusline+=%1*%=\ %F
hi User1 ctermbg=grey ctermfg=green guifg=black guibg=#99BBEE
hi User2 ctermbg=darkblue ctermfg=grey guibg=#3366AA guifg=grey
hi User3 ctermbg=darkblue ctermfg=yellow guibg=#3366AA guifg=yellow
hi User4 ctermfg=darkgrey ctermbg=red guibg=#444464 guifg=lightblue
" -------------------------------------------------------------------------


" -------------------------------------------------------------------------
" Sets folding
" -------------------------------------------------------------------------
set foldmethod=marker
set foldlevel=99
set foldcolumn=2
" Color the fold
highlight Folded guibg=darkgreen guifg=green
" Fold column coloring
" highlight FoldColumn guibg=darkblue guifg=white
highlight FoldColumn guifg=green
" Remember folding
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END
" -------------------------------------------------------------------------

" -------------------------------------------------------------------------
" Space H : Leader key and shortcuts
" -------------------------------------------------------------------------
" Leader key: <SPACE>
nnoremap <SPACE> <Nop>
let mapleader=" "
map <leader>c :call CommentToggle()<CR>                   " Toggle comments
map <leader>f za                                          " Toggle folding
map <leader>g gt                                          " Previous tab
map <leader>h :call ToggleFile("~/.vim/vimhelp.txt")<CR>  " Space Help Menu
map <leader>i '.                                          " Return to last insert
map <leader>j <C-]>                                       " Ctag jump to definition
map <leader>k <C-t>                                       " Ctag return from definition
map <leader>m :call ToggleMem("~/.vim/vim-mem.txt")<CR>   " Vim memory
map <leader>o :tabe
map <leader>s ]s                                          " Next spelling error
map <leader>S :set spell!<CR>                             " Spelling on/off
map <leader>t g<TAB>                                      " Toggle tag
map <leader>z 1z=<CR>                                     " Spell correct
nnoremap <leader>n <C-^>                                  " Toggle buffer
nnoremap <leader>w <C-w><C-w>                             " Cycle window splits
" -------------------------------------------------------------------------


" Comment/Uncomment
" -------------------------------------------------------------------------
filetype on
augroup commenting_blocks_of_code
  autocmd!
  autocmd FileType c,cpp,java,scala let b:comment_leader = '//'
  autocmd FileType sh,ruby,python   let b:comment_leader = '#'
  autocmd FileType conf,fstab       let b:comment_leader = '#'
  autocmd FileType vim              let b:comment_leader = '"'
augroup END

function! CommentToggle()
    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
" -------------------------------------------------------------------------


" -------------------------------------------------------------------------
" Space H(elp) Help Menu
" -------------------------------------------------------------------------
function! ToggleFile(filename)
  let bufnr = bufnr(a:filename)

  if bufnr > 0 && buflisted(bufnr)
    execute bufnr . 'bd'
  else
    execute 'vsp' fnameescape(a:filename)
    execute 'set nonu nornu foldcolumn=0'
  endif
endfunction


" -------------------------------------------------------------------------
" Space H(elp) Help Menu
" -------------------------------------------------------------------------
function! ToggleMem(filename)
  let bufnr = bufnr(a:filename)

  if bufnr > 0 && buflisted(bufnr)
    execute bufnr . 'bd'
  else
    execute 'leftabove 20vsp' fnameescape(a:filename)
    execute 'set nonu nornu foldcolumn=0'
  endif
endfunction


" -------------------------------------------------------------------------
" Functions
" -------------------------------------------------------------------------
function! ToggleNumberColumn()
  execute 'set nu! rnu!'
  " Check if number line is enabled
  if &number
    execute 'set foldcolumn=2'
  else
    execute 'set foldcolumn=0'
  endif
endfunction


" -------------------------------------------------------------------------
" IDE
" -------------------------------------------------------------------------
" Support opening new windows to the right
set splitright

" Supports omnifunc (possibly)
filetype plugin on
" Allows Ctrl-x Ctrl-o for autocomplete
set omnifunc=syntaxcomplete#Complete

" Enable packloadall for pack plugins to support SuperTab
packloadall

" Filename completion single Control-f
inoremap <C-f> <C-x><C-f>
inoremap <C-o> <C-x><C-o>

" Search current dir (.vimrc)
set tags=./tags,tags
" -------------------------------------------------------------------------


" -------------------------------------------------------------------------
" Custom comands
" -------------------------------------------------------------------------
" Save session and exit all
command! XX mks! | xa


" -------------------------------------------------------------------------
" Key Mappings Function Keys
" -------------------------------------------------------------------------

" F1: Reserved: System help

" F2: Vim help
nmap <F2> :call ToggleFile("~/.vim/vimhelp.txt")<CR>


" F3: Toggle line numbers (in normal mode)
nmap <F3> :call ToggleNumberColumn()<CR>


" F4: Turn on/off syntax highlighting
map <F4> :if exists("g:syntax_on") <Bar> syntax off<Bar> else<Bar> syntax enable<Bar> endif<CR>


" F5: Run Python
map <F5> <Esc>:w<CR>: !clear;python3 %<CR>
" Shift F5: Run pylint
map <S-F5> <Esc>:w<CR>: !clear;pylint %<CR>
" Control F5: Run pycodestyle
map <C-F5> <Esc>:w<CR>:! clear;pycodestyle --max-line-length=100 %<CR>
" ALT F5: Pylint in a Quickfix list (Requires pylint.vim placed in ~/.vim/compiler/)
map <M-F5> <Esc>:compiler pylint<CR>:make<CR>


" F6: Toggles comment/uncomment
map <F6> :call CommentToggle()<CR>


" F7: View whitespace
"nnoremap <F7> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$ list! list? <CR>
" F7: C Compile
map <F7> <Esc>:w<CR>: !clear;gcc %;./a.out<CR>


" F8: Numbering
nmap <F8> :set nornu!<CR>
" Shift F8: Prep git commit message
map <C-F8> gg4ddj2ddk3dwA:


" F9: Retag
map <F9> :!ctags -R<CR>


" F10: map <F10>
" CTRL F10: Hex display
map <C-F10> :%!xxd <CR>
" SHIFT F10: Hex display off
map <S-F10> :%!xxd -r <CR>


" F11: Reserved for full screen


" F12: Update vimrc file
:map <F12> :source ~/.vimrc <CR>

" command! RunMacroA normal!  gg4dd3dwA:€ýajddddxggA q€kb€ýa
