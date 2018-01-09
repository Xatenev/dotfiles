call plug#begin()

Plug 'scrooloose/nerdcommenter'
Plug 'szw/vim-g'
Plug 'itchyny/lightline.vim'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'simnalamburt/vim-mundo'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'romainl/apprentice'

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
set notimeout ttimeout ttimeoutlen=200

" Autocomplete for :e for example using wildmenu
set wildmode=longest,list,full
set wildmenu

" Use <F11> to toggle between 'paste(disables autoindent for pasted content)' and 'nopaste(enables autoindent for pasted content)'
set pastetoggle=<F11>

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

" Close window
nnoremap <M-q> :q<CR>

" Save window
nnoremap <M-w> :w<CR>

nnoremap <Leader>h :MundoToggle<CR>
" Open new split panes to right and bottom which feels more natural
" than Vim's default
set splitbelow
set splitright


" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Highlight searches
set hlsearch

" Show partial commands in the last line of the screen
set showcmd

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 

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


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>


" colorscheme
set background=dark
" set termguicolors
syntax on
colorscheme apprentice
