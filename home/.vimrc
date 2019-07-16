set nocompatible              " be iMproved, required filetype off                  " required

" VIM PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-surround'
Plug 'kien/ctrlp.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'jgdavey/tslime.vim'
Plug 'jamesshipton/vim-rspec'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'strogonoff/vim-coffee-script'
Plug 'rizzatti/dash.vim'
Plug 'tomtom/tcomment_vim'
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'ElmCast/elm-vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ludovicchabant/vim-gutentags'
call plug#end()

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

" Auto-reload buffers when files are changed on disk
set autoread

" Remove trailing whitespace, apart from sql files
" autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * if index(['sql'], &ft) < 0 | :%s/\s\+$//e

" Extra Ruby syntax highlighting
au BufNewFile,BufRead {Capfile} set ft=ruby
au BufNewFile,BufRead {*.arb} set ft=ruby
au BufNewFile,BufRead {*.slim} set ft=ruby
au BufNewFile,BufRead {*.test} set ft=sh

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

set t_vb=                         " No flashing screen
set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile                    " Do not create *.swp files
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set tabstop=2                    " Global tab width.
set shiftwidth=2                 " And again, related.
set expandtab                    " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time

" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set statusline+=%{gutentags#statusline()}

" Colors
set t_Co=256
colorscheme default

let mapleader = ";"

map <leader>i mmgg=G`m<cr> " Indenting the whole file

" Quick saving
imap ;; <Esc>:w<cr>
nmap ;; :w<cr>

" Dash docs
nmap <silent> <leader>d <Plug>DashSearch

" Copy visual mode selection to the clipboard
vmap <leader>y "*y

" Add save_and_open_page line
nmap <leader>sa osave_and_open_page;;
nmap <leader>ss osave_and_open_screenshot;;

" Change surrounding single quotes to double quotes
nmap <leader>cs cs"'

" Change surrounding double quotes to single quotes
nmap <leader>cd cs'"

" Switch between alternate files
nmap <leader>o :A<cr>

" Find matching cucumber step
nmap <leader>m [<C-d>

" markdown preview
let vim_markdown_preview_github=1

" switch to relevant spec files in rails
let g:rails_projections = {
      \ "app/lib/*.rb": { "alternate": "spec/lib/{}_spec.rb" },
      \ "spec/lib/*_spec.rb": { "alternate": "app/lib/{}.rb" },
      \ }

" change mapping for the tcomment plugin - toggle comments
vmap <leader>cc gc

" Highlight lines from cursor
map <leader>v <C-v>

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

" Ruby block split/join
map <leader>bs gS
map <leader>bj gJ

" Page Scroll
map <leader>nn <c-F>
map <leader>p <c-B>

" CtrlP
map <leader>g :CtrlP<cr>
map <leader>f :CtrlPBuffer<cr>
map <leader>z :CtrlPClearCache<cr>
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = '\v[\/](\.bundle|\.git|node_modules|elm|elm-stuff|spec\/vcr_cassettes|tmp)$'

" CTags mappings
map <leader>dd <c-]>
map <leader>ds <c-t>

" NERDTree
map <leader>no :NERDTreeToggle<cr>
map <leader>nc :NERDTreeClose<cr>

" Search Highlighting
map <leader>h :noh<cr>

" Close all buffers in the current tab
map <leader>bb :%bdelete<cr>

" Tslime
let g:rspec_command = 'call Send_to_Tmux("{spec}\n")'

" vim-rspec mappings
map <leader>t :call RunCurrentSpecFile()<cr>
map <leader>s :call RunNearestSpec()<cr>
map <leader>l :call RunLastSpec()<cr>
map <leader>a :call RunAllSpecs()<cr>
map <leader>r :call RunAllRSpecs()<cr>
map <leader>c :call RunAllCucumbers()<cr>

" javascript mappings
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd BufRead,BufNewFile *.json setlocal shiftwidth=2 tabstop=2

" elm mappings
let g:elm_format_autosave = 1

" elixir formatting
let g:mix_format_on_save = 1
