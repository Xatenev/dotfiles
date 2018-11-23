" Install vim-plug automatically
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'
call plug#end()


set termguicolors
set clipboard=unnamedplus
set relativenumber
set number

color ceudah

" filetype support
filetype plugin indent on
syntax on

" because it's there
runtime macros/matchit.vim

" various settings
set autoindent
set backspace=indent,eol,start
set complete+=d
set foldlevelstart=999
set foldmethod=indent
set grepprg=LC_ALL=C\ grep\ -nrsH
set hidden
set incsearch
set mouse=a
set noswapfile
set path& | let &path .= "**"
set ruler
set shiftround
set shiftwidth=0
let &softtabstop = &tabstop
set tags=./tags;,tags;
set wildcharm=<C-z>
set wildmenu
set wildmode=full

" various autocommands
augroup minivimrc
	autocmd!
	" automatic location/quickfix window
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost    l* lwindow
	autocmd VimEnter            * cwindow

	" Git-specific settings
	autocmd FileType gitcommit nnoremap <buffer> { ?^@@<CR>|nnoremap <buffer> } /^@@<CR>|setlocal iskeyword+=-
augroup END
"
" commands for adjusting indentation rules manually
command! -nargs=1 Spaces execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " expandtab" | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   execute "setlocal tabstop=" . <args> . " shiftwidth=" . <args> . " softtabstop=" . <args> . " noexpandtab" | setlocal ts? sw? sts? et?

" juggling with windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" juggling with jumps
nnoremap ' `

" juggling with files
nnoremap ,f :find *
nnoremap ,s :sfind *
nnoremap ,v :vert sfind *
nnoremap ,t :tabfind *

" juggling with buffers
nnoremap ,b         :buffer *
nnoremap ,B         :sbuffer *
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap <BS>       :buffer#<CR>

" juggling with tags
nnoremap ,j :tjump /
nnoremap ,p :ptjump /

" juggling with definitions
nnoremap ,d :dlist /
nnoremap [D [D:djump<Space><Space><Space><C-r><C-w><S-Left><Left>
nnoremap ]D ]D:djump<Space><Space><Space><C-r><C-w><S-Left><Left>

" juggling with matches
nnoremap ,i :ilist /
nnoremap [I [I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>
nnoremap ]I ]I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>



" juggling with changes
nnoremap ,; *``cgn
nnoremap ,, #``cgN

" juggling with quickfix entries
nnoremap <End>  :cnext<CR>
nnoremap <Home> :cprevious<CR>

" super quick search and replace
nnoremap <Space><Space> :%s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>
nnoremap <Space>%       :s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>
nnoremap <Space>$       ciw

" better completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap        ,,      <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,:      <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,=      <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>

" pair expansion on the cheap
inoremap (<CR> (<CR>)<Esc>O
inoremap (;    (<CR>);<Esc>O
inoremap (,    (<CR>),<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {;    {<CR>};<Esc>O
inoremap {,    {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [;    [<CR>];<Esc>O
inoremap [,    [<CR>],<Esc>O

" smooth grepping
command! -nargs=+ -complete=file_in_path -bar Grep silent! grep! <args> | redraw!

" smooth searching
cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

" smooth listing
cnoremap <expr> <CR> <SID>CCR()
function! s:CCR()
	command! -bar Z silent set more|delcommand Z
	if getcmdtype() == ":"
		let cmdline = getcmdline()
		if cmdline =~ '\v\C^(dli|il)' | return "\<CR>:" . cmdline[0] . "jump   " . split(cmdline, " ")[1] . "\<S-Left>\<Left>\<Left>"
		elseif cmdline =~ '\v\C^(cli|lli)' | return "\<CR>:silent " . repeat(cmdline[0], 2) . "\<Space>"
		elseif cmdline =~ '\C^changes' | set nomore | return "\<CR>:Z|norm! g;\<S-Left>"
		elseif cmdline =~ '\C^ju' | set nomore | return "\<CR>:Z|norm! \<C-o>\<S-Left>"
		elseif cmdline =~ '\v\C(#|nu|num|numb|numbe|number)$' | return "\<CR>:"
		elseif cmdline =~ '\C^ol' | set nomore | return "\<CR>:Z|e #<"
		elseif cmdline =~ '\v\C^(ls|files|buffers)' | return "\<CR>:b"
		elseif cmdline =~ '\C^marks' | return "\<CR>:norm! `"
		elseif cmdline =~ '\C^undol' | return "\<CR>:u "
		else | return "\<CR>" | endif
	else | return "\<CR>" | endif
endfunction


:set cursorline!
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=

" split windows
nnoremap <M-v> :sp<CR>
nnoremap <M-h> :vsp<CR>

nnoremap <M-q> :q<CR>
nnoremap <M-w> :w<CR>

set splitbelow
set splitright

 " --column: Show column number
 " --line-number: Show line numober
 " --no-heading: Do not show file headings in results
 " --fixed-strings: Search term as a literal string
 " --ignore-case: Case insensitive search
 " --no-ignore: Do not respect .gitignore, etc...
 " --hidden: Search hidden files and folders
 " --follow: Follow symlinks
 " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
 " --color: Search color options
 command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case     --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
