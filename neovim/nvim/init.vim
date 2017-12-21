call plug#begin('~/.vim/plugged')

Plug 'jeetsukumaran/vim-buffergator'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-clang'

call plug#end()

set termguicolors

       set timeout ttimeoutlen=50

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


       " Split windows
       nnoremap <M-v> :sp<CR>
       nnoremap <M-h> :vsp<CR>

       " Close window
       nnoremap <M-q> :q<CR>
       nnoremap <M-w> :w<CR>

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
colorscheme ceudah

let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = '/usr/bin/python3'
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang'
