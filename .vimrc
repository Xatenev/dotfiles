" Vim-Plug

" install vim-plug automatically
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-devdocs'
Plug 'mbbill/undotree'
Plug 'iberianpig/tig-explorer.vim'
Plug 'szw/vim-maximizer' 
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'elzr/vim-json'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'danro/rename.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'machakann/vim-highlightedyank'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'tpope/vim-vinegar'
Plug 'protesilaos/tempus-themes-vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()

" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set termguicolors
set t_Co=256   " This may or may not be needed.
set background=dark

syntax enable
colorscheme nord
let g:lightline = { 'colorscheme': 'nord' }

" UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set relativenumber number
syntax on
filetype plugin indent on
set laststatus=2

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" highlight current line
set cursorline!
" command line height increase
set cmdheight=2
" window splitting
set splitbelow
set splitright
" search index
set shortmess-=S

" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
runtime macros/matchit.vim
" vim shares clipboard with os
if has("win32")
    set clipboard=unnamed
else
    set clipboard=unnamedplus
endif
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
let &softtabstop = &tabstop
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

" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" windows
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>

" jumps (to marks)
nnoremap ' `

" files
nnoremap <Leader>ef :find *
nnoremap <Leader>ev :sfind *
nnoremap <Leader>eh :vert sfind *
nnoremap <Leader>et :tabfind *

" buffers
nnoremap <Leader>b         :buffer *
nnoremap <Leader>l :ls<CR>:b<space>

nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap <BS>       :buffer#<CR>

" tags
" nnoremap <Leader>dj :tjump /
" nnoremap <Leader>dd :ptjump /

" matches 
nnoremap <Leader>i :ilist /
nnoremap [I [I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>
nnoremap ]I ]I:ijump<Space><Space><Space><C-r><C-w><S-Left><Left><Left>

" changes, change word and highlight occurences
nnoremap <Leader>; *``cgn
nnoremap <Leader>, #``cgN

" quickfix list
nnoremap <End>  :cnext<CR>
nnoremap <Home> :cprevious<CR>

" search and replace
nnoremap <Leader>ra :%s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>
nnoremap <Leader>rl       :s/\<<C-r>=expand("<cword>")<CR>\>//g<Left><Left>

nnoremap <Leader>G :Find <c-r>=expand("<cword>")<cr><CR>

cnoremap <expr> <Tab>   getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>/<C-r>/" : "<C-z>"
cnoremap <expr> <S-Tab> getcmdtype() == "/" \|\| getcmdtype() == "?" ? "<CR>?<C-r>/" : "<S-Tab>"

" listing
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
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore -g "!tags" --hidden --follow --glob "!ext/*" --glob "!build/*" --glob "!.classic.json" --glob "!.modern.json" --glob "!.git/*" --glob "!*.jsonp" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, 
            \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
            \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
            \   <bang>0)


command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

set keywordprg=:DD

if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

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
set nofixendofline
set hlsearch

 "clear search on esc
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>*[
nnoremap <esc> <c-w>z

nnoremap <Leader>wf :MaximizerToggle<CR>

let g:vim_json_syntax_conceal = 0

" buffergator
let g:buffergator_suppress_keymaps = 1
let g:buffergator_autoupdate = 1
let g:buffergator_autoexpand_on_split = 0
let g:buffergator_autodismiss_on_select = 0

nnoremap <F2> :Rename<Space>

" override maximizer window
let g:maximizer_set_default_mapping = 0
nmap <F3> :Files<CR>
nnoremap <F4> :Find<Space>

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Doesn't seem to work well
if !exists('##TextYankPost')
  map y <Plug>(highlightedyank)
endif

if has('nvim')
    set inccommand=split
endif


" better completion menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap        ,,      <C-n><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,-      <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,:      <C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
inoremap        ,=      <C-x><C-l><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>\<lt>C-p>" : ""<CR>
set omnifunc=complete#Complete

set wildignorecase

hi cCustomFunc  gui=bold guifg=#ff7f00
hi cCustomClass gui=reverse guifg=#ff7f00


"fix indention on paste
:nnoremap p p=`]

if has("gui_running")
    " windows
    set guifont=Menlo:h9
    " linux
    " set guifont=Ubuntu\ Mono\ 10
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
endif

let g:netrw_banner = 1
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:NetrwIsOpen=0	

function! ToggleNetrw()	
    if g:NetrwIsOpen	
        let i = bufnr("$")	
        while (i >= 1)	
            if (getbufvar(i, "&filetype") == "netrw")	
                Rexplore
            endif	
            let i-=1	
        endwhile	
        let g:NetrwIsOpen=0	
    else	
        let g:NetrwIsOpen=1	
        silent Explore	
    endif	
endfunction	

nnoremap <Tab><Tab> :call ToggleNetrw()<CR>

nnoremap <Leader>p :let @+=expand('%:p')<CR>
nnoremap <F5> :call XToggleBuffergator()<CR>

function! XToggleBuffergator() 
     let mybufname=bufnr('%')
     :BuffergatorToggle
     exec bufwinnr(mybufname) . 'wincmd w'
endfunction

nnoremap <F12> :set relativenumber!<CR>
