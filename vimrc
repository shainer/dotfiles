set nocompatible
filetype off

" {{{ general settings

set number
set browsedir=buffer
set backspace=indent,eol,start

" use The Silver Searcher for :grep if available
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

set textwidth=80
set colorcolumn=+1
set mouse=a

" }}} general settings

" {{{ vundle

source ~/.vimrc.bundles

" }}} vundle

" {{{ custom overrides

set nowrap
set hidden
set nobackup
set nowritebackup
set noswapfile
set expandtab
set tabstop=2
set shiftwidth=2
set foldmethod=marker
set wildignore+=*.o,*.obj,*.bak
set wildignore+=*/.hg/*,*/.git/*,*/.svn/*
set wildignore+=*/node_modules/*

map <A-Left>  :bp<CR>
map <A-Right> :bn<CR>

" }}} custom overrides

" {{{ netrw

let g:netrw_winsize=30
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_hide=1
let g:netrw_liststyle=3
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+'

map <C-e> :Vexplore<CR>

if has('autocmd')
    autocmd FileType netrw set ignorecase
endif

" }}} netrw

" {{{ gui

set guioptions-=t
set guioptions-=T
set guioptions+=g

if has('gui_win32')
    set guifont=Consolas:h12
elseif has('gui_gtk2')
    set guifont=Source\ Code\ Pro\ Light\ 12
endif

if has('autocmd')
    autocmd GUIEnter * set visualbell t_vb=
endif

" }}} gui

" {{{ molokai

let g:molokai_original=1
let g:rehash256=1

syntax enable
colorscheme molokai

if !has('gui_running')
    set background=dark
endif

" }}} molokai

" {{{ airline

let g:airline_powerline_fonts=0
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#syntastic#enabled=1
let g:airline#extensions#whitespace#enabled=1
let g:airline#extensions#whitespace#show_message=1
let g:airline#extensions#whitespace#checks=['indent', 'trailing']

" }}} airline

" {{{ ctrlp

" use The Silver Searcher for ctrlp if available
if executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching=0
else
  let g:ctrlp_clear_cache_on_exit=0
endif

" }}} ctrlp

" {{{ syntastic

let g:syntastic_check_on_open=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'

let g:syntastic_cpp_checkers=['gcc']
let g:syntastic_cpp_compiler='g++'
let g:syntastic_cpp_compiler_options='-std=c++11 -stdlib=libc++'

" }}} syntastic

" {{{ tagbar

if exists(':TagbarToggle') == 1
  nmap <leader>t :TagbarToggle
endif

" }}} tagbar

" {{{ vim-clang-format

let g:clang_format#code_style='google'
let g:clang_format#auto_format=0
let g:clang_format#auto_format_on_insert_leave=0
let g:clang_format#auto_formatexpr=0

" }}} vim-clang-format

" {{{ rust.vim

let g:rustfmt_autosave=1
let g:rustfmt_fail_silently=1

" }}} rust.vim

" {{{ local overrides

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" }}} local overrides
