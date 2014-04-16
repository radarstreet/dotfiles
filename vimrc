execute pathogen#infect()
syntax on
set t_Co=256
"set background=dark
set background=light
let g:solarized_termcolors=256
colorscheme solarized
au VimLeave * !reset
set modeline

" Plugin settings
let g:digital_cheetah_sites='/home/radarstreet/sites/'

filetype plugin on
"set list
set listchars=tab:▸\ ,eol:¬
nnoremap ,l :set list! list?<CR>

set autoindent  " new line's indent level the same as current
set spell " turn on spell checking

" Since people here do not like spaces as tabs
"set expandtab
"set tabstop=4
"set shiftwidth=4

set tabstop=4
set noexpandtab
set shiftwidth=4

set fileencodings=utf-8
set nocompatible
"set isk+=-
set ruler "show status line at the bottom of the window
set colorcolumn=80
"highlight ColorColumn ctermbg=14
"highlight ColorColumn ctermbg=16

"set hlsearch
" set tw=79 formatoptions=tc

"set autoindent
"set nopaste

set nowrap
"set linebreak
"let &showbreak = '+++ '

set backspace=2

"""""""""""""""""""
"""Abbreviations"""
"""""""""""""""""""

"ab _MB <!--MPBLOCK:__FILE__--><!--MPENDBLOCK:__FILE__-->
"ab _MPVAR <!--MPVAR:
"ab _MPIF <!--MPIF:<!--MPENDIF-->

"""""""""""""""""""""""""
"""Syntax Declarations"""
"""""""""""""""""""""""""

autocmd! BufNewFile * silent! 0r ~/.vim/skel/tmpl.%:e

" hg commit messages
au BufRead,BufNewFile hg-editor-*.txt set ft=mercurial
au! Syntax mercurial source $HOME/.vim/syntax/mercurial.vim

au BufRead,BufNewFile *.htm call s:MP_FILE()

fun! s:MP_FILE()
let n = 1
while n < 10 && n < line("$")
if getline(n) =~ '[<][!]--MPBLOCK:'
set ft=mp_html
return
endif
let n = n + 1
endwhile
endfun
au! Syntax mp_html source $HOME/.vim/syntax/mp_html.vim

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

"""""""""""""""""""""""
"""FILE TYPE OPTIONS"""
"""""""""""""""""""""""
aug rd
au! FileType mercurial setl tw=79 formatoptions=tc
aug END

imap jj <ESC>

"""""""""""""""""""""""""
"""Dealing with Spaces"""
"""""""""""""""""""""""""

" Remove ALL leading whitespace
noremap ,untab :%s/^\s\+

"highlight ExtraWhitespace guibg=DarkCyan ctermbg=DarkRed
"au ColorScheme * highlight ExtraWhitespace guibg=DarkCyan ctermbg=DarkRed
"au BufWinEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
"au BufWrite * match ExtraWhitespace /\s\+$\| \+\ze\t/

" Stolen maps
map ,v :sp ~/.vimrc<cr> " edit my .vimrc file in a split
map ,e :e ~/.vimrc<cr>      " edit my .vimrc file
map ,u :source ~/.vimrc<cr> " update the system settings from my vimrc file

" HG maps
map ,ci :w<cr>:!hg_test<cr>

" have \th ("toggle highlight") toggle highlighting of search matches, and
" report the change:
nnoremap ,; :set invhls hls?<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" MACROS                                                                    ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let@c='^i/*$a*/'
let@b='79A*d79|o *o*79A*d79|r/kA '
let@q='i$DEBUG eq "TRUE" ? print "" . $NEWLINE : undef;2T"i'

" changes highlight color from a dark blue to a much more palatable bright cyan
"hi! Comment  term=bold  ctermfg=White  guifg=White

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" MAPS                                                                      ""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
	nmap <C-S-Insert> "+gP
	imap <C-S-Insert> <ESC><C-S-Insert>i
	vmap <C-C> "+y
endif

set wildmode=longest,list,full
"set wildmenu

" wraps text at 72nd column
"au BufRead /tmp/mutt* normal :set tw=72^M^L

" wraps text files at 80 columns
"au BufRead *.txt normal :set tw=80^M^L

" strips signiture -- leaves trailing > on some messages
"au BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction
