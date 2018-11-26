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
Plug 'romainl/vim-devdocs'
Plug 'mbbill/undotree'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'dracula/vim'
Plug 'vim-scripts/vim-auto-save'
Plug 'iberianpig/tig-explorer.vim'
Plug 'vim-scripts/ZoomWin'
Plug 'rakr/vim-two-firewatch'
call plug#end()


set clipboard=unnamedplus
set relativenumber number
let mapleader = ","

set background=dark
set termguicolors
let g:two_firewatch_italics=1
color two-firewatch
let g:airline_theme='twofirewatch'
"set cursorline
"hi CursorLine term=bold cterm=bold guibg=Grey10


" filetype support
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

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
nnoremap <Leader>ef :find *
nnoremap <Leader>ev :sfind *
nnoremap <Leader>eh :vert sfind *
nnoremap <Leader>et :tabfind *

" juggling with buffers
nnoremap <Leader>b         :buffer *

nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap <BS>       :buffer#<CR>

" juggling with tags
nnoremap <Leader>j :tjump /
nnoremap <Leader>p :ptjump /

" juggling with matches
nnoremap <Leader>i :ilist /
nnoremap [I [I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>
nnoremap ]I ]I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>

" juggling with changes
nnoremap <Leader>; *``cgn
nnoremap <Leader>, #``cgN

" juggling with quickfix entries
nnoremap <End>  :cnext<CR>
nnoremap <Home> :cprevious<CR>

" super quick search and replace
nnoremap <Leader>ra :%s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>
nnoremap <Leader>rl       :s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>

" better completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap        <Leader>,      <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        <Leader>:      <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        <Leader>=      <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>

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

autocmd GUIEnter * set vb t_vb=
autocmd VimEnter * set vb t_vb=

" split windows
nnoremap ,wh :vsp<CR>
nnoremap ,wv :sp<CR>
nnoremap ,q :q<CR>
nnoremap ,h :UndotreeToggle<CR>

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
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden -g "*.js" -g "*.java" --follow --glob "!build/*" --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%'),
            \   <bang>0)

command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

set keywordprg=:DD

if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

" NERDTree configuration
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

nnoremap <Tab><Tab> :NERDTreeToggle<CR>
nnoremap <silent> <Tab>. :NERDTreeFind<CR>

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeWinSize = 31
let NERDTreeShowHidden = 1
let NERDTreeMouseMode = 2
let NERDTreeShowLineNumbers = 1

let g:auto_save = 1  " enable AutoSave on Vim startup

" Configure tig explorer
nnoremap <Leader>gb :TigBlame<CR>
nnoremap <Leader>gh :TigOpenCurrentFile<CR>

nnoremap <C-Down> :m .+1<CR>==
nnoremap <C-Up> :m .-2<CR>==

inoremap <C-Down> <Esc>:m .+1<CR>==gi
inoremap <C-Up> <Esc>:m .-2<CR>==gi

vnoremap <C-Down> :m '>+1<CR>gv=gv
vnoremap <C-Up> :m '<-2<CR>gv=gv

set ignorecase

nnoremap <silent> <Leader>wf :ZoomWin<CR>




