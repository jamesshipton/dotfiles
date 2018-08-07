set nocompatible              " be iMproved, required filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=/Users/jamesshipton/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'jgdavey/tslime.vim'
Plugin 'jamesshipton/vim-rspec'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'strogonoff/vim-coffee-script'
Plugin 'rizzatti/dash.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'ElmCast/elm-vim'
Plugin 'JamshedVesuna/vim-markdown-preview'

call vundle#end()            " required

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

" Comment visual mode selection
" vmap <leader>cc :s/^/# /<cr>:noh<cr>

" Uncomment visual mode selection
" vmap <leader>cu :s/# //<cr>

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

" Page Scroll
map <leader>nn <c-F>
map <leader>p <c-B>

" CtrlP
map <leader>g :CtrlP<cr>
map <leader>f :CtrlPBuffer<cr>
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

" go mappings
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" javascript mappings
autocmd FileType javascript setlocal shiftwidth=4 tabstop=4
autocmd BufRead,BufNewFile *.json setlocal shiftwidth=4 tabstop=4
