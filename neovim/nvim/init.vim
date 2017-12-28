call plug#begin()

Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'
Plug 'szw/vim-g'
Plug 'itchyny/lightline.vim'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'simnalamburt/vim-mundo'
Plug 'jeetsukumaran/vim-buffergator'

call plug#end()

" Persistent sessions
" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir
set smartcase
set ignorecase
" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Set tab to be 4 spaces 
set tabstop=4
set softtabstop=4 noexpandtab
set shiftwidth=4

" Timeout length needed for plugins
set timeout ttimeoutlen=50

" Autocomplete for :e for example using wildmenu
set wildmode=longest,list,full
set wildmenu

" Change cursor in insert mode
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
silent !echo -ne "\033[2 q"
autocmd VimLeave * silent !echo -ne "\033[6 q"


" Disable visual bell
" Disable visual flash
autocmd GUIEnter * set vb t_vb= " for your GUI
autocmd VimEnter * set vb t_vb=

" set relative line numbers aswell as absolute line number for the
" current
" line
set number relativenumber

" Set leader
let mapleader=" "
" I really only want one clipboard cause im used to it
set clipboard=unnamedplus

" Ctrl + Arrow key to move between windows
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>

" Lightline Configuration
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'name' ] ]
      \ },
      \ 'component': {
      \   'name': 'VIMenev'
      \ },
      \ }

" Split windows
nnoremap <M-v> :sp<CR>
nnoremap <M-h> :vsp<CR>

" Tabs 
nnoremap <M-t> :tabnew<CR>

" Buffers
nnoremap <M-n> :badd empty || :bfind empty<CR>

" Close window
nnoremap <M-q> :q<CR>

" Save window
nnoremap <M-w> :w<CR>

nnoremap <Leader>h :MundoToggle<CR>
" Open new split panes to right and bottom which feels more natural
" than Vim's default
set splitbelow
set splitright

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)


" colorscheme
set background=dark
set termguicolors
colorscheme torte

let g:deoplete#enable_at_startup = 1
"let g:python3_host_prog = '/usr/bin/python3'
let g:python3_host_prog = 'C:\Users\gerdt\AppData\Local\Programs\Python\Python36-32\python3'
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'

