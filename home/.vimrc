" Pathogen
execute pathogen#infect()

augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END " }

autocmd BufWritePre * :%s/\s\+$//e

set nocompatible                  " Must come first because it changes other options.

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set wrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

" Fugitive
autocmd QuickFixCmdPost *grep* cwindow

" Colors
set t_Co=256
colorscheme default

let mapleader = ";"

map <leader>i mmgg=G`m<cr> " Indenting the whole file

" Quick saving
imap ;; <Esc>:w<cr>
nmap ;; :w<cr>

" Add debugger line
nmap <leader>d obyebug;;

" Add save_and_open_page line
nmap <leader>sa osave_and_open_page;;

" Comment out visual mode selection
vmap <leader>cc :s/^/# /<cr><leader>h

" Uncomment out visual mode selection
vmap <leader>cu :s/# //<cr>

" Window mappings
map <leader>wo <C-w>v
map <leader>wq <C-w>q
map <leader>w <C-w>w

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" CtrlP
map <leader>g :CtrlP<cr>
map <leader>f :CtrlPBuffer<cr>

" NERDTree
map <leader>no :NERDTreeToggle<cr>
map <leader>nc :NERDTreeClose<cr>

" Search Highlighting
map <leader>h :noh<cr>

" Tslime
let g:rspec_command = 'call Send_to_Tmux("rspec {spec}\n")'

" vim-rspec mappings
map <leader>t :call RunCurrentSpecFile()<cr>
map <leader>s :call RunNearestSpec()<cr>
map <leader>l :call RunLastSpec()<cr>
map <leader>a :call RunAllSpecs()<cr>
