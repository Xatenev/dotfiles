call plug#begin()

Plug 'scrooloose/nerdcommenter'
Plug 'szw/vim-g'
Plug 'xolox/vim-misc'
Plug 'simnalamburt/vim-mundo'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'wesq3/vim-windowswap'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'flazz/vim-colorschemes'

call plug#end()

filetype plugin indent on

let vimDir = '~/.vim'
let &runtimepath .= ',' . vimDir
set smartcase
set ignorecase


" auto change current directory
" set autochdir
set noautochdir

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
"set notimeout ttimeout ttimeoutlen=200

" Autocomplete for :e for example using wildmenu
set wildmode=longest,list,full
set wildmenu

" Use <F11> to toggle between 'paste(disables autoindent for pasted content)' and 'nopaste(enables autoindent for pasted content)'
set pastetoggle=<F11>

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
set clipboard=unnamed

" Clone paragraph
nnoremap cp yap<S-}>p

" Switch tabs fast via Shift
nnoremap <S-Right> gt
nnoremap <S-Left> gT

" Switch windows fast via Ctrl
nnoremap <M-Right> <C-w>l
nnoremap <M-Left> <C-w>h
nnoremap <M-Down> <C-w>j
nnoremap <M-Up> <C-w>k

" Align current paragraph
nnoremap <Leader>a =ip

" Split windows
nnoremap <Leader>wv :sp<CR>
nnoremap <Leader>wh :vsp<CR>

" Save and quit Mappings
nnoremap <M-w> :w<CR>
nnoremap <M-q> :q<CR>

" Tabs 
nnoremap <C-t> :tabnew<CR>
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

" shows matching brackets
set showmatch

" Continue comment marker in new lines
set formatoptions+=o

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

" If we reach near bottom/top of screen, automatically scroll

if !&scrolloff
    set scrolloff=5       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
    set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif

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

command! L NERDTree


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Delete without copy
noremap x "_x

nnoremap <Leader>cd :cd %:p:h<CR>

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
command! Vimrc :e $MYVIMRC

" colorscheme
set background=dark
colorscheme frozen "pablo

nnoremap <silent> <M-+> :exe "resize " . (winheight(0) * 9/8)<CR>
nnoremap <silent> <M--> :exe "resize " . (winheight(0) * 8/9)<CR>
nnoremap <silent> + :exe "vertical resize " . (winwidth(0) * 9/8)<CR>
nnoremap <silent> - :exe "vertical resize " . (winwidth(0) * 8/9)<CR>

" Lightline Configuration	
let g:lightline = {	
      \ 'colorscheme': 'one',	
      \ 'active': {	
      \   'left': [ [ 'mode', 'paste' ],	
      \             [ 'readonly', 'filename', 'modified', 'name' ] ]	
      \ },	
      \ 'component': {	
      \   'name': 'VIMenev'	
      \ },	
      \ }

let g:python_host_prog = 'C:/Python27/python.exe'
let g:python3_host_prog = 'C:/Users/Megaport/AppData/Local/Programs/Python/Python36-32/python.exe'

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c

" Required for operations modifying multiple buffers like rename.
set hidden

" set verbosefile=~/.log/vim/verbose.log
" set verbose=15
  set verbose=0
  set verbosefile=



""""""""""""""""""""""""""""
" Ranger style marks command
"
""""""""""""""""""""""""""""
function! Marks()
    marks
    echo('Mark: ')

    " getchar() - prompts user for a single character and returns the chars
    " ascii representation
    " nr2char() - converts ASCII `NUMBER TO CHAR'

    let s:mark = nr2char(getchar())
    " remove the `press any key prompt'
    redraw

    " build a string which uses the `normal' command plus the var holding the
    " mark - then eval it.
    execute "normal! '" . s:mark
endfunction

nnoremap ' :call Marks()<CR>
